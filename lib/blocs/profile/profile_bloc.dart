import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:rhea_app/models/enums/preferences_type.dart';
import 'package:rhea_app/models/network/network_exceptions.dart';
import 'package:rhea_app/models/profile.dart';
import 'package:rhea_app/repositories/local/shared_preferences/shared_provider.dart';
import 'package:rhea_app/repositories/network/remote/data_source/profile/implementation/profile_implementation.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required this.profileImplementation,
  }) : super(OnIdleProfile()) {
    on<OnFailureEvent>((event, emit) => emit(OnFailedProfile(event.error)));
    on<OnIdleEvent>((event, emit) => emit(OnIdleProfile()));
    on<OnSuccessEvent>((event, emit) => emit(OnSuccessProfile(event.profile)));
    on<OnLoadingEvent>((event, emit) => emit(OnLoadingProfile()));
    fetchProfile();
  }

  final ProfileImplementation profileImplementation;

  Future<void> fetchProfile() async {
    add(const OnLoadingEvent());
    final result = await profileImplementation.fetchProfile();
    await result.when(
      success: (data) async {
        SharedProvider.sharedPreferences.write(
          key: PreferencesType.profile.key,
          value: data.toJson,
        );
        return add(OnSuccessEvent(data));
      },
      failure: (error, _) async {
        if (NetworkExceptions.isUnauthorized(error)) {
          add(OnFailureEvent(error.toString()));
          return;
        }
        final profileJson = await SharedProvider.sharedPreferences.read(
          key: PreferencesType.profile.key,
        );
        add(OnSuccessEvent(Profile.fromJson(profileJson!)));
      },
    );
  }
}
