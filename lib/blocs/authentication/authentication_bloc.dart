import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:rhea_app/l10n/l10n.dart';
import 'package:rhea_app/models/credentials.dart';
import 'package:rhea_app/models/enums/preferences_type.dart';
import 'package:rhea_app/models/network/network_exceptions.dart';
import 'package:rhea_app/models/session.dart';
import 'package:rhea_app/navigation/routes.dart';
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
      (event, emit) => emit(OnSuccessAuthentication(event.session)),
    );
    on<OnIdleEvent>((event, emit) => emit(OnIdleAuthentication()));
    on<OnLoadingEvent>((event, emit) => emit(OnLoadingAuthentication()));
    on<OnFailureEvent>(
      (event, emit) => emit(OnFailedAuthentication(event.error)),
    );
  }

  final AuthenticateImplementation authenticateImplementation;
  final ProfileImplementation profileImplementation;
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  Future<void> sendCredentials() async {
    add(const OnLoadingEvent());
    // if (!formKey.currentState!.validate()) {
    //   add(const OnIdleEvent());
    //   return;
    // }
    final result = await authenticateImplementation.authenticate(
      const Credentials(
        email: 'jack.chorley@me.com',
        password: 'MySecurePassword1!',
        // email: usernameController.text,
        // password: passwordController.text,
      ),
    );
    await result.when(
      success: (data) async {
        SharedProvider.sharedPreferences.write(
          key: PreferencesType.session.key,
          value: data.toJson,
        );
        await fetchProfile();
      },
      failure: (exception, message) {
        ScaffoldMessenger.of(navigatorKey.currentState!.context).showSnackBar(
          SnackBar(
            content: Text(
              message ?? NetworkExceptions.getErrorMessage(exception),
              textAlign: TextAlign.center,
            ),
            margin: const EdgeInsetsDirectional.only(
              bottom: 10,
              start: 10,
              end: 10,
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
        add(OnFailureEvent(exception.toString()));
      },
    );
    add(const OnIdleEvent());
  }

  Future<void> fetchProfile() async {
    add(const OnLoadingEvent());
    final result = await profileImplementation.fetchProfile();
    await result.when(
      success: (data) async {
        SharedProvider.sharedPreferences.write(
          key: PreferencesType.profile.key,
          value: data.toJson,
        );
        await routemasterDelegate
            .popUntil((routeData) => routeData.path == '/');
        routemasterDelegate.replace(
          data.trialStatus == 'paid' ? '/dashboard' : '/trial',
        );
      },
      failure: (exception, message) {
        ScaffoldMessenger.of(navigatorKey.currentState!.context).showSnackBar(
          SnackBar(
            content: Text(
              message ?? NetworkExceptions.getErrorMessage(exception),
              textAlign: TextAlign.center,
            ),
            margin: const EdgeInsetsDirectional.only(
              bottom: 10,
              start: 10,
              end: 10,
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
        add(OnFailureEvent(exception.toString()));
      },
    );
  }

  String? checkEmail(String? value) {
    if (value == null || value.isEmpty) {
      return navigatorKey.currentContext!.l10n.email_required;
    }
    if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(value)) {
      return navigatorKey.currentContext!.l10n.email_invalid;
    }
    return null;
  }

  String? checkPassword(String? value) {
    if (value == null || value.isEmpty) {
      return navigatorKey.currentContext!.l10n.password_required;
    }
    return null;
  }

  @override
  AuthenticationState? fromJson(Map<String, dynamic> json) =>
      OnSuccessAuthentication(Session.fromMap(json));

  @override
  Map<String, dynamic>? toJson(AuthenticationState state) =>
      (state is OnSuccessAuthentication)
          ? state.session.toMap
          : const Session().toMap;
}

//'jack.chorley@me.com', 'MySecurePassword1!'
