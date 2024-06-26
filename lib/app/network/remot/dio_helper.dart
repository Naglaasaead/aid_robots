import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async {
    return await dio.get(url , queryParameters: query);
  }



  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query, // Optional parameter
    required Map<String, dynamic> data,
  }) async {
    return await dio.post(url, queryParameters: query, data: data);
  }
}
