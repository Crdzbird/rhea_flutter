import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:rhea_app/models/enums/preferences_type.dart';
import 'package:rhea_app/models/network/network_exceptions.dart';
import 'package:rhea_app/models/plan.dart';
import 'package:rhea_app/repositories/local/shared_preferences/shared_provider.dart';
import 'package:rhea_app/repositories/network/remote/data_source/plan/implementation/plan_implementation.dart';

part 'plan_state.dart';
part 'plan_event.dart';

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  PlanBloc({required this.planImplementation}) : super(OnIdlePlan()) {
    on<OnFailureEvent>((event, emit) => emit(OnFailedPlan(event.error)));
    on<OnIdleEvent>((event, emit) => emit(OnIdlePlan()));
    on<OnSuccessEvent>((event, emit) => emit(OnSuccessPlan(event.plan)));
    on<OnLoadingEvent>((event, emit) => emit(OnLoadingPlan()));
    fetchPlan();
  }

  final PlanImplementation planImplementation;

  Future<void> fetchPlan() async {
    add(const OnLoadingEvent());
    final result = await planImplementation.fetchPlan();
    await result.when(
      success: (data) async {
        SharedProvider.sharedPreferences.write(
          key: PreferencesType.plan.key,
          value: data.toJson,
        );
        return add(OnSuccessEvent(data));
      },
      failure: (error, _) async {
        if (NetworkExceptions.isUnauthorized(error)) {
          add(OnFailureEvent(error.toString()));
          return;
        }
        final planJson = await SharedProvider.sharedPreferences.read(
          key: PreferencesType.plan.key,
        );
        add(OnSuccessEvent(Plan.fromJson(planJson!)));
      },
    );
  }
}
