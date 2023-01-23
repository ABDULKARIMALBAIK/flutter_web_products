import 'package:flutter/material.dart';

class AppColor {
  Color primaryColorLight() => Colors.blue;
  Color primaryColorDark() => Colors.blueAccent[400]!;

  Color accentColorLight() => Colors.blue;
  Color accentColorDark() => Colors.blueAccent[400]!;

  Color backgroundColorLight() =>
      const Color(0xFFE7ECEF); //Colors.white  0xFFE7ECEF
  Color backgroundColorDark() =>
      const Color(0xFF2E3239); //const Color(0xFF181818)

  Color cardColorLight() => const Color(0xFFF8F8F8); //const Color(0xFFF8F8F8)
  Color cardColorDark() => const Color(0xFF0E0E0E); //const Color(0xFF0E0E0E)

  Color textTitleColorLight() => Colors.black;
  Color textTitleColorDark() => Colors.white;

  Color textBodyColorLight() => Colors.black38;
  Color textBodyColorDark() => Colors.white38;
}
