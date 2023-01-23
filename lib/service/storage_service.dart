import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:injectable/injectable.dart';

import '../model/products_model.dart';
import '../model/user_model.dart';
import 'box/language_box.dart';
import 'box/product_box.dart';
import 'box/theme_box.dart';
import 'box/user_box.dart';

// @Singleton()
class StorageService {
  late LanguageBox _languageBox;
  late ThemeBox _themeBox;
  late UserBox _userBox;
  late ProductBox _productBox;

  Future<void> initDatabase() async {
    //init Hive Database
    await Hive.initFlutter();

    //Register Adapter (User , Products)
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(ProductAdapter());

    //Init Encryption keys
    await initSecureKey();

    //init all boxes
    await initBoxes();
  }

  Future<void> initBoxes() async {
    //Get Encryption Key
    const secureStorage = FlutterSecureStorage();
    final key = await secureStorage.read(key: 'key');
    final encryptionKey = base64Url.decode(key!);

    _languageBox = LanguageBox.constructor();
    await _languageBox.init();

    _themeBox = ThemeBox.constructor();
    await _themeBox.init();

    _userBox = UserBox.constructor();
    await _userBox.init(encryptionKey);

    _productBox = ProductBox.constructor();
    await _productBox.init(encryptionKey);
  }

  Future<void> initSecureKey() async {
    const secureStorage = FlutterSecureStorage();
    // if key not exists return null
    final encryptionKey = await secureStorage.read(key: 'key');
    if (encryptionKey == null) {
      final key = Hive.generateSecureKey();
      await secureStorage.write(
        key: 'key',
        value: base64UrlEncode(key),
      );
    }
  }

  clearDatabase() async {
    await languageStorage.clear();
    await themeStorage.clear();
    await userStorage.clear();
    await userStorage.clear();
    await productStorage.clear();
    const FlutterSecureStorage().deleteAll();
  }

  LanguageBox get languageStorage => _languageBox;
  ThemeBox get themeStorage => _themeBox;
  UserBox get userStorage => _userBox;
  ProductBox get productStorage => _productBox;
}
