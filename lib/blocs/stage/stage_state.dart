part of 'stage_bloc.dart';

abstract class StageState extends Equatable {
  const StageState();

  @override
  List<Object> get props => [];
}

class OnIdleStage extends StageState {}

class OnLoadingStage extends StageState {}

class OnSuccessStage extends StageState {
  const OnSuccessStage(this.stage);
  final Stage stage;
}

class OnFailedStage extends StageState {
  const OnFailedStage(this.error);
  final String error;
}
