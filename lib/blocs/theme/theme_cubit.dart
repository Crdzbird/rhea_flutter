import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit() : super(ThemeState.initial());

  void toggleLightTheme() => emit(state.copyWith());
  void toggleDarkTheme() => emit(state.copyWith());

  @override
  ThemeState? fromJson(Map<String, dynamic> json) => ThemeState.fromMap(json);

  @override
  Map<String, dynamic>? toJson(ThemeState state) => state.toMap;
}
