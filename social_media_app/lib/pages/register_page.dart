import 'package:flutter/material.dart';
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
    return Scaffold(
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: TEXT_BIG),
              ),
              const SizedBox(
                height: MARGIN_XLARGE,
              ),
              LabelAndTextFieldView(
                  onChangeText: (email) {},
                  hintText: HINT_TEXT_EMAIL,
                  labelText: LABEL_EMAIL),
              const SizedBox(
                height: MARGIN_XLARGE,
              ),
              LabelAndTextFieldView(
                  onChangeText: (userName) {},
                  hintText: HINT_TEXT_USERNAME,
                  labelText: LABEL_USERNAME),
              const SizedBox(
                height: MARGIN_XLARGE,
              ),
              LabelAndTextFieldView(
                  onChangeText: (email) {},
                  hintText: HINT_TEXT_PASSWORD,
                  labelText: LABEL_PASSWORD),
              const SizedBox(
                height: MARGIN_LARGE,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(MARGIN_LARGE)),
                child: TextButton(
                  onPressed: () {},
                  child: const PrimaryButtonView(
                    labelText: LABEL_REGISTER,
                  ),
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
          onTap: () => navigateToScreen(context, const LoginPage()),
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
