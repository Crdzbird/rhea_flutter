part of 'session_bloc.dart';

abstract class SessionEvent extends Equatable {
  const SessionEvent();

  @override
  List<Object> get props => [];
}

class OnAuthorizedEvent extends SessionEvent {
  const OnAuthorizedEvent();
}

class OnUnauthorizedEvent extends SessionEvent {
  const OnUnauthorizedEvent();
}

class OnOfflineEvent extends SessionEvent {
  const OnOfflineEvent();
}

class OnFreeEvent extends SessionEvent {
  const OnFreeEvent();
}

class OnPaidEvent extends SessionEvent {
  const OnPaidEvent();
}
