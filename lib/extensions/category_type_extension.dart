import 'package:rhea_app/models/enums/category_type.dart';

extension CategoryTypeExtension on CategoryType {
  String get icon {
    switch (this) {
      case CategoryType.base:
        return 'assets/svg/ic_play.svg';
      case CategoryType.sleep:
        return 'assets/svg/ic_book.svg';
    }
  }
}

CategoryType toCategoryEnum(String value) {
  switch (value) {
    case 'base':
      return CategoryType.base;
    case 'sleep':
      return CategoryType.sleep;
    default:
      return CategoryType.base;
  }
}
