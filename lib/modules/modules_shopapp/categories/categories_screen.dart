import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp_api/components.dart';
import 'package:shopapp_api/modules/modules_shopapp/cubit/cubit.dart';
import 'package:shopapp_api/modules/modules_shopapp/cubit/states.dart';
import 'package:shopapp_api/modules/modules_shopapp/shop_categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (BuildContext context, ShopStates state) {  },
      builder: (BuildContext context, ShopStates state) {
        return ListView.separated(
            itemBuilder: (context,index)=>buildCatItem(ShopCubit.get(context).categoriesModel!.data.data[index]),
            separatorBuilder: (context, index)=> myDivider() ,
            itemCount: ShopCubit.get(context).categoriesModel!.data.data.length);
      },
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(image: NetworkImage(model.image),
          width: 80.0,
          height: 80.0,
          fit: BoxFit.cover,),
        SizedBox(width: 20.0,),
        Text(model.name,
          style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,

        ),),
        Spacer(),
        Icon(Icons.arrow_forward_ios)
      ],
    ),
  );
}
