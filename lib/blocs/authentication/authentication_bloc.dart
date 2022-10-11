import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:rhea_app/l10n/l10n.dart';
import 'package:rhea_app/models/credentials.dart';
import 'package:rhea_app/models/enums/preferences_type.dart';
import 'package:rhea_app/models/network/network_exceptions.dart';
import 'package:rhea_app/models/profile.dart';
import 'package:rhea_app/models/session.dart';
import 'package:rhea_app/repositories/local/shared_preferences/shared_provider.dart';
import 'package:rhea_app/repositories/network/remote/data_source/authentication/implementation/authenticate_implementation.dart';
import 'package:rhea_app/repositories/network/remote/data_source/profile/implementation/profile_implementation.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends HydratedBloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required this.authenticateImplementation,
    required this.profileImplementation,
  }) : super(OnIdleAuthentication()) {
    on<OnAuthenticatedEvent>(
      (event, emit) => emit(OnSuccessAuthentication(event.profile)),
    );
    on<OnIdleEvent>((event, emit) => emit(OnIdleAuthentication()));
    on<OnLoadingEvent>((event, emit) => emit(OnLoadingAuthentication()));
    on<OnFailureEvent>(
      (event, emit) => emit(OnFailedAuthentication(event.error)),
    );
  }

  final AuthenticateImplementation authenticateImplementation;
  final ProfileImplementation profileImplementation;
  final usernameController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  Future<void> sendCredentials() async {
    add(const OnLoadingEvent());
    final result = await authenticateImplementation.authenticate(
      Credentials(
        email: usernameController.text,
        password: passwordController.text,
      ),
    );
    result.when(
      success: (data) async {
        SharedProvider.sharedPreferences.write(
          key: PreferencesType.session.key,
          value: (data as Session).toJson,
        );
        await fetchProfile();
      },
      failure: (exception, message) => add(
        OnFailureEvent(
          message ?? NetworkExceptions.getErrorMessage(exception),
        ),
      ),
    );
  }

  Future<void> fetchProfile() async {
    final result = await profileImplementation.fetchProfile();
    result.when(
      success: (data) async {
        SharedProvider.sharedPreferences.write(
          key: PreferencesType.profile.key,
          value: data.toJson,
        );
        add(OnAuthenticatedEvent(data));
      },
      failure: (exception, message) => add(
        OnFailureEvent(
          message ?? NetworkExceptions.getErrorMessage(exception),
        ),
      ),
    );
  }

  String? checkEmail(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return context.l10n.email_required;
    }
    if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(value)) {
      return context.l10n.email_invalid;
    }
    return null;
  }

  String? checkPassword(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return context.l10n.password_required;
    }
    return null;
  }

  @override
  AuthenticationState? fromJson(Map<String, dynamic> json) =>
      OnSuccessAuthentication(Profile.fromMap(json));

  @override
  Map<String, dynamic>? toJson(AuthenticationState state) =>
      (state is OnSuccessAuthentication)
          ? state.profile.toMap
          : const Profile().toMap;
}

//'jack.chorley@me.com', 'MySecurePassword1!'
