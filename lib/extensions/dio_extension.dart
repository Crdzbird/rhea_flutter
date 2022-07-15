import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:rhea_app/repositories/network/dio_interceptor.dart';

extension DioInterceptors on Dio {
  void addInterceptors() {
    final loggerInterceptor = PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      compact: false,
    );
    interceptors.add(loggerInterceptor);
  }

  void addWatcher() => interceptors.add(DioInterceptor());
}
