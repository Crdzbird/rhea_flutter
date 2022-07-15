import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhea_app/blocs/platform/platform_cubit.dart';

Future<bool?> showRheaDialog(
  BuildContext context, {
  required Widget title,
  required Widget content,
  List<Widget>? actions,
  bool dismissible = true,
}) async {
  if (context.read<PlatformCubit>().state.platformType ==
      PlatformType.android) {
    return showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: dismissible,
      builder: (dialogContext) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: AlertDialog(
          title: title,
          content: content,
          actions: actions,
          actionsAlignment: MainAxisAlignment.center,
          backgroundColor: Theme.of(context).backgroundColor,
        ),
      ),
    );
  }
  return showCupertinoDialog(
    context: context,
    barrierDismissible: dismissible,
    builder: (dialogContext) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: CupertinoAlertDialog(
        title: title,
        content: content,
        actions: actions!,
      ),
    ),
  );
}
