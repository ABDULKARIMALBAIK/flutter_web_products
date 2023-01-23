import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../utils/theme_app_generator.dart';

class ThemeBox {
  ThemeBox.constructor();

  late Box _boxTheme;

  init() async {
    _boxTheme = await Hive.openBox('Theme');
  }

  clear() async {
    await _boxTheme.clear();
  }

  ThemeData getTheme() {
    //false => light , true => dark
    bool isDark = _boxTheme.get('currentTheme', defaultValue: false);

    ThemeData currentTheme = isDark
        ? ThemeAppGenerator().darkTheme()
        : ThemeAppGenerator().lightTheme();
    return currentTheme;
  }

  void saveTheme(bool isDark) {
    _boxTheme.put('currentTheme', isDark);
  }

  bool darkMode() {
    //false => light , true => dark
    bool isDark = _boxTheme.get('currentTheme', defaultValue: false);
    return isDark;
  }
}
