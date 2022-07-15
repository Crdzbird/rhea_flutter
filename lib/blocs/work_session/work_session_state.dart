part of 'work_session_bloc.dart';

abstract class WorkSessionState extends Equatable {
  const WorkSessionState();

  @override
  List<Object> get props => [];
}

class OnIdleWorkSession extends WorkSessionState {}

class OnLoadingWorkSession extends WorkSessionState {}

class OnSuccessWorkSession extends WorkSessionState {
  const OnSuccessWorkSession(this.workSessions, this.stageSessions);
  final List<WorkSession> workSessions;
  final List<StageSession> stageSessions;
}

class OnFailedWorkSession extends WorkSessionState {
  const OnFailedWorkSession(this.error);
  final String error;
}
