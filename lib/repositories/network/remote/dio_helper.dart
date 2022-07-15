import 'package:dio/dio.dart';
import 'package:rhea_app/extensions/dio_extension.dart';
import 'package:rhea_app/utils/dart_define.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        sendTimeout: DartDefine.networkTimeout,
      ),
    );
    dio
      ..addInterceptors()
      ..addWatcher();
  }

  static Future<Response<dynamic>> get({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async =>
      dio.get(
        url,
        queryParameters: query,
      );

  static Future<Response<dynamic>> post({
    required String url,
    Map<String, dynamic>? query,
    required String data,
  }) async =>
      dio.post(
        url,
        queryParameters: query,
        data: data,
      );

  static Future<Response<dynamic>> put({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
  }) async =>
      dio.put(
        url,
        queryParameters: query,
        data: data,
      );
}
