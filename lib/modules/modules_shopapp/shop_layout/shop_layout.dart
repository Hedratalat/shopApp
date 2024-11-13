import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp_api/components.dart';
import 'package:shopapp_api/modules/modules_shopapp/cubit/cubit.dart';
import 'package:shopapp_api/modules/modules_shopapp/cubit/states.dart';
import 'package:shopapp_api/modules/modules_shopapp/login/shop_login.dart';
import 'package:shopapp_api/modules/modules_shopapp/search/search_screen.dart';
import 'package:shopapp_api/network/local/cache_helper.dart';
import 'package:shopapp_api/shared/style/colors.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (BuildContext context, ShopStates state) {  },
      builder: (BuildContext context, ShopStates state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Salla'),
            actions: [
              IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder:(context)=>SearchScreen() ));
                  },
                  icon: Icon(Icons.search))
            ],
          ),
          body:
          cubit.bottomScreen[cubit.currentIndex] ,
          bottomNavigationBar: BottomNavigationBar(
            onTap:  (index){
              cubit.changeBottom(index);
            },
              currentIndex: cubit.currentIndex,
              selectedItemColor: defaultColor,
              unselectedItemColor: Colors.grey,
              items:[
                BottomNavigationBarItem(icon: Icon(Icons.home,),label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.apps,),label: 'Categories'),
                BottomNavigationBarItem(icon: Icon(Icons.favorite,),label: 'Favorite'),
                BottomNavigationBarItem(icon: Icon(Icons.settings,),label: 'Setting'),

              ]
          ),
        );
      },
    );
  }

}
