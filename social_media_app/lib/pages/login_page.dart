import 'package:flutter/material.dart';
import 'package:social_media_app/pages/news_feed_page.dart';
import 'package:social_media_app/pages/register_page.dart';
import 'package:social_media_app/resources/dimens.dart';
import 'package:social_media_app/resources/strings.dart';
import 'package:social_media_app/utils/extensions.dart';
import 'package:social_media_app/widgets/label_and_textfield_view.dart';
import 'package:social_media_app/widgets/or_view.dart';
import 'package:social_media_app/widgets/primary_button_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
              LBL_LOGIN,
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
                label: LBL_LOGIN,
              ),
            ),
            const SizedBox(
              height: MARGIN_LARGE,
            ),
            const ORView(),
            const SizedBox(
              height: MARGIN_LARGE,
            ),
            const RegisterTriggerView()
          ],
        ),
      ),
    );
  }
}

class RegisterTriggerView extends StatelessWidget {
  const RegisterTriggerView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          LBL_DONT_HAVE_AN_ACCOUNT,
        ),
        const SizedBox(width: MARGIN_SMALL),
        GestureDetector(
          onTap: () => navigateToScreen(
            context,
            const RegisterPage(),
          ),
          child: const Text(
            LBL_REGISTER,
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
