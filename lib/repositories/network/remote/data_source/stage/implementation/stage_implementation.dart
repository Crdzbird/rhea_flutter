import 'package:rhea_app/models/network/api_result.dart';
import 'package:rhea_app/models/network/network_exceptions.dart';
import 'package:rhea_app/models/stage.dart';
import 'package:rhea_app/repositories/network/remote/data_source/stage/abstract/stage_abstract.dart';
import 'package:rhea_app/repositories/network/remote/dio_helper.dart';
import 'package:rhea_app/utils/dart_define.dart';

class StageImplementation extends StageAbstract {
  @override
  Future<ApiResult<Stage>> fetchStage(String? stage) async {
    try {
      final response = await DioHelper.get(
        url: '${DartDefine.rheaUrl}public/stage/$stage',
      );
      return ApiResult.success(data: Stage.fromJson('${response.data}'));
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        message: NetworkExceptions.getError(e),
      );
    }
  }
}
