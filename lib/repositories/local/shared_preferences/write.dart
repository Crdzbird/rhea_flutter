import 'package:encrypt/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Write {
  const Write({required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  /// Stored a `encryptedString` as a SharedPreference.
  /// ```dart
  /// aesWrite('myVal') => '87ndsin4ue8i9qi3ni90w398i' //encrypted String
  /// ```
  Future<void> aesWrite(String key, String value) async {
    final k = Key.fromUtf8(')J@NcRfUjXn2r5u8x/A%D*G-KaPdSgVk');
    final iv = IV.fromLength(16);
    final encrypt = Encrypter(AES(k, mode: AESMode.cbc));
    final encryptedValue = encrypt.encrypt(value, iv: iv);
    await sharedPreferences.setString(key, encryptedValue.base64);
  }

  /// Stored a `encryptedList<String>` as a SharedPreference.
  /// ```dart
  /// aesWrite(['demo','subdemo']) => '87ndsin4ue8i9qi3ni90w398i' //encrypted String
  /// ```
  Future<void> aesWriteList(String key, List<String> values) async {
    final k = Key.fromUtf8(')J@NcRfUjXn2r5u8x/A%D*G-KaPdSgVk');
    await sharedPreferences.setStringList(
      key,
      values.map((e) {
        final iv = IV.fromLength(16);
        final encrypt = Encrypter(AES(k, mode: AESMode.cbc));
        return encrypt.encrypt(e, iv: iv).base64;
      }).toList(),
    );
  }
}
