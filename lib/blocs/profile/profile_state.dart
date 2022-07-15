part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class OnIdleProfile extends ProfileState {}

class OnLoadingProfile extends ProfileState {}

class OnSuccessProfile extends ProfileState {
  const OnSuccessProfile(this.profile);
  final Profile profile;
}

class OnFailedProfile extends ProfileState {
  const OnFailedProfile(this.error);
  final String error;
}
