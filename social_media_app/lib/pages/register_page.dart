import 'package:flutter/material.dart';
import 'package:social_media_app/resources/dimens.dart';
import 'package:social_media_app/resources/strings.dart';
import 'package:social_media_app/utils/extensions.dart';
import 'package:social_media_app/widgets/label_and_textfield_view.dart';
import 'package:social_media_app/widgets/or_view.dart';
import 'package:social_media_app/widgets/primary_button_view.dart';

import 'news_feed_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: LOGIN_SCREEN_TOP_PADDING,
          bottom: MARGIN_LARGE,
          left: MARGIN_XLARGE,
          right: MARGIN_XLARGE,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              LBL_REGISTER,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: TEXT_BIG,
              ),
            ),
            const SizedBox(
              height: MARGIN_XXLARGE,
            ),
            LabelAndTextFieldView(
              label: LBL_EMAIL,
              hint: HINT_EMAIL,
              onChanged: (email) {},
            ),
            const SizedBox(
              height: MARGIN_XLARGE,
            ),
            LabelAndTextFieldView(
              label: LBL_USER_NAME,
              hint: HINT_USER_NAME,
              onChanged: (email) {},
              isSecure: true,
            ),
            const SizedBox(
              height: MARGIN_XLARGE,
            ),
            LabelAndTextFieldView(
              label: LBL_PASSWORD,
              hint: HINT_PASSWORD,
              onChanged: (email) {},
              isSecure: true,
            ),
            const SizedBox(
              height: MARGIN_XXLARGE,
            ),
            TextButton(
              onPressed: () {
                navigateToScreen(context, const NewsFeedPage());
              },
              child: const PrimaryButtonView(
                label: LBL_REGISTER,
              ),
            ),
            const SizedBox(
              height: MARGIN_LARGE,
            ),
            const ORView(),
            const SizedBox(
              height: MARGIN_LARGE,
            ),
            const LoginTriggerView()
          ],
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
          LBL_ALREADY_HAVE_AN_ACCOUNT,
        ),
        const SizedBox(width: MARGIN_SMALL),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Text(
            LBL_LOGIN,
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    );
  }
}
