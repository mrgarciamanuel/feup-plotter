import 'package:flutter/material.dart';

class PlotterToolTip extends Tooltip {
  const PlotterToolTip(
      {super.key,
      required Widget child,
      required String message,
      required TooltipTriggerMode triggerMode})
      : super(child: child, message: message, triggerMode: triggerMode);
}
