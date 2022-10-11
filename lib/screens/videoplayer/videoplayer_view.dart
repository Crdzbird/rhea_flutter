import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhea_app/blocs/video/player/player_bloc.dart';
import 'package:rhea_app/blocs/video/visibility/visibility_cubit.dart';
import 'package:rhea_app/screens/videoplayer/widgets/information.dart';
import 'package:rhea_app/screens/videoplayer/widgets/main_controller.dart';
import 'package:rhea_app/screens/videoplayer/widgets/secondary_controller.dart';
import 'package:rhea_app/styles/color.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerView extends StatelessWidget {
  const VideoPlayerView({
    super.key,
    required this.preview,
    required this.stageId,
  });
  final bool preview;
  final String stageId;

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBody: true,
        body: BlocConsumer<PlayerBloc, PlayerState>(
          listener: (context, state) {
            if (state is VideoFinishedState) {
              context.read<PlayerBloc>().showCompleteWorkoutDialog(context);
            }
          },
          builder: (context, state) => Stack(
            children: [
              GestureDetector(
                onTap: () => context.read<VisibilityCubit>().change(),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: black,
                  child: AspectRatio(
                    aspectRatio: context
                        .read<PlayerBloc>()
                        .controller!
                        .value
                        .aspectRatio,
                    child: VideoPlayer(
                      context.watch<PlayerBloc>().controller!,
                    ),
                  ),
                ),
              ),
              context
                  .select((PlayerBloc bloc) => bloc.switchComponents(context)),
              const AnimatedPositioned(
                bottom: 15,
                left: 20,
                duration: Duration(milliseconds: 350),
                child: Information(),
              ),
              AnimatedPositioned(
                bottom: 15,
                right: preview
                    ? MediaQuery.of(context).size.width * .472
                    : MediaQuery.of(context).size.width * .35,
                left: preview
                    ? MediaQuery.of(context).size.width * .472
                    : MediaQuery.of(context).size.width * .35,
                duration: const Duration(milliseconds: 350),
                child: MainController(preview: preview),
              ),
              AnimatedPositioned(
                bottom: 15,
                right: 20,
                duration: const Duration(milliseconds: 350),
                child: context.select((PlayerBloc bloc) => bloc.isFinalized())
                    ? const SizedBox.shrink()
                    : SecondaryController(preview: preview),
              ),
            ],
          ),
        ),
      );
}
