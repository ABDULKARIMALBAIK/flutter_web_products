import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../utils/constants.dart';

class LanguageBox {
  LanguageBox.constructor();

  late Box _boxLanguage;

  init() async {
    _boxLanguage = await Hive.openBox('language');
  }

  clear() async {
    await _boxLanguage.clear();
  }

  Locale getLanguage() {
    Locale currentLanguage = DataHelper.getCurrentLanguage(
        _boxLanguage.get('currentLanguage', defaultValue: 'english'));
    return currentLanguage;
  }

  void saveLanguage(String currentLanguage) {
    _boxLanguage.put('currentLanguage', currentLanguage);
  }
}
