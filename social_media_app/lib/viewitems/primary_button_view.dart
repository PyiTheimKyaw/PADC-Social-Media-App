import 'package:flutter/material.dart';
import 'package:social_media_app/resources/dimens.dart';

class PrimaryButtonView extends StatelessWidget {
  const PrimaryButtonView({
    Key? key,
    required this.labelText,
    this.color=Colors.black,
  }) : super(key: key);
  final String labelText;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MARGIN_XXLARGE,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(MARGIN_LARGE)),
      child: Center(
        child: Text(
          labelText,
          style: const TextStyle(
              color: Colors.white,
              fontSize: TEXT_REGULAR_2X,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}