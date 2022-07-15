// ignore_for_file: one_member_abstracts

import 'package:rhea_app/models/network/api_result.dart';

abstract class WorkSessionAbstract {
  Future<ApiResult<dynamic>> fetchWorkSession(String workSession);
}
