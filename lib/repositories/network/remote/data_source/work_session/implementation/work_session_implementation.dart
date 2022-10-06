import 'package:rhea_app/models/enums/preferences_type.dart';
import 'package:rhea_app/models/network/api_result.dart';
import 'package:rhea_app/models/network/network_exceptions.dart';
import 'package:rhea_app/models/work_session.dart';
import 'package:rhea_app/repositories/local/shared_preferences/shared_provider.dart';
import 'package:rhea_app/repositories/network/remote/data_source/work_session/abstract/work_session_abstract.dart';
import 'package:rhea_app/repositories/network/remote/dio_helper.dart';
import 'package:rhea_app/utils/dart_define.dart';

class WorkSessionImplementation extends WorkSessionAbstract {
  @override
  Future<ApiResult<WorkSession>> fetchWorkSession(String workSession) async {
    try {
      final response = await DioHelper.get(
        url: '${DartDefine.rheaUrl}public/session/$workSession',
      );
      final _workSession = WorkSession.fromJson('${response.data}');
      await updateWorkoutOffline(_workSession);
      return ApiResult.success(data: _workSession);
    } catch (e) {
      if (NetworkExceptions.isUnauthorized(e)) {
        await SharedProvider.sharedPreferences.clearAll();
      }
      final _workSessionsJson = await SharedProvider.sharedPreferences
          .readList(key: PreferencesType.sessions.key);
      final _workSessions = WorkSession.fromJsonList(_workSessionsJson);
      if (_workSessions.isNotEmpty) {
        return ApiResult.success(data: _workSessions.first);
      }
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        message: NetworkExceptions.getError(e),
      );
    }
  }

  @override
  Future<void> updateWorkoutOffline(WorkSession workSession) async {
    final sessions = await SharedProvider.sharedPreferences
        .readList(key: PreferencesType.sessions.key);
    if (sessions == null || sessions.isEmpty) {
      SharedProvider.sharedPreferences.writeList(
        key: PreferencesType.sessions.key,
        values: [workSession.toJson],
      );
      return;
    }
    final _session = WorkSession.fromJsonList(sessions);
    final _index =
        _session.indexWhere((element) => element.id == workSession.id);
    if (_index == -1) {
      _session.add(workSession);
      SharedProvider.sharedPreferences.writeList(
        key: PreferencesType.sessions.key,
        values: _session.map((e) => e.toJson).toList(),
      );
      return;
    }
    sessions[_index] = workSession.toJson;
    SharedProvider.sharedPreferences.writeList(
      key: PreferencesType.sessions.key,
      values: _session.map((e) => e.toJson).toList(),
    );
  }
}
