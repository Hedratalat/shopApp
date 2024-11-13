import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp_api/components.dart';
import 'package:shopapp_api/constant.dart';
import 'package:shopapp_api/modules/modules_shopapp/register/cubit/cubit.dart';
import 'package:shopapp_api/modules/modules_shopapp/register/cubit/states.dart';
import 'package:shopapp_api/modules/modules_shopapp/shop_layout/shop_layout.dart';
import 'package:shopapp_api/network/local/cache_helper.dart';
import 'package:shopapp_api/shared/style/colors.dart';

class ShopRegister extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (BuildContext context, Object? state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status) {
              print(state.loginModel.message);
              print(state.loginModel.date?.token);

              showToasts(
                state: ToastStates.SUCCESS,
                text: state.loginModel.message,
              );

              if (state.loginModel.date?.token != null) {
                CacheHelper.saveData(
                  key: 'token',
                  value: state.loginModel.date?.token,
                ).then((value) {
                  token = state.loginModel.date!.token!;
                  navigateAndFinish(context, ShopLayout());
                });
              } else {
                print("Token is null");
                showToasts(
                  text: "Token not received. Please try again.",
                  state: ToastStates.ERROR,
                );
              }
            } else {
              print(state.loginModel.message);
              showToasts(
                text: state.loginModel.message,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (BuildContext context, state) {
          final cubit = ShopRegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: cubit.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          'Register now to browse our hot offers',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          label: 'Your Name',
                          prefixIcon: Icons.person,
                          validate: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefixIcon: Icons.email_outlined,
                          validate: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: 'Phone',
                          prefixIcon: Icons.phone,
                          validate: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          label: 'Password',
                          isPassword: ShopRegisterCubit.get(context).isPassword,
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: ShopRegisterCubit.get(context).suffix,
                          suffixPressed: () {
                            ShopRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          validate: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is too short';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30.0),
                        ConditionalBuilder(
                          condition: state is! ShopLRegisterLoadingState,
                          builder: (BuildContext context) {
                            return defaultButton(
                              function: () {
                                if (cubit.formKey.currentState!.validate()) {
                                  cubit.userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              width: double.infinity,
                              backgroud: Colors.deepOrangeAccent,
                              isUpperCase: true,
                              text: 'Register',
                            );
                          },
                          fallback: (BuildContext context) => const Center(
                            child: CircularProgressIndicator(
                              backgroundColor: defaultColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
