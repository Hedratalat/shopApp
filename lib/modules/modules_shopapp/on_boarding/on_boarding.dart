import 'package:flutter/material.dart';
import 'package:shopapp_api/components.dart';
import 'package:shopapp_api/modules/modules_shopapp/login/shop_login.dart';
import 'package:shopapp_api/network/local/cache_helper.dart';
import 'package:shopapp_api/shared/style/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,

  });
}



class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding =  [
    BoardingModel(
        image:'assets/images/e-commerce-omnichannel-online-shopping-sales-retail-online-shop-ee229d3d56157788baad990bef965502.png',
        title: 'On Board 1 Title',
        body: 'On Board 1 Body'
    ),
    BoardingModel(
        image:'assets/images/e-commerce-omnichannel-online-shopping-sales-retail-online-shop-ee229d3d56157788baad990bef965502.png',
        title: 'On Board 2 Title',
        body: 'On Board 2 Body'
    ),
    BoardingModel(
        image:'assets/images/e-commerce-omnichannel-online-shopping-sales-retail-online-shop-ee229d3d56157788baad990bef965502.png',
        title: 'On Board 3 Title',
        body: 'On Board 3 Body'
    ),
  ];

  bool isLast =false;

  void submit() {
    CacheHelper.saveData(
      key: 'OnBoarding', // تأكد من كتابة المفتاح بشكل صحيح
      value: false,
    ).then((value) {
      if (value) {
        navigateAndFinish(context, ShopLogin());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              function:submit,
              buttonText: 'skip')
        ],
      ),
      body:Column(
        children: [
          Expanded(
            child: PageView.builder(
              physics: BouncingScrollPhysics(),
              onPageChanged: (int index){
                if(index == boarding.length -1){
                  setState(() {
                    isLast = true;
                  } );
                }else{

                  setState(() {
                    isLast = false;
                  });
                }
              },
              controller: boardController,
              itemBuilder: (context,index)=> buildBoardingItem(boarding[index]),
              itemCount: boarding.length,
            ),
          ),
          SizedBox(height:40.0 ,),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                SmoothPageIndicator(controller: boardController,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: defaultColor,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5,

                    ),
                    count: boarding.length),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 17.0),
                  child: FloatingActionButton(onPressed: ()
                  {
                    if(isLast){
                      submit();
                    }else{
                      boardController.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }

                  },
                    backgroundColor: Colors.deepOrangeAccent,
                    shape: CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child:Icon(Icons.arrow_forward_ios,
                      color: Colors.white,) ,),
                )
              ],
            ),
          ),


        ],
      ) ,
    );
  }

  Widget buildBoardingItem(BoardingModel model) =>  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded
        (child: Image(image: AssetImage('${model.image}')

      ),
      ),
      SizedBox(height: 30.0,),
      Text('${model.title}',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),),
      SizedBox(height: 15.0,),
      Text('${model.body}',
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),),

      SizedBox(height: 30.0,),

    ],
  );
}
