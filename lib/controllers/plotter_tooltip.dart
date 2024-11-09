import 'package:flutter/material.dart';

class PlotterToolTip extends Tooltip {
  PlotterToolTip({required Widget child, required String message})
      : super(child: child, message: message);
}
