import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhea_app/blocs/platform/platform_cubit.dart';
import 'package:rhea_app/shared/widgets/loader.dart';
import 'package:rhea_app/styles/color.dart';

class SolidButton extends StatelessWidget {
  const SolidButton({
    super.key,
    required this.title,
    this.height,
    this.width,
    this.padding,
    this.margin,
    this.onPressed,
    this.leading,
    this.background,
    this.elevation = 0.0,
    this.borderRadius = 0.0,
    this.trailing,
    this.buttonPadding,
    this.childrenPadding,
    this.disabledBackground,
    this.isLoading = false,
  });
  final double? width;
  final double? height;
  final double elevation;
  final Color? background;
  final Color? disabledBackground;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? buttonPadding;
  final EdgeInsetsGeometry? childrenPadding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final Widget? leading;
  final Widget? trailing;
  final Widget title;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) =>
      (context.read<PlatformCubit>().state.platformType == PlatformType.android)
          ? Container(
              width: width,
              height: height,
              padding: padding,
              margin: margin,
              child: TextButton(
                onPressed: !isLoading ? onPressed : null,
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).primaryColorDark.withOpacity(.2),
                  ),
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    return (states.contains(MaterialState.disabled))
                        ? disabledBackground ??
                            background ??
                            Theme.of(context).secondaryHeaderColor
                        : background ??
                            Theme.of(context).colorScheme.inverseSurface;
                  }),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    buttonPadding ?? EdgeInsetsDirectional.zero,
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                  ),
                  foregroundColor:
                      Theme.of(context).textButtonTheme.style?.foregroundColor,
                  elevation: isLoading
                      ? MaterialStateProperty.all<double>(0)
                      : MaterialStateProperty.all<double>(elevation),
                ),
                child: !isLoading
                    ? ListTile(
                        contentPadding: childrenPadding,
                        leading: leading,
                        title: title,
                        trailing: trailing,
                      )
                    : const Loader(),
              ),
            )
          : Container(
              width: width,
              height: height,
              padding: padding,
              margin: margin,
              child: PhysicalModel(
                color: transparent,
                borderRadius: BorderRadius.circular(borderRadius),
                elevation: elevation,
                shadowColor: Theme.of(context).shadowColor,
                child: CupertinoButton(
                  onPressed: !isLoading ? onPressed : null,
                  disabledColor: disabledBackground ??
                      background ??
                      Theme.of(context).secondaryHeaderColor,
                  color: background ??
                      Theme.of(context).colorScheme.inverseSurface,
                  borderRadius: BorderRadius.circular(borderRadius),
                  padding: buttonPadding ?? EdgeInsetsDirectional.zero,
                  child: !isLoading
                      ? ListTile(
                          contentPadding: childrenPadding,
                          leading: leading,
                          title: title,
                          trailing: trailing,
                        )
                      : const Loader(),
                ),
              ),
            );
}

/*
import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

class CustomTextButton extends TextButton {
  CustomTextButton({
    super.key,
    required super.onPressed,
    super.onLongPress,
    super.style,
    super.focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    Widget? icon,
    required Widget label,
    Widget? trailing,
  }) : super(
          autofocus: autofocus ?? false,
          clipBehavior: clipBehavior ?? Clip.none,
          child: _TextButtonWithIconChild(
            icon: icon,
            label: label,
            trailing: trailing,
          ),
        );
  factory CustomTextButton.icon({
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    Widget? icon,
    required Widget label,
    Widget? trailing,
  }) = CustomTextButton;

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    final scaledPadding = ButtonStyleButton.scaledPadding(
      const EdgeInsets.all(8),
      const EdgeInsets.symmetric(horizontal: 4),
      const EdgeInsets.symmetric(horizontal: 4),
      MediaQuery.maybeOf(context)?.textScaleFactor ?? 1,
    );
    return super.defaultStyleOf(context).copyWith(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(scaledPadding),
        );
  }
}

class _TextButtonWithIconChild extends StatelessWidget {
  const _TextButtonWithIconChild({
    required this.label,
    this.icon,
    this.trailing,
  });

  final Widget label;
  final Widget? icon;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.maybeOf(context)?.textScaleFactor ?? 1;
    final gap =
        (scale <= 1 ? 8 : lerpDouble(8, 4, math.min(scale - 1, 1))!).toDouble();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (icon != null) SizedBox(width: gap),
        if (icon != null) icon!,
        SizedBox(width: gap),
        Flexible(child: label),
        if (trailing != null) SizedBox(width: gap),
        if (trailing != null) trailing!,
      ],
    );
  }
}

*/
