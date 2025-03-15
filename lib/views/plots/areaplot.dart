import 'package:feup_plotter/controllers/functions.dart';
import 'package:flutter/material.dart';

// class of a graphic that makes a visual representation of data that utilizes both lines and filled areas to convey information.
class AreaPlot extends CustomPainter {
  final List<String> names = [];
  final List<Color> colors = [];
  final List<String> labels = [];
  final List<int> yValues = [];
  List<List<int>> values = [];
  final double x1Trackball;

  AreaPlot(
    List<String> names,
    List<Color> colors,
    List<String> labels,
    List<int> yValues,
    List<List<int>> values,
    this.x1Trackball,
  ) {
    this.names.addAll(names);
    this.colors.addAll(colors);
    this.labels.addAll(labels);
    this.yValues.addAll(yValues);
    this.values = values;
  }

  List<List<Offset>> xPoints = [];
  List<List<Offset>> yPoints = [];
  double positionAxleX = 0;

  Paint getCustomPaint(Color color, double strokeWidth, PaintingStyle style) {
    final customPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = style;
    return customPaint;
  }

  List<int> drawXAxis(Canvas canvas, Size size) {
    const double x1 = 10;
    double x2 = size.width - 10;
    double y1 = size.height - 30;
    double y2 = size.height - 30;

    final p1 = Offset(x1, y1);
    final p2 = Offset(x2, y2);

    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawLine(p1, p2, paint);
    positionAxleX = y1;
    return [x1.toInt() + 10, y1.toInt(), x1.toInt()];
  }

  void drawXMarkers(Canvas canvas, Size size, double startX) {
    yPoints = [];
    xPoints = [];
    int valFromXaxys = 30 +
        10 +
        10; //tirar os valores do size já ocupados pelas margens do eixo
    int separator = ((size.width - valFromXaxys) / (labels.length)).ceil();
    int helper = separator;
    double x = startX;

    for (int i = 0; i < yValues.length; i++) {
      final p1 = Offset(x + separator, size.height - 25);
      final p2 = Offset(x + separator, size.height - 35);
      final p3 = Offset(x + separator, size.height - 30);

      if (i < labels.length) {
        canvas.drawLine(
            p1, p2, getCustomPaint(Colors.black, 1, PaintingStyle.stroke));
      }
      xPoints.add([p1, p2, p3]);
      separator += helper;
    }
  }

  void drawYMarkers(Canvas canvas, Size size, double startX) {
    int valFromYaxys = 30 +
        10 +
        10; //tirar os valores do size já ocupados pelas margens do eixo
    int separator = ((size.height - valFromYaxys) / (yValues.length)).ceil();
    int helper = separator;
    double x = startX;
    double y = size.height - helper;

    if (y != positionAxleX) {
      y = positionAxleX;
    }

    for (int i = 0; i < yValues.length; i++) {
      final p1 = Offset(x, y - separator); //ponto de partida da linha
      final p2 =
          Offset(x + size.width - 30, y - separator); //ponto final da linha
      final p3 = Offset(x + 10, y - separator);
      canvas.drawLine(
          p1, p2, getCustomPaint(Colors.grey, 1, PaintingStyle.stroke));
      yPoints.add([p1, p2, p3]);
      separator += helper;
    }
  }

  //draws the area for each element
  void drawArea(
      Canvas canvas,
      Size size,
      List<List<int>> values,
      List<List<Offset>> xPoints,
      List<List<Offset>> yPoints,
      List<int> yValues) {
    Path path = Path();

    for (int j = 0; j < names.length; j++) {
      path.reset();
      path.moveTo(30, size.height - 30);

      for (int i = 0; i < values[j].length; i++) {
        var value = values[j][i];
        var pos = yValues.indexOf(value);
        path.lineTo(xPoints[i][2].dx, yPoints[pos][2].dy);
      }

      path.lineTo(
          xPoints[labels.length - 1][2].dx,
          size.height -
              30); //o preenchimento final terá o último marker das labels
      path.close();

      final paint = Paint()
        ..color = colors[j].withOpacity(0.4)
        ..style = PaintingStyle.fill;

      canvas.drawPath(path, paint);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 58, 58, 58).withOpacity(.8)
      ..style = PaintingStyle.stroke;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, paint);
    int startXaxiX = drawXAxis(canvas, size)[0];
    int startXaxiY = drawYAxis(canvas, size)[0];

    drawXMarkers(canvas, size, startXaxiX.toDouble());
    drawYMarkers(canvas, size, startXaxiY.toDouble());

    //aqui escrevo os textos no eixo y
    for (int i = 0; i < xPoints.length; i++) {
      setText(yValues[i].toString(), canvas, size, yPoints[i][0], "y");
    }
    //aqui escrevo os labels no eixo x
    for (int i = 0; i < labels.length; i++) {
      setText(labels[i].length > 5 ? labels[i].substring(0, 4) : labels[i],
          canvas, size, xPoints[i][0], "x");
    }

    drawArea(canvas, size, values, xPoints, yPoints, yValues);
    drawInitialPoint(canvas, size, const Color.fromARGB(255, 0, 0, 0), 0, 0);
    drawTrackBall(canvas, size, x1Trackball, labels.length);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
