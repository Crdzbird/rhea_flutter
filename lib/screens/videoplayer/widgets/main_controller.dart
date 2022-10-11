import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rhea_app/blocs/video/player/player_bloc.dart';
import 'package:rhea_app/blocs/video/visibility/visibility_cubit.dart';
import 'package:rhea_app/extensions/exercise_extension.dart';
import 'package:rhea_app/models/enums/exercise_type.dart';
import 'package:rhea_app/shared/widgets/glassmorphic_container.dart';
import 'package:rhea_app/styles/color.dart';

class MainController extends StatelessWidget {
  const MainController({super.key, required this.preview});
  final bool preview;

  @override
  Widget build(BuildContext context) => Opacity(
        opacity: context.select((VisibilityCubit cubit) => cubit.state) ? 1 : 0,
        child: (context
                    .select((PlayerBloc bloc) => bloc.exercise)
                    .toExerciseType ==
                ExerciseType.rest)
            ? const SizedBox.shrink()
            : GlassContainer(
                height: 40,
                borderRadius: BorderRadius.circular(20),
                shadowStrength: 2,
                opacity: .2,
                blur: 2,
                color: mirage,
                border: Border.all(style: BorderStyle.none),
                child: Container(
                  alignment: preview ? Alignment.center : null,
                  padding: preview
                      ? EdgeInsets.zero
                      : const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!preview)
                        GestureDetector(
                          onTap: () =>
                              context.read<PlayerBloc>().restart(context),
                          onLongPress: () =>
                              context.read<PlayerBloc>().previous(),
                          child: SvgPicture.asset(
                            'assets/svg/ic_back.svg',
                            color: white,
                            height: 20,
                          ),
                        ),
                      GestureDetector(
                        onTap: context
                                .read<PlayerBloc>()
                                .controller!
                                .value
                                .isPlaying
                            ? () => context.read<PlayerBloc>().pause()
                            : () => context.read<PlayerBloc>().play(),
                        child: SvgPicture.asset(
                          context.read<PlayerBloc>().controller!.value.isPlaying
                              ? 'assets/svg/ic_pause.svg'
                              : 'assets/svg/ic_play.svg',
                          color: white,
                          height: 20,
                        ),
                      ),
                      if (!preview)
                        GestureDetector(
                          onTap: () => context.read<PlayerBloc>().next(),
                          child: SvgPicture.asset(
                            'assets/svg/ic_next.svg',
                            color: white,
                            height: 20,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
      );
}
