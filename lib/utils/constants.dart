import 'package:Products/service/dio_service.dart';
import 'package:Products/service/encryptor_service.dart';
import 'package:Products/service/storage_service.dart';
import 'package:Products/utils/theme_app_generator.dart';
import 'package:flutter/material.dart' show ThemeData, Locale;

String nameWebsite = 'Products';

class DataHelper {
  static bool isDark = false;
  static ThemeData currentTheme = ThemeAppGenerator().lightTheme();
  static Locale currentLanguage = const Locale('en');

  static late StorageService storageService;
  static late DioService dioService;
  static late EncryptorService encryptorService;

  static Locale getCurrentLanguage(String currentLanguage) {
    if (currentLanguage == 'english') {
      return const Locale('en');
    } else if (currentLanguage == 'arabic') {
      return const Locale('ar');
    } else {
      return const Locale('en');
    }
  }
}
