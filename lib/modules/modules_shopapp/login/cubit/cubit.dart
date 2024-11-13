import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp_api/modules/modules_shopapp/login/cubit/states.dart';
import 'package:shopapp_api/modules/modules_shopapp/shop_login_model.dart';
import 'package:shopapp_api/network/end_points.dart';
import 'package:shopapp_api/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  late ShopLoginModel loginModel ;

  final formKey = GlobalKey<FormState>();


  void userLogin({
    required String email,
    required String password,
  }) async {
    emit(ShopLoginLoadingState());

    try {
      final response = await DioHelper.postDate(
        url: LOGIN,
        data: {
          "email": email,
          "password": password,
        },
      ).then((value)
      {
        print(value.data);
        loginModel = ShopLoginModel.fromJson(value.data);
        print(loginModel.status);
        print(loginModel.date?.token);


        emit(ShopLoginSuccessState(loginModel));
      });

    } catch (error) {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    }
  }

  IconData suffix =Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility(){
    isPassword = !isPassword;

    suffix = isPassword ? Icons.visibility:Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityState());
  }




}
