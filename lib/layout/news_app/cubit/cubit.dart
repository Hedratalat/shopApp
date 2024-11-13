import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shopapp_api/layout/news_app/cubit/states.dart';
import 'package:shopapp_api/modules/business/business_screen.dart';
import 'package:shopapp_api/modules/top_news/top_sreen.dart';
import 'package:shopapp_api/network/local/cache_helper.dart'; // استيراد مكتبة Dio

class NewsCubit extends Cubit<NewsStates> {


  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  bool isDark = false;


  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.article),
      label: 'News',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.trending_up_outlined),
      label: 'Trend News',
    ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    TopNewsScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if(index ==1)
      getTopNewsData();
    emit(NewsBottomNavState());
  }

  List<dynamic> business = []; // تأكد من استخدام الاسم الصحيح

  Future<void> getBusinessData() async {
    emit(NewsGetBusinessLoadingState());

    try {
      // استخدام Dio لعمل الطلب لأخبار الأعمال فقط
      final response = await Dio().get(
          'https://newsdata.io/api/1/news?apikey=pub_571087c68d84e03a0b0b0eee9e1976408063f&country=eg&category=business'
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['status'] == 'success' && data['results'] != null) {
          // تحديث قائمة المقالات
          business = data['results']; // استخدام الاسم الصحيح للقائمة
          emit(NewsGetBusinessSuccessState(business)); // الانتقال إلى حالة النجاح
        } else {
          emit(NewsGetBusinessErrorState('No results found'));
        }
      } else {
        emit(NewsGetBusinessErrorState('Failed to fetch data'));
      }
    } catch (e) {
      emit(NewsGetBusinessErrorState(e.toString())); // التعامل مع الاستثناءات
    }
  }

  List<dynamic> TopNews = []; // تأكد من استخدام الاسم الصحيح

  Future<void> getTopNewsData() async {
    emit(NewsGetTopNewsLoadingState());

    if(TopNews.length == 0){
      try {
        // استخدام Dio لعمل الطلب لأخبار الأعمال فقط
        final response = await Dio().get(
            'https://newsdata.io/api/1/news?apikey=pub_571087c68d84e03a0b0b0eee9e1976408063f&country=eg&category=top'
        );

        if (response.statusCode == 200) {
          final data = response.data;
          if (data['status'] == 'success' && data['results'] != null) {
            // تحديث قائمة المقالات
            TopNews = data['results']; // استخدام الاسم الصحيح للقائمة
            emit(NewsGetTopNewsSuccessState(TopNews)); // الانتقال إلى حالة النجاح
          } else {
            emit(NewsGetTopNewsErrorState('No results found'));
          }
        } else {
          emit(NewsGetTopNewsErrorState('Failed to fetch data'));
        }
      } catch (e) {
        emit(NewsGetTopNewsErrorState(e.toString())); // التعامل مع الاستثناءات
      }
    }else{
      emit(NewsGetTopNewsSuccessState(TopNews));
    }
  }



  void updateDate({required String status, required id}) {
    // اكتب هنا تنفيذ الدالة حسب الحاجة
    // مثال على طباعة المعلومات للتأكد من العمل
    print('Update data with status: $status and id: $id');
  }

  void deletDate({required id}) {
    // اكتب هنا تنفيذ الدالة حسب الحاجة
    // مثال على طباعة المعلومات للتأكد من العمل
    print('Delete data with id: $id');
  }


  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}