import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp_api/bloc_observer.dart';
import 'package:shopapp_api/layout/news_app/cubit/cubit.dart';
import 'package:shopapp_api/layout/news_app/cubit/states.dart';
import 'package:shopapp_api/layout/news_app/news_layout.dart';
import 'package:shopapp_api/modules/modules_shopapp/cubit/cubit.dart';
import 'package:shopapp_api/modules/modules_shopapp/login/shop_login.dart';
import 'package:shopapp_api/modules/modules_shopapp/on_boarding/on_boarding.dart';
import 'package:shopapp_api/modules/modules_shopapp/login/cubit/cubit.dart';
import 'package:shopapp_api/modules/modules_shopapp/shop_layout/shop_layout.dart';
import 'package:shopapp_api/network/local/cache_helper.dart';
import 'package:shopapp_api/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();


  bool isDark = CacheHelper.getData(key: 'isDark') ?? false;

  Widget widget;

  bool? onBoarding = CacheHelper.getData(key: 'OnBoarding');
  String token = CacheHelper.getData(key: 'token')??'';
  print(token);

  if (onBoarding != null) {
    if (token.isNotEmpty) {
      widget = ShopLayout();
    } else {
      widget = ShopLogin();
    }
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  MyApp({
    required this.isDark,
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusinessData()
            ..changeAppMode(fromShared: isDark),
        ),
        BlocProvider(create: (_) => ShopLoginCubit()),
        BlocProvider(
          create: (context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
        ),
      ],
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.teal,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                iconTheme: IconThemeData(color: Colors.black),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.teal,
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
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.teal,
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                iconTheme: IconThemeData(color: Colors.white),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.black12,
                  statusBarIconBrightness: Brightness.light,
                ),
                backgroundColor: Colors.black12,
                elevation: 0.0,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colors.black,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.teal,
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
            ),
            themeMode: NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      ),
    );
  }
}
