import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rhea_app/blocs/video/player/player_bloc.dart';
import 'package:rhea_app/blocs/video/visibility/visibility_cubit.dart';
import 'package:rhea_app/extensions/exercise_extension.dart';
import 'package:rhea_app/models/enums/exercise_type.dart';
import 'package:rhea_app/shared/widgets/glassmorphic_container.dart';
import 'package:rhea_app/styles/color.dart';

class SecondaryController extends StatelessWidget {
  const SecondaryController({super.key, required this.preview});
  final bool preview;

  @override
  Widget build(BuildContext context) => Opacity(
        opacity: context.select((VisibilityCubit cubit) => cubit.state) ? 1 : 0,
        child: Row(
          children: [
            if (context
                    .select((PlayerBloc bloc) => bloc.exercise)
                    .toExerciseType ==
                ExerciseType.rest)
              Text(
                context.select((PlayerBloc bloc) => bloc.nextExercise()).name,
                style: Theme.of(context).textTheme.bodyMedium,
              )
            else
              GlassContainer(
                borderRadius: BorderRadius.circular(20),
                shadowStrength: 2,
                opacity: .2,
                blur: 2,
                color: mirage,
                border: Border.all(style: BorderStyle.none),
                child: CircleAvatar(
                  backgroundColor: transparent,
                  child: SvgPicture.asset(
                    'assets/svg/ic_share_tv.svg',
                    color: white,
                    height: 20,
                  ),
                ),
              ),
            const SizedBox(width: 10),
            if (!preview)
              GestureDetector(
                onTap: context
                            .select((PlayerBloc bloc) => bloc.exercise)
                            .toExerciseType ==
                        ExerciseType.rest
                    ? () => context.read<PlayerBloc>().next()
                    : () => context.read<PlayerBloc>().showFinishWorkout(),
                child: GlassContainer(
                  borderRadius: BorderRadius.circular(20),
                  shadowStrength: 2,
                  opacity: .2,
                  blur: 2,
                  color: mirage,
                  border: Border.all(style: BorderStyle.none),
                  child: CircleAvatar(
                    backgroundColor: transparent,
                    child: SvgPicture.asset(
                      (context
                                  .select((PlayerBloc bloc) => bloc.exercise)
                                  .toExerciseType ==
                              ExerciseType.rest)
                          ? 'assets/svg/ic_next.svg'
                          : 'assets/svg/ic_close.svg',
                      color: white,
                      height: 20,
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
}
