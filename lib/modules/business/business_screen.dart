import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp_api/components.dart';
import 'package:shopapp_api/layout/news_app/cubit/cubit.dart';
import 'package:shopapp_api/layout/news_app/cubit/states.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {
        // يمكنك إضافة أي استجابة لحالة النجاح أو الخطأ هنا
      },
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        var list = cubit.business; // تأكد من أن businsee يتضمن البيانات

        print('State: $state'); // Debugging
        print('Business data: $list'); // Debugging

        return articleBulider(list);
      },
    );
  }
}
