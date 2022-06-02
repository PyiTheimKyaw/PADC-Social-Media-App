import 'package:flutter/material.dart';

class PrimaryButtonView extends StatelessWidget {
  const PrimaryButtonView({
    Key? key,
    required this.labelText,
  }) : super(key: key);
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Text(
      labelText,
      style: const TextStyle(color: Colors.white),
    );
  }
}