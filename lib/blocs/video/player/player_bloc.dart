import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rhea_app/l10n/l10n.dart';
import 'package:rhea_app/models/exercise.dart';
import 'package:rhea_app/navigation/routes.dart';
import 'package:rhea_app/shared/widgets/dialog/rhea_dialog.dart';
import 'package:rhea_app/shared/widgets/solid_button.dart';
import 'package:rhea_app/styles/color.dart';
import 'package:video_player/video_player.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc({
    required this.exercises,
  }) : super(VideoInitState()) {
    on<VideoInitializeEvent>(_videoPlayerInit);
    on<VideoPlayEvent>(_videoPlayerPlay);
    on<VideoPauseEvent>(_videoPlayerPause);
    on<VideoPositionEvent>((event, emit) {
      emit(VideoPositionState(duration: event.duration));
    });
    init();
  }

  void init() {
    _controller = VideoPlayerController.network(
      exercises[_position].videoUrl,
      formatHint: VideoFormat.hls,
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );
    _controller?.addListener(checkVideo);
    _controller!.initialize();
    for (final element in exercises) {
      _totalDuration += element.duration;
    }
  }

  final List<Exercise> exercises;
  int _totalDuration = 0;
  int _position = 0;
  int get position => _position;
  int _currentDuration = 0;
  int get currentDuration => _currentDuration;
  int get totalDuration => _totalDuration;
  VideoPlayerController? _controller;
  VideoPlayerController? get controller => _controller;

  final Queue<Duration> seekDequeBuffer = Queue();

  bool isInitialized() => _controller?.value.isInitialized ?? false;
  bool _isVideoFinished = false;
  bool get isVideoFinished => _isVideoFinished;

  void _videoPlayerInit(
    VideoInitializeEvent event,
    Emitter<PlayerState> emit,
  ) =>
      emit(VideoInitState());

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
      _position++;
      init();
      play();
      return;
    }
  }

  void checkVideo() {
    _currentDuration = _controller!.value.position.inMilliseconds;
    add(VideoPositionEvent(duration: _controller!.value.position));
    if (_controller != null &&
        _controller!.value.isInitialized &&
        _controller?.value.position == _controller?.value.duration) {
      _isVideoFinished = true;
      if (_position + 1 < exercises.length) {
        print('NEXT VIDEO');
        _position++;
        init();
        play();
        // mapEventToState(
        //   VideoInitializeEvent(url: exercises[_position].videoUrl),
        // );
        return;
      }
      _isVideoFinished = false;
      print('PLAYERVIDEO EXERCISE SESSION COMPLETED');
    }
  }

  Future<void> displayInformation() async {
    final result = await showRheaDialog(
      navigatorKey.currentState!.context,
      title: Text(
        exercises[_position].name,
        style: Theme.of(navigatorKey.currentContext!)
            .textTheme
            .displayMedium
            ?.copyWith(
              color: biscay,
            ),
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        height: MediaQuery.of(navigatorKey.currentContext!).size.height * 0.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...exercises[_position].previewDescription.map(
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
    print('resultDIALOG: $result');
  }

  Future<void> showFinishWorkout() async {
    await _controller?.pause();
    final result = await showRheaDialog(
      navigatorKey.currentState!.context,
      dismissible: false,
      title: Text(
        navigatorKey.currentContext!.l10n.end_workout_question,
        style: Theme.of(navigatorKey.currentContext!)
            .textTheme
            .displayMedium
            ?.copyWith(
              color: biscay,
            ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        navigatorKey.currentContext!.l10n.end_workout_description,
        style: Theme.of(navigatorKey.currentContext!)
            .textTheme
            .bodyMedium
            ?.copyWith(
              color: biscay,
            ),
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        SolidButton(
          width: MediaQuery.of(navigatorKey.currentContext!).size.width * 0.3,
          title: Text(
            navigatorKey.currentContext!.l10n.no,
            textAlign: TextAlign.center,
          ),
          borderRadius: 30,
          background: persimmom,
          onPressed: () =>
              Navigator.of(navigatorKey.currentContext!).pop(false),
        ),
        SolidButton(
          width: MediaQuery.of(navigatorKey.currentContext!).size.width * 0.3,
          title: Text(
            navigatorKey.currentContext!.l10n.yes,
            textAlign: TextAlign.center,
          ),
          borderRadius: 30,
          background: turquoise,
          onPressed: () => Navigator.of(navigatorKey.currentContext!).pop(true),
        ),
      ],
    );
    if (result != null && !result) await controller?.play();
  }

  @override
  Future<void> close() {
    controller?.dispose();
    return super.close();
  }
}
