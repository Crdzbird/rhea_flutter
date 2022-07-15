import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhea_app/blocs/platform/platform_cubit.dart';
import 'package:rhea_app/extensions/exercise_extension.dart';
import 'package:rhea_app/models/enums/exercise_type.dart';
import 'package:rhea_app/models/exercise.dart';
import 'package:rhea_app/screens/stage_detail/widgets/android_list_tile.dart';
import 'package:rhea_app/screens/stage_detail/widgets/ios_list_tile.dart';
import 'package:rhea_app/styles/color.dart';

class ExercisePreview extends StatelessWidget {
  const ExercisePreview({super.key, required this.exercise, this.onTap});
  final Exercise exercise;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) =>
      exercise.toExerciseType == ExerciseType.rest
          ? const SizedBox.shrink()
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .08,
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: linkWater,
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              child: Material(
                borderRadius: BorderRadius.circular(
                  20,
                ),
                color: transparent,
                child: context.read<PlatformCubit>().state.targetPlatform ==
                        PlatformType.android
                    ? AndroidListTile(exercise: exercise, onTap: onTap)
                    : IosListTile(exercise: exercise, onTap: onTap),
              ),
            );
}
