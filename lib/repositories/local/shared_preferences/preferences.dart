import 'package:rhea_app/repositories/local/shared_preferences/read.dart';
import 'package:rhea_app/repositories/local/shared_preferences/write.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum GuardType { aes }

class Preferences {
  /// Initialize [Preferences] with the desired encryption.
  Preferences({
    required this.sharedPreferences,
    required this.writeEncrypter,
    required this.readEncrypter,
  });

  final SharedPreferences sharedPreferences;
  final Write writeEncrypter;
  final Read readEncrypter;

  /// Register a Preference Value.
  /// ```dart
  /// write(key: 'myVal', value: 'stored');
  /// ```
  void write({required String key, required String value}) =>
      writeEncrypter.aesWrite(key, value);

  /// Similar to [write], but uses a [List<String>] as parameter.
  void writeList({required String key, required List<String> values}) =>
      writeEncrypter.aesWriteList(key, values);

  /// Retrieve a Preference Value.
  /// ```dart
  /// read(key: 'myVal') => 'stored';
  /// ```
  Future<String?> read({required String key}) async =>
      readEncrypter.aesRead(key);

  /// Similar to [read], but uses a [List<String>] as parameter.
  Future<List<String>?> readList({required String key}) async =>
      readEncrypter.aesReadList(key);

  /// Remove all the preferences stored.
  Future<bool> clearAll() async => sharedPreferences.clear();
}
