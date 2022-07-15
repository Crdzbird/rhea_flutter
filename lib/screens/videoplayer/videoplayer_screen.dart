import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhea_app/blocs/video/player/player_bloc.dart';
import 'package:rhea_app/blocs/video/visibility/visibility_cubit.dart';
import 'package:rhea_app/extensions/exercise_extension.dart';
import 'package:rhea_app/models/enums/exercise_type.dart';
import 'package:rhea_app/models/exercise.dart';
import 'package:rhea_app/screens/videoplayer/widgets/circle_timer.dart';
import 'package:rhea_app/screens/videoplayer/widgets/information.dart';
import 'package:rhea_app/screens/videoplayer/widgets/main_controller.dart';
import 'package:rhea_app/screens/videoplayer/widgets/main_timer.dart';
import 'package:rhea_app/screens/videoplayer/widgets/secondary_controller.dart';
import 'package:routemaster/routemaster.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({
    super.key,
    required this.preview,
    required this.stageId,
  });

  final bool preview;
  final String stageId;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    final _exercises = RouteData.of(context).queryParameters['video_exercises'];
    return MultiBlocProvider(
      providers: [
        BlocProvider<VisibilityCubit>(create: (_) => VisibilityCubit()),
        BlocProvider<PlayerBloc>(
          create: (_) => PlayerBloc(
            exercises: _exercises == null || _exercises.isEmpty
                ? const <Exercise>[]
                : Exercise.fromString(_exercises),
          ),
        ),
      ],
      child: _VideoPlayerView(preview: widget.preview, stageId: widget.stageId),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    ); // to re-show bars
    super.dispose();
  }
}

class _VideoPlayerView extends StatelessWidget {
  const _VideoPlayerView({
    required this.preview,
    required this.stageId,
  });
  final bool preview;
  final String stageId;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    //Sleep and video.
    return Scaffold(
      extendBody: true,
      body: BlocBuilder<PlayerBloc, PlayerState>(
        builder: (context, state) {
          return Stack(
            children: [
              GestureDetector(
                onTap: () => context.read<VisibilityCubit>().change(),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black,
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
              if (context
                      .select(
                        (PlayerBloc bloc) => bloc.exercises[bloc.position],
                      )
                      .toExerciseType ==
                  ExerciseType.rest)
                const Center(
                  child: CircleTimer(),
                )
              else
                Positioned(
                  top: 15,
                  left: 20,
                  child: MainTimer(preview: preview),
                ),
              const Positioned(
                bottom: 15,
                left: 20,
                child: Information(),
              ),
              Positioned(
                bottom: 15,
                right: preview
                    ? MediaQuery.of(context).size.width * .472
                    : MediaQuery.of(context).size.width * .35,
                left: preview
                    ? MediaQuery.of(context).size.width * .472
                    : MediaQuery.of(context).size.width * .35,
                child: MainController(preview: preview),
              ),
              Positioned(
                bottom: 15,
                right: 20,
                child: SecondaryController(preview: preview),
              ),
            ],
          );
        },
      ),
    );
  }
}
