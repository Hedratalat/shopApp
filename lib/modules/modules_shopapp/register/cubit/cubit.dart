import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp_api/modules/modules_shopapp/login/cubit/states.dart';
import 'package:shopapp_api/modules/modules_shopapp/register/cubit/states.dart';
import 'package:shopapp_api/modules/modules_shopapp/shop_login_model.dart';
import 'package:shopapp_api/network/end_points.dart';
import 'package:shopapp_api/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;
  final formKey = GlobalKey<FormState>();


  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    emit(ShopLRegisterLoadingState());

    try {
      final response = await DioHelper.postDate(
        url: REGISTER,
        data: {
          "name": name,
          "phone": phone,
          "email": email,
          "password": password,
        },
      );

      print(response.data);
      loginModel = ShopLoginModel.fromJson(response.data);
      print(loginModel!.status);
      print(loginModel!.date?.token ?? 'no token available');

      emit(ShopRegisterSuccessState(loginModel!));
    } catch (error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    }
  }

  IconData suffix =Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility(){
    isPassword = !isPassword;

    suffix = isPassword ? Icons.visibility:Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityRegisterState());
  }




}
