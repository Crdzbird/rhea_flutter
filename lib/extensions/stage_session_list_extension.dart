import 'package:rhea_app/models/stage_session.dart';

extension StageSessionList on List<StageSession> {
  double get progress {
    final total = length.toDouble();
    final completed = where((element) => element.isCompleted).length.toDouble();
    return completed / total * 100;
  }
}
