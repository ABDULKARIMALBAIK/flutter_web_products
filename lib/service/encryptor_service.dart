import 'package:easy_encryption/easy_encryption.dart';
// import 'package:injectable/injectable.dart';

// @Singleton()
class EncryptorService {
  Future<String> encryptMyMessage(String message) async {
    EasyEncryption easyEncrypt = EasyEncryption();
    String encryptedMessage = await easyEncrypt.encryptData(data: message);
    return encryptedMessage;
  }

  Future<String> decryptMyMessage(String encryptedMessage) async {
    EasyEncryption easyEncrypt = EasyEncryption();
    String originalMessage =
        await easyEncrypt.decryptData(data: encryptedMessage);
    return originalMessage;
  }
}
