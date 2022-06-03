import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/blocs/text_detection_bloc.dart';
import 'package:social_media_app/resources/dimens.dart';
import 'package:social_media_app/utils/extensions.dart';
import 'package:social_media_app/viewitems/primary_button_view.dart';

class TextDetectionPage extends StatelessWidget {
  const TextDetectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => TextDetectionBloc(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
        ),
        body: Container(
          color: Colors.white,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Consumer<TextDetectionBloc>(
                    builder: (BuildContext context, bloc, Widget? child) {
                      return Visibility(
                        visible: bloc.chosenImageFile!=null,
                        child: Container(
                          height: 300,
                          width: 300,
                          child: Image.file(bloc.chosenImageFile ?? File("")),
                        ),
                      );
                    },

                  ),
                  SizedBox(height: MARGIN_XXLARGE,),
                  Consumer<TextDetectionBloc>(
                    builder: (BuildContext context, bloc, Widget? child) {
                      return GestureDetector(
                          onTap: () {
                            ImagePicker()
                                .pickImage(source: ImageSource.gallery)
                                .then((pickedImage) {
                              bloc.onImageChosen(File(pickedImage?.path ?? ""));
                            }).catchError((error) {
                              showSnackBarWithMessage(
                                  context, error.toString());
                            });
                          },
                          child: PrimaryButtonView(labelText: "Choose Image"));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
