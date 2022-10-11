import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:rhea_app/blocs/stage/stage_bloc.dart';
import 'package:rhea_app/extensions/category_type_extension.dart';
import 'package:rhea_app/extensions/feeling_type_extension.dart';
import 'package:rhea_app/models/stage.dart';
import 'package:rhea_app/models/stage_session.dart';
import 'package:rhea_app/models/work_session.dart';
import 'package:rhea_app/navigation/routes.dart';
import 'package:rhea_app/repositories/network/remote/data_source/work_session/implementation/work_session_implementation.dart';

part 'work_session_event.dart';
part 'work_session_state.dart';

class WorkSessionBloc extends Bloc<WorkSessionEvent, WorkSessionState> {
  WorkSessionBloc({
    required this.workSessionImplementation,
    required this.stageBloc,
  }) : super(OnIdleWorkSession()) {
    on<OnFailureEvent>((event, emit) => emit(OnFailedWorkSession(event.error)));
    on<OnIdleEvent>((event, emit) => emit(OnIdleWorkSession()));
    on<OnSuccessEvent>(
      (event, emit) =>
          emit(OnSuccessWorkSession(event.workSessions, event.stageSessions)),
    );
    on<OnLoadingEvent>((event, emit) => emit(OnLoadingWorkSession()));
    stageSubscription = stageBloc.stream.listen((event) {
      if (event is OnSuccessStage) {
        buildSessions(event.stage);
      }
    });
  }

  final StageBloc stageBloc;
  StreamSubscription<StageState>? stageSubscription;
  final WorkSessionImplementation workSessionImplementation;
  final _stageSessions = <StageSession>[];
  final _workSessions = <WorkSession>[];

  void navigateToStageDetail(WorkSession workSession) =>
      routemasterDelegate.push(
        '/dashboard/stage_detail/${workSession.id}',
        queryParameters: {'workSession': workSession.toJson},
      );

  @override
  Future<void> close() {
    stageSubscription?.cancel();
    return super.close();
  }

  Future<void> buildSessions(Stage stage) async {
    _stageSessions.clear();
    _workSessions.clear();
    await Future.forEach(stage.allSessions, (StageSession e) async {
      final result =
          await workSessionImplementation.fetchWorkSession(e.session);
      result.when(
        success: (data) {
          _workSessions.add(data);
          _stageSessions.add(
            StageSession(
              id: data.id,
              isCompleted: e.isCompleted,
              additionalBreathworkSession: e.additionalBreathworkSession,
              completedAdditionalBreathworkSession:
                  e.completedAdditionalBreathworkSession,
              isActive: e.isActive,
              updateDate: e.updateDate,
              feelingsType: toFeelingEnum(data.feeling),
              completionDate: data.completedTime,
              categoryType: toCategoryEnum(data.sessionType),
              equipments: data.equipments,
              recommendedTime: e.recommendedTime,
              session: data.name,
              sleepQuestions: data.sleepQuestions,
            ),
          );
        },
        failure: (e, ss) {},
      );
    });
    add(OnSuccessEvent(_workSessions, _stageSessions));
  }
}
