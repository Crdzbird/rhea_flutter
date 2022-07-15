import 'package:rhea_app/utils/crontask/crontask.dart';

class CrontaskProvider {
  static late Cron cron;

  static void init() {
    cron = Cron();
  }
}
