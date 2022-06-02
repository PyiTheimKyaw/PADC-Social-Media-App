import 'package:flutter/material.dart';
import 'package:social_media_app/resources/dimens.dart';

class LabelAndTextFieldView extends StatelessWidget {
  const LabelAndTextFieldView({
    Key? key,
    required this.onChangeText,
    required this.hintText,
    required this.labelText,
    this.isPassword = false,
  }) : super(key: key);
  final Function(String) onChangeText;
  final String hintText;
  final String labelText;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText),
        const SizedBox(
          height: MARGIN_SMALL,
        ),
        TextField(
          onChanged: (text) {
            onChangeText(text);
          },
          obscureText: (isPassword) ? true : false,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
              borderSide: const BorderSide(width: 1, color: Colors.grey),
            ),
            hintText: hintText,
          ),
        ),
      ],
    );
  }
}
