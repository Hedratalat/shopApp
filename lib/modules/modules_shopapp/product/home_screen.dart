import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp_api/modules/modules_shopapp/cubit/cubit.dart';
import 'package:shopapp_api/modules/modules_shopapp/cubit/states.dart';
import 'package:shopapp_api/modules/modules_shopapp/shop_categories_model.dart';
import 'package:shopapp_api/modules/modules_shopapp/shop_home_model.dart';
import 'package:shopapp_api/shared/style/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (BuildContext context, ShopStates state) {  },
      builder: (BuildContext context, ShopStates state) {
        return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel !=null && ShopCubit.get(context).categoriesModel !=null ,
            builder: (context) => builderWidget(ShopCubit.get(context).homeModel!,ShopCubit.get(context).categoriesModel! , context), // استخدام `!` بعد التأكد من أنها ليست null
            fallback: (context) => Center(child: CircularProgressIndicator
              (color: defaultColor,),) );
      },
       ) ;
  }



  Widget builderWidget(HomeModel model , CategoriesModel categoriesModel , context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
    
        CarouselSlider(items:
        model.data.banners.map((e) =>
        Image(image: NetworkImage('${e.image}'),
        width: double.infinity,
          fit: BoxFit.cover,
        )
        ).toList() ,
          options: CarouselOptions(
            height: 250,
            initialPage: 0,
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
    
          ),),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start ,
            children: [
              Text('Categories',style:
              TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,),),
              SizedBox(height: 10,),
              Container(
                  height: 100.0,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                      itemBuilder:(context ,index)=>buildCategoryItem(categoriesModel.data.data[index]) ,
                      separatorBuilder: (context , index) => SizedBox(width: 10,),
                      itemCount: categoriesModel.data.data.length),
                ),
              SizedBox(height: 20,),
              Text(
                'New Products',
                style:
              TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,),),
            ],
          ),
        ),
        SizedBox(height: 10,),

        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          childAspectRatio: 1/1.58 ,
          children: List.generate(model.data.products.length,
                  (index)=>buildGridProduct(model.data.products[index], context)),


          ),
        )
      ],
    ),
  );

  Widget buildCategoryItem(DataModel model) => Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(image: NetworkImage(model.image),
        width: 100.0,
        height: 100.0,
        fit: BoxFit.cover,),
      Container(
          color: Colors.black.withOpacity(.8),
          width: 100,
          child: Text(
            model.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
            ),)
      ),
    ],
  );


  Widget buildGridProduct(ProductModel model , context)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage(model.image),
              height: 200,
              width: double.infinity,
            ),
            if(model.discount !=0)
            Container(
              color: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Text('DISCOUNT',
              style: TextStyle(
                fontSize: 8,
                color: Colors.white
              ),),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(width: 5,),
                  if(model.discount !=0)
                  Text(
                    '${model.oldPrice.round()}',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: (){
                   ShopCubit.get(context).changeFavorites(model.id);
                    },
                    icon: CircleAvatar(
                      radius: 15.0,
                      backgroundColor: (ShopCubit.get(context).favorite[model.id] ?? false  )? defaultColor :Colors.grey  ,
                      child: Icon(Icons.favorite_border,
                      size:14 ,),
                    ),),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );


}
