import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:rhea_app/models/enums/reason_type.dart';
import 'package:rhea_app/models/network/network_exceptions.dart';
import 'package:rhea_app/models/reason.dart';
import 'package:rhea_app/navigation/routes.dart';
import 'package:rhea_app/repositories/network/remote/data_source/end_workout/implementation/end_workout_implementation.dart';

part 'end_workout_event.dart';
part 'end_workout_state.dart';

class EndWorkoutBloc extends Bloc<EndWorkoutEvent, EndWorkoutState> {
  EndWorkoutBloc({
    required this.endWorkoutImplementation,
  }) : super(OnIdleEndWorkout()) {
    on<OnFailureEvent>(
      (event, emit) => emit(OnFailedEndWorkout(event.error)),
    );
    on<OnIdleEvent>(
      (event, emit) => emit(OnIdleEndWorkout()),
    );
    on<OnSuccessEvent>(
      (event, emit) => emit(const OnSuccessEndWorkout()),
    );
    on<OnLoadingEvent>(
      (event, emit) => emit(OnLoadingEndWorkout()),
    );
  }

  final EndWorkoutImplementation endWorkoutImplementation;

  Future<void> endWorkout(String stage, ReasonType reasonType) async {
    final result = await endWorkoutImplementation.endWorkout(
      stage,
      Reason(reason: reasonType),
    );
    await result.when(
      success: (data) async {
        await routemasterDelegate.pop();
      },
      failure: (error, _) async {
        if (NetworkExceptions.isUnauthorized(error)) {
          add(OnFailureEvent(error.toString()));
          return;
        }
      },
    );
  }
}
