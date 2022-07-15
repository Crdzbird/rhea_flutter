import 'package:rhea_app/models/network/api_result.dart';
import 'package:rhea_app/models/network/network_exceptions.dart';
import 'package:rhea_app/models/work_session.dart';
import 'package:rhea_app/repositories/local/shared_preferences/shared_provider.dart';
import 'package:rhea_app/repositories/network/remote/data_source/work_session/abstract/work_session_abstract.dart';
import 'package:rhea_app/repositories/network/remote/dio_helper.dart';
import 'package:rhea_app/utils/dart_define.dart';

// TODO(crdzbird): Investigate how to use list on preferences.
class WorkSessionImplementation extends WorkSessionAbstract {
  @override
  Future<ApiResult<WorkSession>> fetchWorkSession(String workSession) async {
    try {
      final response = await DioHelper.get(
        url: '${DartDefine.rheaUrl}public/session/$workSession',
      );
      final _workSession = WorkSession.fromJson('${response.data}');
      // SharedProvider.sharedPreferences.write(
      //   key: PreferencesType.session.key,
      //   value: session.toJson,
      // );
      return ApiResult.success(data: _workSession);
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
