import 'package:rhea_app/models/enums/preferences_type.dart';
import 'package:rhea_app/models/network/api_result.dart';
import 'package:rhea_app/models/network/network_exceptions.dart';
import 'package:rhea_app/models/session.dart';
import 'package:rhea_app/repositories/local/shared_preferences/shared_provider.dart';
import 'package:rhea_app/repositories/network/remote/data_source/session/abstract/session_abstract.dart';
import 'package:rhea_app/repositories/network/remote/dio_helper.dart';
import 'package:rhea_app/utils/dart_define.dart';

class SessionImplementation extends SessionAbstract {
  @override
  Future<ApiResult<Session>> refreshToken() async {
    try {
      final localSession = await SharedProvider.sharedPreferences
          .read(key: PreferencesType.session.key);
      if (localSession == null || localSession.isEmpty) {
        return const ApiResult.failure(
          error: NetworkExceptions.unauthorizedRequest(),
        );
      }
      var session = Session.fromJson(localSession);
      final response = await DioHelper.post(
        url: '${DartDefine.rheaUrl}public/authentication/refresh',
        data: session.toJson,
      );
      session = Session.fromJson('${response.data}');
      SharedProvider.sharedPreferences.write(
        key: PreferencesType.session.key,
        value: session.toJson,
      );
      return ApiResult.success(data: session);
    } catch (e) {
      if (NetworkExceptions.isUnauthorized(e)) {
        await SharedProvider.sharedPreferences.clearAll();
      }
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        message: NetworkExceptions.getError(e),
      );
    }
  }
}
