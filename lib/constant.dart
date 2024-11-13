// https://newsdata.io/api/1/news?apikey=pub_571087c68d84e03a0b0b0eee9e1976408063f&country=eg&category=business,top

import 'package:shopapp_api/components.dart';
import 'package:shopapp_api/modules/modules_shopapp/login/shop_login.dart';
import 'package:shopapp_api/network/local/cache_helper.dart';

void SignOut(context){
  CacheHelper.removeDate(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(context, ShopLogin());
    }
  });
}

void printFullText(String text){
  final pattern = RegExp('.{1,1800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token ='';