// ignore_for_file: lines_longer_than_80_chars

extension IntExtension on int {
  String get toMinutesAndSeconds {
    final _duration = Duration(seconds: this);
    return '${_duration.inMinutes.toString().padLeft(2, '0')}:${_duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';
  }

  String get toMinutesOrSecondsOrSeconds {
    final _duration = Duration(seconds: this);
    if (_duration.inHours > 0) {
      return '${_duration.inHours.toString().padLeft(2, '0')}:${_duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${_duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    }
    if (_duration.inMinutes > 0) {
      return '${_duration.inMinutes.toString().padLeft(2, '0')}:${_duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    }
    return _duration.inSeconds.toString();
  }
}
