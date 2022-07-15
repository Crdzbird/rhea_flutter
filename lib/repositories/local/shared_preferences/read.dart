import 'package:encrypt/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Read {
  const Read({required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  /// Returns `encryptedString` of the Preference Stored without encryption.
  /// ```dart
  /// aesRead('myVal') => 'stored'
  /// ```
  Future<String?> aesRead(String key) async {
    final k = Key.fromUtf8(')J@NcRfUjXn2r5u8x/A%D*G-KaPdSgVk');
    final iv = IV.fromLength(16);
    final encrypt = Encrypter(AES(k, mode: AESMode.cbc));
    if (sharedPreferences.getString(key) == null) return null;
    return encrypt.decrypt64(sharedPreferences.getString(key) ?? '', iv: iv);
  }

  /// Returns `encryptedList<String>` of the Preference Stored without encrypt.
  /// ```dart
  /// aesReadList('myVal') => 'stored'
  /// ```
  Future<List<String>?> aesReadList(String key) async {
    final k = Key.fromUtf8(')J@NcRfUjXn2r5u8x/A%D*G-KaPdSgVk');
    final iv = IV.fromLength(16);
    final encrypt = Encrypter(AES(k, mode: AESMode.cbc));
    return (sharedPreferences.getStringList(key) != null)
        ? sharedPreferences
            .getStringList(key)!
            .map((e) => encrypt.decrypt64(e, iv: iv))
            .toList()
        : [];
  }
}
