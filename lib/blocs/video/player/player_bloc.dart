import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rhea_app/extensions/exercise_extension.dart';
import 'package:rhea_app/l10n/l10n.dart';
import 'package:rhea_app/models/enums/exercise_type.dart';
import 'package:rhea_app/models/exercise.dart';
import 'package:rhea_app/navigation/routes.dart';
import 'package:rhea_app/screens/videoplayer/widgets/circle_timer.dart';
import 'package:rhea_app/screens/videoplayer/widgets/main_timer.dart';
import 'package:rhea_app/shared/widgets/dialog/rhea_dialog.dart';
import 'package:rhea_app/shared/widgets/solid_button.dart';
import 'package:rhea_app/styles/color.dart';
import 'package:video_player/video_player.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc({
    required this.exercises,
    required this.preview,
  }) : super(VideoInitState()) {
    on<VideoInitializeEvent>(_videoPlayerInit);
    on<VideoPlayEvent>(_videoPlayerPlay);
    on<VideoPauseEvent>(_videoPlayerPause);
    on<VideoPositionEvent>((event, emit) {
      emit(VideoPositionState(duration: event.duration));
    });
    on<VideoPlayCompletedEvent>(_videoPlayerPlayCompleted);
    init();
  }

  final List<Exercise> exercises;
  Exercise? _exercise;
  final bool preview;
  Exercise get exercise => _exercise ?? const Exercise();
  Duration _totalDuration = Duration.zero;
  Duration _fixedDuration = Duration.zero;
  int _position = 46;
  int get position => _position;
  double _progress = 0;
  double get progress => _progress;
  Duration _currentDuration = Duration.zero;
  Duration _currentRemainingTime = Duration.zero;
  Duration _totalRemainingTime = Duration.zero;
  Duration _passedTime = Duration.zero;
  Duration get currentRemainingTime => _currentRemainingTime;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;
  Duration get totalRemainingTime => _totalRemainingTime;
  Duration get passedTime => _passedTime;
  VideoPlayerController? _controller;
  VideoPlayerController? get controller => _controller;

  final Queue<Duration> seekDequeBuffer = Queue();

  bool isInitialized() => _controller?.value.isInitialized ?? false;
  bool _isVideoFinished = false;
  bool get isVideoFinished => _isVideoFinished;

  void init() {
    _exercise = exercises[_position];
    _controller = VideoPlayerController.network(
      exercise.videoUrl,
      formatHint: VideoFormat.hls,
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );
    _controller?.addListener(checkVideo);

    _controller?.initialize();
    var _seconds = 0;
    var _fixedSeconds = 0;
    var _passedSeconds = 0;
    exercises
        .getRange(0, _position)
        .forEach((element) => _passedSeconds += element.duration);
    for (final element in exercises.skip(_position).toList()) {
      if (_position == 0) {
        _fixedSeconds += element.duration;
      }
      _seconds += element.duration;
    }
    if (position == 0) {
      _fixedDuration = Duration(seconds: _fixedSeconds);
    }
    _passedTime = Duration(seconds: _passedSeconds);
    _totalDuration = Duration(seconds: _seconds);
  }

  bool isFinalized() => _position == exercises.length - 1;

  Exercise nextExercise() => exercises[_position + 1];

  void _videoPlayerInit(
    VideoInitializeEvent event,
    Emitter<PlayerState> emit,
  ) =>
      emit(VideoInitState());

  Future<void> _videoPlayerPlayCompleted(
    VideoPlayCompletedEvent event,
    Emitter<PlayerState> emit,
  ) async {
    _controller?.removeListener(checkVideo);
    emit(VideoFinishedState());
  }

  void _videoPlayerPlay(VideoPlayEvent event, Emitter<PlayerState> emit) {
    _controller?.play();
    emit(VideoPlayingState(duration: _controller!.value.position));
  }

  void _videoPlayerPause(VideoPauseEvent event, Emitter<PlayerState> emit) {
    _controller?.pause();
    emit(VideoPausedState(duration: _controller!.value.position));
  }

  void play() =>
      add(VideoPlayEvent(currentDuration: _controller!.value.position));

  void pause() =>
      add(VideoPauseEvent(currentDuration: _controller!.value.position));

  void restart() {
    if (_position + 1 < exercises.length) {
      ScaffoldMessenger.of(navigatorKey.currentState!.context).showSnackBar(
        SnackBar(
          content: Text(
            navigatorKey.currentContext!.l10n.long_press_back,
            textAlign: TextAlign.center,
          ),
          margin: const EdgeInsetsDirectional.only(
            bottom: 10,
            start: 10,
            end: 10,
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
    _controller?.seekTo(Duration.zero);
    _controller?.play();
  }

  void previous() {
    if (_position > 0) {
      _position--;
      init();
      play();
    }
  }

  void next() {
    if (_position + 1 < exercises.length) {
      _position++; // TODO(crdzbird): 47 final
      init();
      play();
      return;
    }
  }

  Future<void> checkVideo() async {
    _currentDuration = _controller!.value.position;
    _currentRemainingTime = _controller!.value.duration - _currentDuration;
    _totalRemainingTime = _totalDuration - _currentDuration;
    _progress = double.parse(
      ((_currentDuration + _passedTime).inSeconds / _fixedDuration.inSeconds)
          .toStringAsFixed(3),
    );
    add(VideoPositionEvent(duration: _controller!.value.position));
    if (_controller != null &&
        _controller!.value.isInitialized &&
        _controller?.value.position == _controller?.value.duration) {
      _isVideoFinished = true;
      if (_position + 1 < exercises.length && !preview) {
        _position++;
        init();
        play();
        return;
      }
      _isVideoFinished = true;
      if (isFinalized()) {
        add(VideoPlayCompletedEvent());
      }
    }
  }

  Widget switchComponents(BuildContext context) {
    if (exercise.toExerciseType == ExerciseType.rest) {
      return const Center(
        child: CircleTimer(),
      );
    }
    return AnimatedPositioned(
      top: 15,
      left: 20,
      duration: const Duration(milliseconds: 350),
      child: MainTimer(preview: preview),
    );
  }

  Future<void> displayInformation(BuildContext context) async => showRheaDialog(
        navigatorKey.currentState!.context,
        title: Text(
          exercise.name,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: biscay,
              ),
          textAlign: TextAlign.center,
        ),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...exercise.previewDescription.map(
                (e) => Flexible(
                  child: Text(
                    '$e\n',
                    style: Theme.of(navigatorKey.currentContext!)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                          color: biscay,
                          fontFamily: 'Polar',
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[const SizedBox.shrink()],
      );

  Future<void> showCompleteWorkoutDialog(BuildContext context) async {
    final result = await showRheaDialog(
      context,
      dismissible: false,
      title: Text(
        context.l10n.exercise_completed,
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: biscay,
            ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        context.l10n.session_completed,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: biscay,
            ),
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        SolidButton(
          width: MediaQuery.of(context).size.width * 0.3,
          title: Text(
            context.l10n.go_again,
            textAlign: TextAlign.center,
          ),
          borderRadius: 30,
          background: persimmom,
          onPressed: () => Navigator.of(context).pop(false),
        ),
        SolidButton(
          width: MediaQuery.of(context).size.width * 0.3,
          title: Text(
            context.l10n.finish,
            textAlign: TextAlign.center,
          ),
          borderRadius: 30,
          background: turquoise,
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    );
    if (result != null && result) await routemasterDelegate.pop();
    _position = 0;
    init();
    play();
  }

  Future<void> showFinishWorkout(BuildContext context) async {
    final result = await showRheaDialog(
      context,
      dismissible: false,
      title: Text(
        context.l10n.end_workout_question,
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: biscay,
            ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        context.l10n.end_workout_description,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: biscay,
            ),
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        SolidButton(
          width: MediaQuery.of(context).size.width * 0.3,
          title: Text(
            context.l10n.no,
            textAlign: TextAlign.center,
          ),
          borderRadius: 30,
          background: persimmom,
          onPressed: () => Navigator.of(context).pop(false),
        ),
        SolidButton(
          width: MediaQuery.of(context).size.width * 0.3,
          title: Text(
            context.l10n.yes,
            textAlign: TextAlign.center,
          ),
          borderRadius: 30,
          background: turquoise,
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    );
    if (result != null && result) {
      final chunkedPath = routemasterDelegate.currentConfiguration!.path
          .split('/')
          .take(
            routemasterDelegate.currentConfiguration!.publicPath
                    .split('/')
                    .length -
                1,
          )
          .join('/');
      routemasterDelegate.replace('$chunkedPath/ending_workout');
      return;
    }
    await controller?.play();
  }

  @override
  Future<void> close() {
    controller?.dispose();
    seekDequeBuffer.clear();
    return super.close();
  }
}
