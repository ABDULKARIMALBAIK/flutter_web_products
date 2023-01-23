import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImagePickNotifier extends ChangeNotifier {
  Uint8List? pickedImage;
  String pathFile = '';
  bool isPicked = false;

  pickImageFile(Uint8List image, String urlPage) {
    pickedImage = image;
    pathFile = urlPage;
    isPicked = true;

    debugPrint('isPicked_$isPicked');

    notifyListeners();
    notifyListeners();
    notifyListeners();
  }
}

class UpdateDropZoneNotifier extends ChangeNotifier {
  bool isHover = false;

  changeState(bool status) {
    isHover = status;
    notifyListeners();
  }
}
