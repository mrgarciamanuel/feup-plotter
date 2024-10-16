import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

Widget showSomethingWentWrong(
    double hight, double width, String errorMessage1, String errorMessage2) {
  var widget = Container(
    margin: const EdgeInsets.all(0),
    width: width * 0.9,
    height: hight * 0.5,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          errorMessage1,
          style: const TextStyle(fontSize: 15, color: Colors.red),
        ),
        const Icon(Icons.error, color: Colors.red, size: 100),
        Text(
          errorMessage2,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, color: Colors.red),
        ),
      ],
    ),
  );
  return widget;
}

showSnackBar(BuildContext context, String message, int error) {
  showTopSnackBar(
    Overlay.of(context),
    error == 0
        ? CustomSnackBar.success(message: message)
        : CustomSnackBar.error(message: message),
  );
}

returnPossibleValues(List<List<int>> values) {
  List<int> valores = [];
  for (int i = 0; i < values.length; i++) {
    for (int j = 0; j < values[i].length; j++) {
      if (!valores.contains(values[i][j])) {
        valores.add(values[i][j]);
      }
    }
  }
  valores.sort();
  return valores;
}

///designs the y axis
///canvas: is the object we are going to draw
///size: is the size of the area where we are going to draw
///the function return an int list values in where will start building the markers of this axis
List<int> drawYAxis(Canvas canvas, Size size) {
  double x1 = 30;
  double x2 = 30;
  double y1 = 10;
  double y2 = size.height - 10;

  final p1 = Offset(x1, y1);
  final p2 = Offset(x2, y2);

  final paint = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;
  canvas.drawLine(p1, p2, paint);
  return [x1.toInt() - 10, x2.toInt() - 10];
}

///Method used to draw initial point and somethimes to test the draw of the points
void drawInitailPoint(
    Canvas canvas, Size size, Color color, double x, double y) {
  if (x == 0) {
    x = 30;
    y = 30;
  }
  final paint = Paint()
    ..color = color
    ..strokeWidth = 3
    ..style = PaintingStyle.fill;
  canvas.drawCircle(Offset(x, size.width - y), 2, paint);
}

//escrever textos no canvas
void setText(
    String text, Canvas canvas, Size size, Offset location, String axis) {
  const textStyle = TextStyle(
    color: Colors.black,
    fontSize: 12,
  );

  var textSpan = TextSpan(
    text: text,
    style: textStyle,
  );

  var textPainter = TextPainter(
    text: textSpan,
    textDirection: TextDirection.ltr,
  );

  textPainter.layout(
    minWidth: 0,
    maxWidth: size.width,
  );

  textPainter.paint(
    canvas,
    Offset(axis == "x" ? location.dx - 10 : location.dx - 10,
        axis == "x" ? location.dy : location.dy - 10),
  );
}
