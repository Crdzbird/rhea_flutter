import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rhea_app/blocs/video/player/player_bloc.dart';
import 'package:rhea_app/blocs/video/visibility/visibility_cubit.dart';
import 'package:rhea_app/extensions/exercise_extension.dart';
import 'package:rhea_app/models/enums/exercise_type.dart';
import 'package:rhea_app/shared/widgets/glassmorphic_container.dart';
import 'package:rhea_app/styles/color.dart';

class Information extends StatelessWidget {
  const Information({super.key});

  @override
  Widget build(BuildContext context) => Opacity(
        opacity: context.select((VisibilityCubit cubit) => cubit.state) ? 1 : 0,
        child: (context
                    .select((PlayerBloc bloc) => bloc.exercise)
                    .toExerciseType ==
                ExerciseType.rest)
            ? GestureDetector(
                onTap: context.read<PlayerBloc>().controller!.value.isPlaying
                    ? () => context.read<PlayerBloc>().pause()
                    : () => context.read<PlayerBloc>().play(),
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
                      context.watch<PlayerBloc>().controller!.value.isPlaying
                          ? 'assets/svg/ic_pause.svg'
                          : 'assets/svg/ic_play.svg',
                      color: white,
                      height: 20,
                    ),
                  ),
                ),
              )
            : GestureDetector(
                onTap: () => context.read<PlayerBloc>().displayInformation(),
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
                      'assets/svg/ic_information.svg',
                      color: white,
                      height: 20,
                    ),
                  ),
                ),
              ),
      );
}
