part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class OnSuccessEvent extends ProfileEvent {
  const OnSuccessEvent(this.profile);
  final Profile profile;
}

class OnFailureEvent extends ProfileEvent {
  const OnFailureEvent(this.error);
  final String error;
}

class OnLoadingEvent extends ProfileEvent {
  const OnLoadingEvent();
}

class OnIdleEvent extends ProfileEvent {
  const OnIdleEvent();
}
