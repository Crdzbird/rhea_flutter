import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show TargetPlatform, kIsWeb;

part 'platform_state.dart';

class PlatformCubit extends Cubit<PlatformState> {
  PlatformCubit() : super(PlatformState.initial()) {
    getCurrentPlatformType();
  }

  bool get isDesktopOS =>
      Platform.isMacOS || Platform.isLinux || Platform.isWindows;

  bool get isAppOS => Platform.isMacOS || Platform.isAndroid;

  bool get isWeb => kIsWeb;

  TargetPlatform targetPlatform() {
    if (kIsWeb) return TargetPlatform.macOS;
    if (Platform.isMacOS) return TargetPlatform.macOS;
    if (Platform.isFuchsia) return TargetPlatform.fuchsia;
    if (Platform.isLinux) return TargetPlatform.linux;
    if (Platform.isWindows) return TargetPlatform.windows;
    if (Platform.isIOS) return TargetPlatform.iOS;
    if (Platform.isAndroid) return TargetPlatform.android;
    return TargetPlatform.android;
  }

  void getCurrentPlatformType() {
    if (kIsWeb) {
      emit(const PlatformState(platformType: PlatformType.web));
      return;
    }
    if (Platform.isMacOS) {
      emit(const PlatformState(platformType: PlatformType.macOS));
      return;
    }
    if (Platform.isFuchsia) {
      emit(const PlatformState(platformType: PlatformType.fuchsia));
      return;
    }
    if (Platform.isLinux) {
      emit(const PlatformState(platformType: PlatformType.linux));
      return;
    }
    if (Platform.isWindows) {
      emit(const PlatformState(platformType: PlatformType.windows));
      return;
    }
    if (Platform.isIOS) {
      emit(const PlatformState(platformType: PlatformType.iOS));
      return;
    }
    if (Platform.isAndroid) {
      emit(const PlatformState(platformType: PlatformType.android));
      return;
    }
    emit(const PlatformState(platformType: PlatformType.unknown));
  }
}
