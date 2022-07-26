import 'package:flutter/material.dart';
import 'package:rhea_app/l10n/l10n.dart';
import 'package:rhea_app/models/enums/reason_type.dart';

extension ReasonTypeExtension on ReasonType {
  String l10n(BuildContext context) {
    switch (this) {
      case ReasonType.tooDifficult:
        return context.l10n.workout_was_too_difficult;
      case ReasonType.feelingWorse:
        return context.l10n.symptoms_have_worsened;
      case ReasonType.retrylLater:
        return context.l10n.would_like_to_continue_later;
      case ReasonType.other:
        return context.l10n.other;
    }
  }
}

ReasonType toReasonTypeEnum(String value) {
  switch (value) {
    case 'workout_was_too_difficult':
      return ReasonType.tooDifficult;
    case 'symptoms_have_worsened':
      return ReasonType.feelingWorse;
    case 'would_like_to_continue_later':
      return ReasonType.retrylLater;
    case 'other':
      return ReasonType.other;
    default:
      return ReasonType.retrylLater;
  }
}
