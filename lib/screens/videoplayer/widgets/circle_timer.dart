import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhea_app/blocs/video/player/player_bloc.dart';
import 'package:rhea_app/blocs/video/visibility/visibility_cubit.dart';
import 'package:rhea_app/extensions/duration_extension.dart';
import 'package:rhea_app/extensions/exercise_extension.dart';
import 'package:rhea_app/l10n/l10n.dart';
import 'package:rhea_app/models/enums/exercise_type.dart';
import 'package:rhea_app/styles/color.dart';

class CircleTimer extends StatelessWidget {
  const CircleTimer({super.key});

  @override
  Widget build(BuildContext context) => Opacity(
        opacity: context.select((VisibilityCubit cubit) => cubit.state) ? 1 : 0,
        child: (context
                    .select((PlayerBloc bloc) => bloc.exercise)
                    .toExerciseType ==
                ExerciseType.rest)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.l10n.rest,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Text(
                    context.l10n.rest_description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 20),
                  CircleAvatar(
                    backgroundColor: mirage,
                    radius: MediaQuery.of(context).size.width * 0.05,
                    child: Text(
                      context
                                  .select(
                                    (PlayerBloc bloc) => bloc.exercise,
                                  )
                                  .toExerciseType ==
                              ExerciseType.rest
                          ? context
                              .watch<PlayerBloc>()
                              .currentRemainingTime
                              .toMinutesOrSecondsOrSeconds
                          : context
                              .watch<PlayerBloc>()
                              .currentDuration
                              .toMinutesOrSecondsOrSeconds,
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: portica,
                              ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )
            : CircleAvatar(
                backgroundColor: mirage,
                radius: MediaQuery.of(context).size.width * 0.05,
                child: Text(
                  context
                              .select(
                                (PlayerBloc bloc) => bloc.exercise,
                              )
                              .toExerciseType ==
                          ExerciseType.rest
                      ? context
                          .watch<PlayerBloc>()
                          .currentRemainingTime
                          .toMinutesOrSecondsOrSeconds
                      : context
                          .watch<PlayerBloc>()
                          .currentDuration
                          .toMinutesOrSecondsOrSeconds,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: portica,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
      );
}
