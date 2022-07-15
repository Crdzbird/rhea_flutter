import 'package:rhea_app/models/network/api_result.dart';
import 'package:rhea_app/models/network/network_exceptions.dart';
import 'package:rhea_app/models/plan.dart';
import 'package:rhea_app/repositories/network/remote/data_source/plan/abstract/plan_abstract.dart';
import 'package:rhea_app/repositories/network/remote/dio_helper.dart';
import 'package:rhea_app/utils/dart_define.dart';

class PlanImplementation extends PlanAbstract {
  @override
  Future<ApiResult<Plan>> fetchPlan() async {
    try {
      final response = await DioHelper.get(
        url: '${DartDefine.rheaUrl}public/plan',
      );
      return ApiResult.success(data: Plan.fromJson('${response.data}'));
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        message: NetworkExceptions.getError(e),
      );
    }
  }
}
