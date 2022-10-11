import 'package:dio/dio.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:rhea_app/blocs/session/session_bloc.dart';
import 'package:rhea_app/repositories/local/shared_preferences/shared_provider.dart';
import 'package:rhea_app/repositories/network/remote/data_source/authentication/implementation/authenticate_implementation.dart';
import 'package:rhea_app/repositories/network/remote/data_source/end_workout/implementation/end_workout_implementation.dart';
import 'package:rhea_app/repositories/network/remote/data_source/plan/implementation/plan_implementation.dart';
import 'package:rhea_app/repositories/network/remote/data_source/profile/implementation/profile_implementation.dart';
import 'package:rhea_app/repositories/network/remote/data_source/session/implementation/session_implementation.dart';
import 'package:rhea_app/repositories/network/remote/data_source/stage/implementation/stage_implementation.dart';
import 'package:rhea_app/repositories/network/remote/dio_helper.dart';

@GenerateMocks(
  [
    AuthenticateImplementation,
    ProfileImplementation,
    SessionImplementation,
    EndWorkoutImplementation,
    PlanImplementation,
    StageImplementation,
    Storage,
    Dio,
    DioHelper,
    SharedProvider,
    SessionBloc,
  ],
)
class SharedMocks {}
