import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhea_app/blocs/video/player/player_bloc.dart';
import 'package:rhea_app/blocs/video/visibility/visibility_cubit.dart';
import 'package:rhea_app/models/exercise.dart';
import 'package:rhea_app/screens/videoplayer/videoplayer_view.dart';
import 'package:routemaster/routemaster.dart';

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
            preview: widget.preview,
          ),
        ),
      ],
      child: VideoPlayerView(preview: widget.preview, stageId: widget.stageId),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
}
