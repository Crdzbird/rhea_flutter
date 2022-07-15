import 'package:dio/dio.dart';
import 'package:rhea_app/models/enums/preferences_type.dart';
import 'package:rhea_app/models/session.dart';
import 'package:rhea_app/repositories/local/shared_preferences/shared_provider.dart';
import 'package:rhea_app/utils/constants.dart';

class DioInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final _options = options;
    final localSession = await SharedProvider.sharedPreferences
        .read(key: PreferencesType.session.key);
    final _session =
        localSession != null ? Session.fromJson(localSession) : const Session();
    switch (options.uri.path) {
      case authentication:
        _options.headers['Content-Type'] = 'application/json';
        _options.headers['ContentType'] = 'application/json';
        break;
      case fetchProfile:
        _options.headers['Content-Type'] = 'application/json';
        _options.headers['ContentType'] = 'application/json';
        _options.headers['Authorization'] = 'Bearer ${_session.authToken}';
        break;
      case password:
        _options.headers['Content-Type'] = 'application/json';
        _options.headers['ContentType'] = 'application/json';
        _options.headers['Authorization'] = 'Bearer ${_session.authToken}';
        break;
      case refresh:
        _options.headers['Content-Type'] = 'application/json';
        _options.headers['ContentType'] = 'application/json';
        break;
      case plan:
        _options.headers['Content-Type'] = 'application/json';
        _options.headers['ContentType'] = 'application/json';
        _options.headers['Authorization'] = 'Bearer ${_session.authToken}';
        break;
      case stage:
        _options.headers['Content-Type'] = 'application/json';
        _options.headers['ContentType'] = 'application/json';
        _options.headers['Authorization'] = 'Bearer ${_session.authToken}';
        break;
      case session:
        _options.headers['Content-Type'] = 'application/json';
        _options.headers['ContentType'] = 'application/json';
        _options.headers['Authorization'] = 'Bearer ${_session.authToken}';
        break;
      default:
        _options.headers['Content-Type'] = 'application/json';
        _options.headers['ContentType'] = 'application/json';
        _options.headers['Authorization'] = 'Bearer ${_session.authToken}';
    }
    handler.next(_options);
  }

  // @override
  // void onError(DioError err, ErrorInterceptorHandler handler) {
  //   super.onError(err, handler);
  //   // ignore: avoid_print
  //   print('DioInterceptor.Error : ${err.message}');
  // }

  // @override
  // void onResponse(
  //   Response<dynamic> response,
  //   ResponseInterceptorHandler handler,
  // ) {
  //   super.onResponse(response, handler);
  //   // ignore: avoid_print
  // }
}
