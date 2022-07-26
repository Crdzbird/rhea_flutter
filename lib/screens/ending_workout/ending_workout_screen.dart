import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhea_app/blocs/ending_workout/end_workout_bloc.dart';
import 'package:rhea_app/blocs/ending_workout/ending_workout_cubit.dart';
import 'package:rhea_app/extensions/reason_type_extension.dart';
import 'package:rhea_app/l10n/l10n.dart';
import 'package:rhea_app/models/enums/reason_type.dart';
import 'package:rhea_app/repositories/network/remote/data_source/end_workout/implementation/end_workout_implementation.dart';
import 'package:rhea_app/shared/widgets/solid_button.dart';
import 'package:rhea_app/styles/color.dart';

class EndingWorkoutScreen extends StatelessWidget {
  const EndingWorkoutScreen({super.key, required this.stageId});
  final String stageId;

  @override
  Widget build(BuildContext context) => RepositoryProvider(
        create: (context) => EndWorkoutImplementation(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<EndingWorkoutCubit>(
              create: (context) => EndingWorkoutCubit(),
            ),
            BlocProvider<EndWorkoutBloc>(
              create: (context) => EndWorkoutBloc(
                endWorkoutImplementation:
                    context.read<EndWorkoutImplementation>(),
              ),
            )
          ],
          child: _EndingWorkoutScreen(stageId: stageId),
        ),
      );
}

class _EndingWorkoutScreen extends StatelessWidget {
  const _EndingWorkoutScreen({required this.stageId});

  final String stageId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Spacer(),
          Text(
            l10n.you_ended_workout_early,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: biscay,
                  fontWeight: FontWeight.w700,
                ),
            textAlign: TextAlign.center,
          ),
          Text(
            l10n.please_tell_us_why,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: biscay,
                  fontWeight: FontWeight.w600,
                ),
            textAlign: TextAlign.center,
          ),
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) => ChoiceChip(
              tooltip: ReasonType.values[index].l10n(context),
              onSelected: (value) => context
                  .read<EndingWorkoutCubit>()
                  .change(ReasonType.values[index].value),
              labelPadding: const EdgeInsets.symmetric(vertical: 10),
              label: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  ReasonType.values[index].l10n(context),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: context.read<EndingWorkoutCubit>().state ==
                                ReasonType.values[index].value
                            ? white
                            : biscay,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              selected: context.watch<EndingWorkoutCubit>().state ==
                  ReasonType.values[index].value,
              selectedColor: biscay,
              backgroundColor: white,
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: ReasonType.values.length,
          ),
          const Spacer(),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            reverseDuration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) => AnimatedScale(
              duration: const Duration(milliseconds: 300),
              scale: animation.value,
              child: child,
            ),
            child: context.watch<EndingWorkoutCubit>().state.isNotEmpty
                ? SolidButton(
                    background: turquoise,
                    borderRadius: 50,
                    width: MediaQuery.of(context).size.width * 0.8,
                    title: Text(
                      l10n.end_workout,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    isLoading: context.watch<EndWorkoutBloc>().state
                        is OnLoadingEndWorkout,
                    onPressed: () => context.read<EndWorkoutBloc>().endWorkout(
                          stageId,
                          toReasonTypeEnum(
                            context.read<EndingWorkoutCubit>().state,
                          ),
                        ),
                  )
                : const SizedBox.shrink(),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
