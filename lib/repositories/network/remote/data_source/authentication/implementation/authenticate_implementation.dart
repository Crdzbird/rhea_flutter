import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:rhea_app/models/credentials.dart';
import 'package:rhea_app/models/network/api_result.dart';
import 'package:rhea_app/models/network/network_exceptions.dart';
import 'package:rhea_app/models/session.dart';
import 'package:rhea_app/navigation/routes.dart';
import 'package:rhea_app/repositories/network/remote/data_source/authentication/abstract/authenticate_abstract.dart';
import 'package:rhea_app/repositories/network/remote/dio_helper.dart';
import 'package:rhea_app/utils/dart_define.dart';

class AuthenticateImplementation extends AuthenticateAbstract {
  @override
  Future<ApiResult<Session>> authenticate(Credentials credentials) async {
    try {
      final response = await DioHelper.post(
        url: '${DartDefine.rheaUrl}public/authentication/authenticate',
        data: credentials.toJson,
      );
      return ApiResult.success(data: Session.fromJson('${response.data}'));
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        message: NetworkExceptions.getError(e),
      );
    }
  }

  @override
  Future<void> signOut(String url) async {
    await HydratedBlocOverrides.current?.storage.clear();
    await routemasterDelegate.popUntil((routeData) => routeData.path == '/');
  }
}
