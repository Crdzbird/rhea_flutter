import 'package:rhea_app/models/enums/feelings_type.dart';

extension FeelingTypeExtension on FeelingsType {
  String get icon {
    switch (this) {
      case FeelingsType.positive:
        return 'assets/images/ic_better.png';
      case FeelingsType.neutral:
        return 'assets/images/ic_neutral.png';
      case FeelingsType.negative:
        return 'assets/images/ic_negative.png';
      case FeelingsType.unkwnown:
        return 'assets/images/ic_neutral.png';
    }
  }
}

FeelingsType toFeelingEnum(String value) {
  switch (value) {
    case 'positive':
      return FeelingsType.positive;
    case 'neutral':
      return FeelingsType.neutral;
    case 'negative':
      return FeelingsType.negative;
    default:
      return FeelingsType.unkwnown;
  }
}
