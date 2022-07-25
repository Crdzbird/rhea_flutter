part of 'player_bloc.dart';

abstract class PlayerState extends Equatable {
  const PlayerState();

  @override
  List<Object> get props => [];
}

class VideoInitState extends PlayerState {}

class VideoReadyState extends PlayerState {
  const VideoReadyState({required this.duration});
  final Duration duration;

  @override
  List<Object> get props => [duration];
}

class VideoFinishedState extends PlayerState {}

class VideoPlayingState extends PlayerState {
  const VideoPlayingState({required this.duration});
  final Duration duration;

  @override
  List<Object> get props => [duration];
}

class VideoPausedState extends PlayerState {
  const VideoPausedState({required this.duration});
  final Duration duration;

  @override
  List<Object> get props => [duration];
}

class VideoFailureState extends PlayerState {
  const VideoFailureState({required this.errorString});
  final String errorString;
  @override
  List<Object> get props => [errorString];
}

class VideoPositionState extends PlayerState {
  const VideoPositionState({required this.duration});
  final Duration duration;

  @override
  List<Object> get props => [duration];
}
