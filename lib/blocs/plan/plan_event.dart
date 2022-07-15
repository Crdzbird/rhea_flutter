part of 'plan_bloc.dart';

abstract class PlanEvent extends Equatable {
  const PlanEvent();

  @override
  List<Object> get props => [];
}

class OnSuccessEvent extends PlanEvent {
  const OnSuccessEvent(this.plan);
  final Plan plan;
}

class OnFailureEvent extends PlanEvent {
  const OnFailureEvent(this.error);
  final String error;
}

class OnLoadingEvent extends PlanEvent {
  const OnLoadingEvent();
}

class OnIdleEvent extends PlanEvent {
  const OnIdleEvent();
}
