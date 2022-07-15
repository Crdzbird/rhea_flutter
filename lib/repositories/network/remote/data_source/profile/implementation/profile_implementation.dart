import 'package:rhea_app/models/network/api_result.dart';
import 'package:rhea_app/models/network/network_exceptions.dart';
import 'package:rhea_app/models/profile.dart';
import 'package:rhea_app/repositories/network/remote/data_source/profile/abstract/profile_abstract.dart';
import 'package:rhea_app/repositories/network/remote/dio_helper.dart';
import 'package:rhea_app/utils/dart_define.dart';

class ProfileImplementation extends ProfileAbstract {
  @override
  Future<ApiResult<Profile>> fetchProfile() async {
    try {
      final response = await DioHelper.get(
        url: '${DartDefine.rheaUrl}public/profile',
      );
      return ApiResult.success(data: Profile.fromJson('${response.data}'));
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        message: NetworkExceptions.getError(e),
      );
    }
  }
}
