library feup_plotter;

import 'package:flutter/material.dart';

/// import 'package:flutter/material.dart';A Calculator.
///
/*
class Calculator {
  /// import 'package:flutter/material.dart';Returns [value
  /// ] plus 1.
  int addOne(int value) => value + 1;
}*/

class CustomButton extends StatelessWidget {
  var onPressed;
  final Widget child;
  var style;
  const CustomButton(
      {/*super.key*/ Key key, this.onPressed, this.child, this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
          primary: Colors.white,
          backgroundColor: Colors.white,
          elevation: 9.0,
          textStyle: const TextStyle(fontSize: 20)),
      child: child,
    );
  }
}
