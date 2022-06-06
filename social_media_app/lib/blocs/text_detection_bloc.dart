import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:social_media_app/ml_kit/ml_kit_text_recognition.dart';

class TextDetectionBloc extends ChangeNotifier {
  File? chosenImageFile;
  bool isDisposed = false;
  List<TextBlock>? recognizedTextBlock;
  List<String> recognizedText=[];

  ///MLKit
  final MLKitTextRecognition _textRecognition = MLKitTextRecognition();

  void onImageChosen(File imageFile) {
    chosenImageFile = imageFile;
    _textRecognition.detectTexts(imageFile).then((textBlock) {
      recognizedTextBlock = textBlock;
      recognizedTextBlock?.forEach((element) {
        recognizedText.add(element.text);
        notifyListeners();
        // recognizedText = recognizedText?.map((text) {
        //   text = element.text;
        //   notifyListeners();
        //   return text;
        // }).toList();
      });
      notifyListeners();
    });
    _textRecognition.detectFaces(imageFile);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
