import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/blocs/register_bloc.dart';
import 'package:social_media_app/pages/login_page.dart';
import 'package:social_media_app/resources/dimens.dart';
import 'package:social_media_app/resources/strings.dart';
import 'package:social_media_app/utils/extensions.dart';
import 'package:social_media_app/viewitems/label_and_text_field_view.dart';
import 'package:social_media_app/viewitems/primary_button_view.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => RegisterBloc(),
      child: Selector<RegisterBloc, bool>(
        selector: (context, bloc) => bloc.isLoading,
        builder: (BuildContext context, isLoading, Widget? child) {
          return Stack(
            children: [
              Scaffold(
                body: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: LOGIN_SCREEN_TOP_PADDING,
                        left: MARGIN_XLARGE,
                        right: MARGIN_XLARGE,
                        bottom: MARGIN_LARGE),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          LABEL_REGISTER,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: TEXT_BIG),
                        ),
                        const SizedBox(
                          height: MARGIN_XLARGE,
                        ),
                        Consumer<RegisterBloc>(
                          builder: (BuildContext context, bloc, Widget? child) {
                            return LabelAndTextFieldView(
                                onChangeText: (email) {
                                  bloc.onEmailChanged(email);
                                },
                                hintText: HINT_TEXT_EMAIL,
                                labelText: LABEL_EMAIL);
                          },
                        ),
                        const SizedBox(
                          height: MARGIN_XLARGE,
                        ),
                        Consumer<RegisterBloc>(
                          builder: (BuildContext context, bloc, Widget? child) {
                            return LabelAndTextFieldView(
                                onChangeText: (userName) {
                                  bloc.onUserNameChange(userName);
                                },
                                hintText: HINT_TEXT_USERNAME,
                                labelText: LABEL_USERNAME);
                          },
                        ),
                        const SizedBox(
                          height: MARGIN_XLARGE,
                        ),
                        Consumer<RegisterBloc>(
                          builder: (BuildContext context, bloc, Widget? child) {
                            return LabelAndTextFieldView(
                                onChangeText: (password) {
                                  bloc.onPasswordChanged(password);
                                },
                                isPassword: true,
                                hintText: HINT_TEXT_PASSWORD,
                                labelText: LABEL_PASSWORD);
                          },
                        ),
                        const SizedBox(
                          height: MARGIN_LARGE,
                        ),
                        UploadProfilePictureView(),
                        const SizedBox(
                          height: MARGIN_LARGE,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(MARGIN_LARGE)),
                          child: Consumer<RegisterBloc>(
                            builder: (BuildContext context, bloc, Widget? child) {
                              return TextButton(
                                onPressed: () {
                                  bloc
                                      .onTapRegister()
                                      .then((value) => Navigator.pop(context))
                                      .catchError((error) {
                                    return showSnackBarWithMessage(
                                        context, error.toString());
                                  });
                                },
                                child: const PrimaryButtonView(
                                  labelText: LABEL_REGISTER,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: MARGIN_LARGE,
                        ),
                        const ORview(),
                        const SizedBox(
                          height: MARGIN_LARGE,
                        ),
                        const LoginTriggerView(),
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: isLoading,
                child: Container(
                  color: Colors.black12,
                  child: const Center(
                    child: LoadingView(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
class UploadProfilePictureView extends StatelessWidget {
  const UploadProfilePictureView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Consumer<RegisterBloc>(
            builder: (BuildContext context, bloc, Widget? child) {
              return Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                  image:  (bloc.chosenImageFile!=null) ?DecorationImage(
                    image:FileImage(bloc.chosenImageFile ?? File("")),
                    fit: BoxFit.cover,
                  ) : null,
                  color: Colors.white,
                ),
                child:(bloc.chosenImageFile==null) ? IconButton(
                  icon: Icon(
                    Icons.upload_file,
                  ),
                  onPressed: () async{
                    final ImagePicker _picker=ImagePicker();
                    final XFile? image=await _picker.pickImage(source: ImageSource.gallery);
                    if(image!=null){
                      bloc.onImageChosen(File(image.path));
                    }
                  },
                ) : null,
              );
            },

          ),
          SizedBox(
            height: MARGIN_MEDIUM_2,
          ),
          Text("Click to upload profile picture"),
        ],
      ),
    );
  }
}
class LoadingView extends StatelessWidget {
  const LoadingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: MARGIN_XXLARGE,
      height: MARGIN_XXLARGE,
      child: LoadingIndicator(
        indicatorType: Indicator.ballBeat,
        colors: [Colors.white],
        strokeWidth: 2,
        backgroundColor: Colors.transparent,
        pathBackgroundColor: Colors.black,
      ),
    );
  }
}

class LoginTriggerView extends StatelessWidget {
  const LoginTriggerView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          LABEL_DONT_HAVE_ACCOUNT,
          style: TextStyle(fontSize: TEXT_SMALL),
        ),
        GestureDetector(
          onTap: () => navigateToNextScreen(context, const LoginPage()),
          child: const Text(
            LABEL_LOGIN,
            style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.blue,
                fontSize: TEXT_SMALL,
                fontWeight: FontWeight.w700),
          ),
        )
      ],
    );
  }
}

class ORview extends StatelessWidget {
  const ORview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(LABEL_OR));
  }
}
