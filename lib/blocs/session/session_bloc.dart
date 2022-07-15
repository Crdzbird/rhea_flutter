import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:rhea_app/models/enums/preferences_type.dart';
import 'package:rhea_app/models/network/network_exceptions.dart';
import 'package:rhea_app/repositories/local/shared_preferences/shared_provider.dart';
import 'package:rhea_app/repositories/network/remote/data_source/profile/implementation/profile_implementation.dart';
import 'package:rhea_app/repositories/network/remote/data_source/session/implementation/session_implementation.dart';

part 'session_state.dart';
part 'session_event.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SessionBloc({
    required this.sessionImplementation,
    required this.profileImplementation,
  }) : super(const SessionState()) {
    checkSession();
    on<OnAuthorizedEvent>(
      (event, emit) => emit(SessionState.authorized()),
    );
    on<OnUnauthorizedEvent>(
      (event, emit) => emit(SessionState.unauthorized()),
    );
    on<OnOfflineEvent>(
      (event, emit) => emit(SessionState.offline()),
    );
    on<OnFreeEvent>(
      (event, emit) => emit(SessionState.free()),
    );
    on<OnPaidEvent>(
      (event, emit) => emit(SessionState.paid()),
    );
  }

  final SessionImplementation sessionImplementation;
  final ProfileImplementation profileImplementation;

  Future<void> checkSession() async {
    final result = await sessionImplementation.refreshToken();
    await result.when(
      success: (data) async => fetchProfile(),
      failure: (error, _) {
        if (NetworkExceptions.isUnauthorized(error)) {
          add(const OnUnauthorizedEvent());
          return;
        }
        add(const OnOfflineEvent());
      },
    );
  }

  Future<void> fetchProfile() async {
    final result = await profileImplementation.fetchProfile();
    result.when(
      success: (data) {
        SharedProvider.sharedPreferences.write(
          key: PreferencesType.profile.key,
          value: data.toJson,
        );
        if (data.trialStatus == 'paid') {
          add(const OnPaidEvent());
          return;
        }
        if (data.trialStatus == 'free') {
          add(const OnFreeEvent());
        }
      },
      failure: (exception, message) {
        if (NetworkExceptions.isUnauthorized(exception)) {
          add(const OnUnauthorizedEvent());
          return;
        }
        add(const OnOfflineEvent());
      },
    );
  }
}
