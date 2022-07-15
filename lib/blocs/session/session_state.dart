part of 'session_bloc.dart';

enum SessionStatus { unauthorized, authorized, offline, free, paid }

class SessionState extends Equatable {
  const SessionState({this.status = SessionStatus.unauthorized});

  factory SessionState.unauthorized() => const SessionState();

  factory SessionState.authorized() =>
      const SessionState(status: SessionStatus.authorized);

  factory SessionState.free() => const SessionState(status: SessionStatus.free);

  factory SessionState.offline() =>
      const SessionState(status: SessionStatus.offline);

  factory SessionState.paid() => const SessionState(status: SessionStatus.paid);
  final SessionStatus status;

  @override
  List<Object> get props => [status];

  SessionState copyWith({
    SessionStatus? status,
  }) {
    return SessionState(
      status: status ?? this.status,
    );
  }
}
