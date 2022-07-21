import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhea_app/blocs/video/player/player_bloc.dart';
import 'package:rhea_app/extensions/duration_extension.dart';
import 'package:rhea_app/extensions/exercise_extension.dart';
import 'package:rhea_app/models/enums/exercise_type.dart';
import 'package:rhea_app/styles/color.dart';

class CircleTimer extends StatelessWidget {
  const CircleTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: mirage,
      radius: MediaQuery.of(context).size.width * 0.05,
      child: Text(
        context
                    .select(
                      (PlayerBloc bloc) => bloc.exercises[bloc.position],
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
    );
  }
}
