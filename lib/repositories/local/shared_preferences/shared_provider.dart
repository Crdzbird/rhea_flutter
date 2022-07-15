import 'package:rhea_app/repositories/local/shared_preferences/preferences.dart';
import 'package:rhea_app/repositories/local/shared_preferences/read.dart';
import 'package:rhea_app/repositories/local/shared_preferences/write.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedProvider {
  static late Preferences sharedPreferences;

  static Future<void> init() async {
    final _shared = await SharedPreferences.getInstance();
    sharedPreferences = Preferences(
      sharedPreferences: _shared,
      writeEncrypter: Write(sharedPreferences: _shared),
      readEncrypter: Read(sharedPreferences: _shared),
    );
  }
}
