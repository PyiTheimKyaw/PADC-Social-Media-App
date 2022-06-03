import 'dart:io';

import 'package:google_ml_kit/google_ml_kit.dart';

class MLKitTextRecognition {
  static final MLKitTextRecognition _singleton =
  MLKitTextRecognition._internal();

  factory MLKitTextRecognition() {
    return _singleton;
  }

  MLKitTextRecognition._internal();

  void detectTexts(File imageFile) async {
    InputImage inputImage = InputImage.fromFile(imageFile);
    final textDetector = GoogleMlKit.vision.textDetector();
    final RecognisedText recognizedText = await textDetector.processImage(
        inputImage);
    recognizedText.blocks.forEach((element) {
      print("Recognized text ===> ${element.text}");
    });
  }
  void detectFaces(File imageFile)async{
    InputImage inputImage = InputImage.fromFile(imageFile);
    final faceDetector=GoogleMlKit.vision.faceDetector();
    final List<Face> recognizedFace=await faceDetector.processImage(inputImage);
    print("Recognized Face =====> ${recognizedFace.length}");
  }
}
