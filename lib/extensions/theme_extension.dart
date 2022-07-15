import 'package:flutter/material.dart';

extension ThemeExtension on ThemeData {
  bool get isCupertinoStyle =>
      platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;
}
