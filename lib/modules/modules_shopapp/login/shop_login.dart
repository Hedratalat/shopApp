import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp_api/components.dart';
import 'package:shopapp_api/constant.dart';
import 'package:shopapp_api/modules/modules_shopapp/login/cubit/cubit.dart';
import 'package:shopapp_api/modules/modules_shopapp/login/cubit/states.dart';
import 'package:shopapp_api/modules/modules_shopapp/register/shop_register.dart';
import 'package:shopapp_api/modules/modules_shopapp/shop_layout/shop_layout.dart';
import 'package:shopapp_api/network/local/cache_helper.dart';
import 'package:shopapp_api/shared/style/colors.dart';

class ShopLogin extends StatefulWidget {
  ShopLogin({super.key});

  @override
  _ShopLoginState createState() => _ShopLoginState();
}

class _ShopLoginState extends State<ShopLogin> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = ShopLoginCubit.get(context);

    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
      listener: (BuildContext context, state) {
        if(state is ShopLoginSuccessState)
        {
            if(state.loginModel.status){
              print(state.loginModel.message);
              print(state.loginModel.date?.token);


              showToasts(
                state: ToastStates.SUCCESS,
                text: state.loginModel.message,
              );
              CacheHelper.saveData(key: 'token',
                value: state.loginModel.date!.token,).then
                ((value)
              {
                token = state.loginModel.date!.token!;
                   navigateAndFinish(context, ShopLayout());
              });

            }else{
              print(state.loginModel.message);
              showToasts(
                text:  state.loginModel.message,
                  state: ToastStates.ERROR);
            }
        }
      },
      builder: (BuildContext context, state) {
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
                        'LOGIN',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        'Login now to browse our hot offers',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 30.0),
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
                      const SizedBox(height: 20.0),
                      defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        label: 'Password',
                          onSubmit:(value){
                            if (cubit.formKey.currentState!.validate()) {
                              cubit.userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          } ,
                        isPassword: ShopLoginCubit.get(context).isPassword ,
                        prefixIcon: Icons.lock_outline,
                        suffixIcon:ShopLoginCubit.get(context).suffix ,
                        suffixPressed: () {
                        ShopLoginCubit.get(context).changePasswordVisibility();
                        },

                        validate: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is too short';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      ConditionalBuilder(
                        condition: state is! ShopLoginLoadingState,
                        builder: (BuildContext context) {
                          return defaultButton(
                            function: () {
                              if (cubit.formKey.currentState!.validate()) {
                                cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            width: double.infinity,
                            backgroud: Colors.deepOrangeAccent,
                            isUpperCase: true,
                            text: 'Login',
                          );
                        },
                        fallback: (BuildContext context) => const Center(
                          child: CircularProgressIndicator(backgroundColor: defaultColor,),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          defaultTextButton(
                            function: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShopRegister(),
                                ),
                              );
                            },
                            buttonText: 'Register',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
