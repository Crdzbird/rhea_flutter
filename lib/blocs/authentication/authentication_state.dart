part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class OnIdleAuthentication extends AuthenticationState {}

class OnLoadingAuthentication extends AuthenticationState {}

class OnFailedAuthentication extends AuthenticationState {
  const OnFailedAuthentication(this.error);
  final String error;
}

class OnSuccessAuthentication extends AuthenticationState {
  const OnSuccessAuthentication(this.session);
  final Session session;
}
