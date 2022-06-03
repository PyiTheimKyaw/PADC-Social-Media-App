import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:social_media_app/ml_kit/ml_kit_text_recognition.dart';

class TextDetectionBloc extends ChangeNotifier {
  File? chosenImageFile;
  bool isDisposed = false;

  ///MLKit
  final MLKitTextRecognition _textRecognition = MLKitTextRecognition();

  void onImageChosen(File imageFile) {
    chosenImageFile = imageFile;
    _textRecognition.detectTexts(imageFile);
    _textRecognition.detectFaces(imageFile);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
