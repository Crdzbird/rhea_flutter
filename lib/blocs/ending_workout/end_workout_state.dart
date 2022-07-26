part of 'end_workout_bloc.dart';

abstract class EndWorkoutState extends Equatable {
  const EndWorkoutState();

  @override
  List<Object> get props => [];
}

class OnIdleEndWorkout extends EndWorkoutState {}

class OnLoadingEndWorkout extends EndWorkoutState {}

class OnSuccessEndWorkout extends EndWorkoutState {
  const OnSuccessEndWorkout();
}

class OnFailedEndWorkout extends EndWorkoutState {
  const OnFailedEndWorkout(this.error);
  final String error;
}
