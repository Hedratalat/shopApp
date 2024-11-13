import 'package:flutter/material.dart';
import 'package:shopapp_api/components.dart';
import 'package:shopapp_api/constant.dart';
import 'package:shopapp_api/shared/style/colors.dart';

class SettingScreen extends StatelessWidget {

var nameController = TextEditingController();
var emailController = TextEditingController();
var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          defaultFormField(
              controller: nameController,
              type: TextInputType.name,
              label: 'Hedra Talat',
              prefixIcon: Icons.person,
            validate: (String? value) {
              if (value!.isEmpty) {
                return 'name must not be empty';
              }
              return null; // يجب إرجاع null في حالة النجاح
            },

          ),
          SizedBox(height: 20,),
          defaultFormField(
            controller: emailController,
            type: TextInputType.emailAddress,
            label: 'hedratalat@gmail.com',
            prefixIcon: Icons.email,
            validate: (String? value) {
              if (value!.isEmpty) {
                return 'email must not be empty';
              }
              return null; // يجب إرجاع null في حالة النجاح
            },
          ),
          SizedBox(height: 20,),
          defaultFormField(
            controller: phoneController,
            type: TextInputType.phone,
            label: '011542740553',
            prefixIcon: Icons.phone,
            validate: (String? value) {
              if (value!.isEmpty) {
                return 'phone must not be empty';
              }
              return null; // يجب إرجاع null في حالة النجاح
            },
          ),
          SizedBox(height: 25,),
          defaultButton(
              width: double.infinity,
              backgroud: defaultColor,
              function: (){
            SignOut(context);
              },
              text: 'Logout',
isUpperCase:true              )
        ],
      ),
    );
  }
}
