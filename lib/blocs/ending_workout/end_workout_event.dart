part of 'end_workout_bloc.dart';

abstract class EndWorkoutEvent extends Equatable {
  const EndWorkoutEvent();

  @override
  List<Object> get props => [];
}

class OnSuccessEvent extends EndWorkoutEvent {
  const OnSuccessEvent();
}

class OnFailureEvent extends EndWorkoutEvent {
  const OnFailureEvent(this.error);
  final String error;
}

class OnLoadingEvent extends EndWorkoutEvent {
  const OnLoadingEvent();
}

class OnIdleEvent extends EndWorkoutEvent {
  const OnIdleEvent();
}
