import 'package:rhea_app/models/enums/exercise_type.dart';
import 'package:rhea_app/models/exercise.dart';

extension ExerciseExtension on Exercise {
  ExerciseType get toExerciseType {
    switch (type) {
      case 'rest':
        return ExerciseType.rest;
      case 'video':
        return ExerciseType.video;
      default:
        return ExerciseType.video;
    }
  }
}
