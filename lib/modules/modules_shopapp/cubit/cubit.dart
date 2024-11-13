  import 'package:bloc/bloc.dart';
  import 'package:flutter/cupertino.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:shopapp_api/constant.dart';
  import 'package:shopapp_api/modules/modules_shopapp/categories/categories_screen.dart';
  import 'package:shopapp_api/modules/modules_shopapp/cubit/states.dart';
  import 'package:shopapp_api/modules/modules_shopapp/favorites/favorites_screen.dart';
  import 'package:shopapp_api/modules/modules_shopapp/product/home_screen.dart';
  import 'package:shopapp_api/modules/modules_shopapp/setting/setting_screen.dart';
  import 'package:shopapp_api/modules/modules_shopapp/shop_categories_model.dart';
  import 'package:shopapp_api/modules/modules_shopapp/shop_changefavorites_model.dart';
  import 'package:shopapp_api/modules/modules_shopapp/shop_favorite_model.dart';
  import 'package:shopapp_api/modules/modules_shopapp/shop_home_model.dart';
  import 'package:shopapp_api/modules/modules_shopapp/shop_login_model.dart';
  import 'package:shopapp_api/network/end_points.dart';
  import 'package:shopapp_api/network/local/cache_helper.dart';
  import 'package:shopapp_api/network/remote/dio_helper.dart';

  class ShopCubit extends Cubit<ShopStates>
  {
    ShopCubit() : super(ShopInitialState());

    static ShopCubit get(context) => BlocProvider.of(context);

    int currentIndex = 0;

     List<Widget> bottomScreen =
     [
       HomeScreen(),
       CategoriesScreen(),
       FavoritesScreen(),
       SettingScreen(),
     ];

     void changeBottom(int index){
       currentIndex = index;
       emit(ShopChangeBottomNavState());
     }

    HomeModel? homeModel;

     Map<int , bool> favorite = {};

     void getHomeData(){
       emit(ShopLoadingHomeDataState());
       DioHelper.getData(
         url: Home,
         token: token,
       ).then((value){

         homeModel = HomeModel.fromJson(value.data);
         // printFullText(homeModel!.data.banners[0].image);
         // print(homeModel!.status);


         homeModel!.data.products.forEach((element){

           favorite.addAll({
             element.id : element.inFavorites,
           });

         });

         print(favorite.toString());


         emit(ShopSuccessHomeDataState());
       }).catchError((error){
         print(error.toString());
         emit(ShopErrorHomeDataState());
       });
     }

    CategoriesModel? categoriesModel;

    void getCategories(){
      DioHelper.getData(
        url: GET_CATEGORIES,
      ).then((value){

        categoriesModel = CategoriesModel.fromJson(value.data);


        emit(ShopSuccessCategoriesState());
      }).catchError((error){
        print(error.toString());
        emit(ShopErrorCategoriesState());
      });
    }

       late ChangeFavoritesModel changeFavoritesModel;

    void changeFavorites(int productId) {
      favorite[productId] = !favorite[productId]!;
      emit(ShopSuccessChangeFavoritesState());
      DioHelper.postDate(
        url: FAVORITES,
        data: {'product_id': productId},
        token: token,

      ).then((value) {
        changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
        print(value.data);
        emit(ShopSuccessChangeFavoritesState());

      }).catchError((error) {
        print(error.toString());
        emit(ShopErrorChangeFavoritesState());
      });
    }
  // دا الكود الي بيظهر الخطا ان token is missing or expired
  // void changeFavorites(int productId, dynamic context) {
  //   // التحقق أولاً إذا كان التوكن فارغ أو منتهي
  //   if (token.isEmpty) {
  //     print("Token is missing or expired.");
  //     return; // لا تتابع العملية إذا كان التوكن غير موجود أو منتهي
  //   }
  //
  //   bool isFavorite = ShopCubit.get(context).favorite[productId] ?? false;
  //
  //   // تغيير حالة المفضلة محليًا في التطبيق
  //   ShopCubit.get(context).favorite[productId] = !isFavorite;
  //
  //   // إرسال التغيير إلى الـ API
  //   DioHelper.postDate(
  //     url: FAVORITES,
  //     data: {
  //       'product_id': productId,
  //       'is_favorite': !isFavorite, // حالة الـ favorite الجديدة
  //     },
  //     token: token,
  //   ).then((value) {
  //     if (value.data['status'] == true) {
  //       print("Favorite status updated successfully!");
  //       emit(ShopSuccessChangeFavoritesState());
  //     } else {
  //       print("API Error: ${value.data['message']}");  // طباعة رسالة من السيرفر
  //       emit(ShopErrorChangeFavoritesState());
  //     }
  //   }).catchError((error) {
  //     print("Error: $error");  // طباعة الخطأ الكامل
  //     emit(ShopErrorChangeFavoritesState());
  //   });
  // }
    FavoritesModel? favoritesModel;

    void getFavorites(){
      DioHelper.getData(
        url: FAVORITES,
        token: token
      ).then((value){

        favoritesModel = FavoritesModel.fromJson(value.data);
        printFullText(value.data.toString());


        emit(ShopSuccessGetFavoritesState());
      }).catchError((error){
        print(error.toString());
        emit(ShopErrorGetFavoritesState());
      });
    }


    ShopLoginModel? userModel;

    void getUserData(){
      emit(ShopLoadingUserDataState());
      DioHelper.getData(
          url: PROFILE,
          token: token
      ).then((value){

        userModel = ShopLoginModel.fromJson(value.data);
        print('userModel: ${userModel?.date}');
        print('userModel name: ${userModel?.date?.name}');


        emit(ShopSuccessUserDataState());
      }).catchError((error){
        print(error.toString());
        emit(ShopErrorUserDataState());
      });
    }



  }