import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopapp_api/shared/style/colors.dart';

ThemeData darkThem = ThemeData(
  primaryColor: defaultColor,
  primarySwatch:Colors.teal ,
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle:TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,

    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.black12, // لون شريط الحالة
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: Colors.black12,
    elevation: 0.0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
  ),
  scaffoldBackgroundColor: Colors.black12,
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
) ;

ThemeData lightThem = ThemeData(
  primaryColor: defaultColor,
  primarySwatch:Colors.teal ,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle:TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white, // لون شريط الحالة
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    type: BottomNavigationBarType.fixed,
    selectedItemColor:defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),

);