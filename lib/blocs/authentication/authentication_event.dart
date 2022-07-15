part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class OnAuthenticatedEvent extends AuthenticationEvent {
  const OnAuthenticatedEvent(this.session);
  final Session session;
}

class OnFailureEvent extends AuthenticationEvent {
  const OnFailureEvent(this.error);
  final String error;
}

class OnLoadingEvent extends AuthenticationEvent {
  const OnLoadingEvent();
}

class OnIdleEvent extends AuthenticationEvent {
  const OnIdleEvent();
}
