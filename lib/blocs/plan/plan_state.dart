part of 'plan_bloc.dart';

abstract class PlanState extends Equatable {
  const PlanState();

  @override
  List<Object> get props => [];
}

class OnIdlePlan extends PlanState {}

class OnLoadingPlan extends PlanState {}

class OnSuccessPlan extends PlanState {
  const OnSuccessPlan(this.plan);
  final Plan plan;
}

class OnFailedPlan extends PlanState {
  const OnFailedPlan(this.error);
  final String error;
}
