import 'package:rhea_app/models/network/api_result.dart';
import 'package:rhea_app/models/network/network_exceptions.dart';
import 'package:rhea_app/models/reason.dart';
import 'package:rhea_app/repositories/local/shared_preferences/shared_provider.dart';
import 'package:rhea_app/repositories/network/remote/data_source/end_workout/abstract/end_workout_abstract.dart';
import 'package:rhea_app/repositories/network/remote/dio_helper.dart';
import 'package:rhea_app/utils/dart_define.dart';

class EndWorkoutImplementation extends EndWorkoutAbstract {
  @override
  Future<ApiResult<String>> endWorkout(
    String workSession,
    Reason reason,
  ) async {
    try {
      final response = await DioHelper.post(
        url: '${DartDefine.rheaUrl}public/session/$workSession/cancel',
        data: reason.toJson,
      );
      return ApiResult.success(data: '${response.statusCode}');
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
