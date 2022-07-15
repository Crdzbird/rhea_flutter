import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:rhea_app/blocs/plan/plan_bloc.dart';
import 'package:rhea_app/models/enums/preferences_type.dart';
import 'package:rhea_app/models/network/network_exceptions.dart';
import 'package:rhea_app/models/stage.dart';
import 'package:rhea_app/models/stage_session.dart';
import 'package:rhea_app/repositories/local/shared_preferences/shared_provider.dart';
import 'package:rhea_app/repositories/network/remote/data_source/stage/implementation/stage_implementation.dart';

part 'stage_event.dart';
part 'stage_state.dart';

class StageBloc extends Bloc<StageEvent, StageState> {
  StageBloc({
    required this.stageImplementation,
    required this.planBloc,
  }) : super(OnIdleStage()) {
    on<OnFailureEvent>(
      (event, emit) => emit(OnFailedStage(event.error)),
    );
    on<OnIdleEvent>(
      (event, emit) => emit(OnIdleStage()),
    );
    on<OnSuccessEvent>(
      (event, emit) => emit(OnSuccessStage(event.stage)),
    );
    on<OnLoadingEvent>(
      (event, emit) => emit(OnLoadingStage()),
    );
    planSubscription = planBloc.stream.listen((event) {
      if (event is OnSuccessPlan) {
        fetchStage(event.plan.currentStage);
      }
    });
  }

  final StageImplementation stageImplementation;
  final PlanBloc planBloc;
  StreamSubscription<PlanState>? planSubscription;
  final stageSessions = <StageSession>[];

  Future<void> fetchStage(String stage) async {
    final result = await stageImplementation.fetchStage(stage);
    await result.when(
      success: (data) async {
        SharedProvider.sharedPreferences.write(
          key: PreferencesType.stage.key,
          value: data.toJson,
        );
        add(OnSuccessEvent(data));
      },
      failure: (error, _) async {
        if (NetworkExceptions.isUnauthorized(error)) {
          add(OnFailureEvent(error.toString()));
          return;
        }
        final stageJson = await SharedProvider.sharedPreferences.read(
          key: PreferencesType.stage.key,
        );
        add(OnSuccessEvent(Stage.fromJson(stageJson!)));
      },
    );
  }

  @override
  Future<void> close() {
    planSubscription?.cancel();
    return super.close();
  }
}
