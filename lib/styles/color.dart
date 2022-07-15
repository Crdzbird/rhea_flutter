import 'package:flutter/material.dart';

const Color social1 = Color(0xffc4dffa);
const Color social2 = Color(0xff699dcf);
const Color social3 = Color(0xff8ac2f1);
const Color social4 = Color(0xff2a79b8);
const Color social5 = Color(0xffc4dffa);
const Color social6 = Color(0xffdae5f3);
const Color dark1 = Color(0xf301071d);
const Color dark2 = Color(0xff101d31);

const dullLavender = Color(0xFF89A1E2);
const persimmom = Color(0xFFFF5353);
const salmon = Color(0xFFFF8976);
const turquoise = Color(0xFF2FD8C4);
const portica = Color(0xFFF7F36B);
const white = Color(0xFFFFFFFF);
const blackSqueeze = Color(0xFFFCFDFE);
const whiteLilac = Color(0xD5F7F9FC);
const linkWater = Color(0xFFEFF3FA);
const botticelli = Color(0xFFC6D2E0);
const hoki = Color(0xFF6382A0);
const biscay = Color(0xFF1D3E64);
const pictonBlue = Color(0xFF4A9DF0);
const albescentWhite = Color(0xFFF7EEDA);
const mirage = Color(0xFF111B27);
const smokeyGrey = Color(0xFF746F71);

const mirage_45 = Color(0x73111B27);
const transparent = Color(0x00FFFFFF);
const backgroundColor = Color(0xBF1D3E64);
const sessionBackgroundColor = Color(0xB21D3E64);
const trialBackgroundColor = Color(0xD81D3E64);
const black = Color(0xFF000000);
const whiteLilacOpacity = Color(0xFFCFE2FF);
const albescentWhiteOpacity = Color(0xFFEAEEEE);

MaterialColor createMaterialColor(Color color) {
  final strengths = <double>[.05];
  final swatch = <int, Color>{};
  final r = color.red;
  final g = color.green;
  final b = color.blue;
  for (var i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (final strength in strengths) {
    final ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
