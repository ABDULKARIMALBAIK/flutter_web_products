import 'dart:typed_data';
import 'package:hive_flutter/hive_flutter.dart';
import '../../model/user_model.dart';

class UserBox {
  UserBox.constructor();

  late Box _boxUser;

  init(Uint8List encryptionKey) async {
    _boxUser = await Hive.openBox<User>('User',
        encryptionCipher: HiveAesCipher(encryptionKey));
  }

  clear() async {
    await _boxUser.clear();
  }

  User? getUser() {
    User? currentUser = _boxUser.get('currentUser');
    return currentUser;
  }

  void saveUser(User currentUser) {
    _boxUser.put('currentUser', currentUser);
  }
}
