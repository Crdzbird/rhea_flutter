import 'package:flutter/material.dart';

class ShadowInputBorder extends InputBorder {
  const ShadowInputBorder({
    required this.elevation,
    required this.fillColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.shadowColor = Colors.black87,
  });
  final BorderRadius borderRadius;
  final double elevation;
  final Color shadowColor;
  final Color fillColor;

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(2);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(
        borderRadius
            .resolve(textDirection)
            .toRRect(rect)
            .deflate(borderSide.width),
      );
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRRect(borderRadius.resolve(textDirection).toRRect(rect));
  }

  @override
  bool get isOutline => true;

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection? textDirection,
  }) {
    final paint = Paint()..color = fillColor;
    final outer = borderRadius.toRRect(rect);
    canvas
      ..drawShadow(getOuterPath(rect), shadowColor, elevation, false)
      ..drawRRect(outer, paint);
  }

  @override
  ShapeBorder scale(double t) {
    return ShadowInputBorder(elevation: elevation, fillColor: fillColor);
  }

  @override
  InputBorder copyWith({BorderSide? borderSide}) {
    return ShadowInputBorder(elevation: elevation, fillColor: fillColor);
  }
}
