import 'package:flutter/material.dart';

class BarPlot extends CustomPainter {
  final List<String> names = [];
  final List<Color> colors = [];
  final List<String> labels = [];
  final List<int> yValues = [];
  List<List<int>> values = [];

  BarPlot(
    List<String> names,
    List<Color> colors,
    List<String> labels,
    List<int> yValues,
    List<List<int>> values,
  ) {
    this.names.addAll(names);
    this.colors.addAll(colors);
    this.labels.addAll(labels);
    this.yValues.addAll(yValues);
    this.values = values;
  }

  List<List<Offset>> xPoints = [];
  List<List<Offset>> yPoints = [];

  getCustomPaint(Color color, double strokeWidth, PaintingStyle style) {
    final customPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = style;
    return customPaint;
  }

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
    return [x1.toInt() + 10, y1.toInt(), x1.toInt()];
  }

  void drawInitailPoint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 0, 0, 0)
      ..strokeWidth = 3
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(30, size.width - 30), 2, paint);
  }

  void drawXMarkers(Canvas canvas, Size size, double startX) {
    yPoints = [];
    xPoints = [];
    int valorFromXaxys = 30 +
        10 +
        10; //tirar os valores do size já ocupados pelas margens do eixo
    int separator = ((size.height - valorFromXaxys) / (labels.length)).ceil();
    int helper = separator;
    double x = startX;

    for (int i = 0; i < yValues.length; i++) {
      final p1 = Offset(x + separator, size.height - 25);
      final p2 = Offset(x + separator, size.height - 35);
      final p3 = Offset(x + separator, size.height - 30);
      canvas.drawLine(
          p1, p2, getCustomPaint(Colors.black, 1, PaintingStyle.stroke));
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

  void drawBars(
      Canvas canvas,
      Size size,
      List<List<int>> values,
      List<List<Offset>> xPoints,
      List<List<Offset>> yPoints,
      List<int> yValues) {
    double barWidth = 20;
    for (int j = 0; j < names.length; j++) {
      for (int i = 0; i < values[j].length; i++) {
        var value = values[j][i];
        var pos = yValues.indexOf(value);
        final paint = Paint()
          ..color = colors[j].withOpacity(0.4)
          ..style = PaintingStyle.fill;

        canvas.drawRect(
          Rect.fromLTWH(xPoints[i][2].dx - barWidth / 2, yPoints[pos][2].dy,
              barWidth, size.height - 30 - yPoints[pos][2].dy),
          paint,
        );
      }
    }
  }

  setText(String text, Canvas canvas, size, Offset location, String axis) {
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

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 58, 58, 58).withOpacity(.8)
      ..style = PaintingStyle.stroke;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(
      rect,
      paint,
    );
    drawXAxis(canvas, size);
    drawYAxis(canvas, size);
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

    drawBars(canvas, size, values, xPoints, yPoints, yValues);
    drawInitailPoint(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
