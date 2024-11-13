import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp_api/components.dart';
import 'package:shopapp_api/modules/modules_shopapp/cubit/cubit.dart';
import 'package:shopapp_api/modules/modules_shopapp/cubit/states.dart';
import 'package:shopapp_api/modules/modules_shopapp/shop_favorite_model.dart';
import 'package:shopapp_api/shared/style/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, ShopStates state) {},
      builder: (BuildContext context, ShopStates state) {
        var favoritesModel = ShopCubit.get(context).favoritesModel;

        if (favoritesModel == null || favoritesModel.data == null) {
          // إذا كانت `favoritesModel` أو `data` غير متاحة، يمكن عرض مؤشر تحميل
          return Center(child: CircularProgressIndicator());
        }

        return ListView.separated(
          itemBuilder: (context, index) {
            var item = favoritesModel.data!.data[index];
            return buildFavItem(item, context);
          },
          separatorBuilder: (context, index) => myDivider(),
          itemCount: favoritesModel.data!.data.length,
        );
      },
    );
  }

  Widget buildFavItem(DataItem model, context) {
    var product = model.product;
    if (product == null) {
      return SizedBox(); // عرض عنصر فارغ إذا كان `product` غير متاح
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: <Widget>[
                Image(
                  image: NetworkImage(product.image),
                  fit: BoxFit.cover,
                  height: 120,
                  width: 120,
                ),
                if (product.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(fontSize: 8, color: Colors.white),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        product.price.toString(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(width: 5),
                      if (product.discount != 0)
                        Text(
                          product.oldPrice.toString(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.product!.id);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor: ShopCubit.get(context).favorite[model.product!.id] == true
                              ? defaultColor
                              : Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            size: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
