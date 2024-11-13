import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    // إعداد الـ headers بشكل ديناميكي حسب وجود الـ token
    dio.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
    };

    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postDate({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    // إعداد الـ headers بشكل ديناميكي حسب وجود الـ token
    dio.options.headers = {
      'lang': lang,
      'Authorization':  token??'',
      'Content-Type': 'application/json',
    };

    return dio.post(url, queryParameters: query, data: data);
  }

  static Future<Response> putDate({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    // إعداد الـ headers بشكل ديناميكي حسب وجود الـ token
    dio.options.headers = {
      'lang': lang,
      'Authorization':  token??'',
      'Content-Type': 'application/json',
    };

    return dio.put(url, queryParameters: query, data: data);
  }
}


