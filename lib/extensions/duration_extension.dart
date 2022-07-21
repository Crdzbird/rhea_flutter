// ignore_for_file: lines_longer_than_80_chars

extension DurationExtension on Duration {
  String get toMinutesAndSeconds =>
      '${inMinutes.toString().padLeft(2, '0')}:${inSeconds.remainder(60).toString().padLeft(2, '0')}';

  String get toMinutesOrSecondsOrSeconds {
    if (inHours > 0) {
      return '${inHours.toString().padLeft(2, '0')}:${inMinutes.remainder(60).toString().padLeft(2, '0')}:${inSeconds.remainder(60).toString().padLeft(2, '0')}';
    }
    if (inMinutes > 0) {
      return '${inMinutes.toString().padLeft(2, '0')}:${inSeconds.remainder(60).toString().padLeft(2, '0')}';
    }
    return inSeconds.toString();
  }
}
