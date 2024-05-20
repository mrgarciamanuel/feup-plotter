library feup_plotter;

import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  var onPressed;
  final String text;

  CustomButtom({required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
