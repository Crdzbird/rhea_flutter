part of 'stage_bloc.dart';

abstract class StageEvent extends Equatable {
  const StageEvent();

  @override
  List<Object> get props => [];
}

class OnSuccessEvent extends StageEvent {
  const OnSuccessEvent(this.stage);
  final Stage stage;
}

class OnFailureEvent extends StageEvent {
  const OnFailureEvent(this.error);
  final String error;
}

class OnLoadingEvent extends StageEvent {
  const OnLoadingEvent();
}

class OnIdleEvent extends StageEvent {
  const OnIdleEvent();
}
