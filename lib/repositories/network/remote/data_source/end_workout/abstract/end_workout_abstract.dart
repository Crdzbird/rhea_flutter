// ignore_for_file: one_member_abstracts

import 'package:rhea_app/models/network/api_result.dart';
import 'package:rhea_app/models/reason.dart';

abstract class EndWorkoutAbstract {
  Future<ApiResult<dynamic>> endWorkout(String workSession, Reason reason);
}
