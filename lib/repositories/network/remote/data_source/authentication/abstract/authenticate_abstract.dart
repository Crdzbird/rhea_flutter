import 'package:rhea_app/models/credentials.dart';
import 'package:rhea_app/models/network/api_result.dart';

abstract class AuthenticateAbstract {
  Future<ApiResult<dynamic>> authenticate(Credentials credentials);
  Future<void> signOut(String url);
}
