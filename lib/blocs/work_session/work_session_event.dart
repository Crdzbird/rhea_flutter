part of 'work_session_bloc.dart';

abstract class WorkSessionEvent extends Equatable {
  const WorkSessionEvent();

  @override
  List<Object> get props => [];
}

class OnSuccessEvent extends WorkSessionEvent {
  const OnSuccessEvent(this.workSessions, this.stageSessions);
  final List<WorkSession> workSessions;
  final List<StageSession> stageSessions;
}

class OnFailureEvent extends WorkSessionEvent {
  const OnFailureEvent(this.error);
  final String error;
}

class OnLoadingEvent extends WorkSessionEvent {
  const OnLoadingEvent();
}

class OnIdleEvent extends WorkSessionEvent {
  const OnIdleEvent();
}
