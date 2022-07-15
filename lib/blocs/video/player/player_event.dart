part of 'player_bloc.dart';

abstract class PlayerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class VideoInitializeEvent extends PlayerEvent {
  VideoInitializeEvent({required this.url});
  final String url;
  @override
  List<Object?> get props => [url];
}

class VideoPositionEvent extends PlayerEvent {
  VideoPositionEvent({required this.duration});
  final Duration duration;
  @override
  List<Object?> get props => [duration];
}

class VideoPlayEvent extends PlayerEvent {
  VideoPlayEvent({required this.currentDuration});
  final Duration currentDuration;

  @override
  List<Object?> get props => [currentDuration];
}

class VideoPauseEvent extends PlayerEvent {
  VideoPauseEvent({required this.currentDuration});
  final Duration currentDuration;

  @override
  List<Object?> get props => [currentDuration];
}
