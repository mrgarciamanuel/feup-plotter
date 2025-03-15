import 'dart:developer' as developer;
import 'package:feup_plotter/controllers/constant_and_values.dart';
import 'package:feup_plotter/controllers/functions.dart';
import 'package:flutter/material.dart';

class LinePlot extends CustomPainter {
  final List<String> names = [];
  final List<Color> colors = [];
  final List<String> labels = [];
  final List<int> yValues = [];
  List<List<int>> values = [];
  final double x1Trackball;

  LinePlot(
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

  getCustomPaint(Color color, double strokeWidth, PaintingStyle style) {
    final customPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = style;
    return customPaint;
  }

  ///designs the x axis
  ///canvas: is the object we are going to draw
  ///size: is the size of the area where we are going to draw
  ///returns an array of int values containing: coordinates where we'll start building the markers of this axis
  List<int> drawXAxis(Canvas canvas, Size size) {
    //par de valores para x e y
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

  ///desenha marcadores no eixo X - as labels
  void drawXMarkers(Canvas canvas, Size size, double startX) {
    //zerar sempre no início para não acumular valores além do que preciso
    yPoints = [];
    xPoints = [];
    int valFromXaxys = 30 +
        10 +
        10; //tirar os valores do size já ocupados pelas margens do eixo
    int separator = ((size.height - valFromXaxys) / (labels.length)).ceil();
    int helper = separator;
    double x = startX;

    for (int i = 0; i < labels.length; i++) {
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

  ///desenha marcadores no eixo Y, o desenho destes marcadores é feito de cima para baixo
  void drawYMarkers(Canvas canvas, Size size, double startX) {
    int valFromYaxys = 30 +
        10 +
        10; //tirar os valores do size já ocupados pelas margens do eixo
    double finalArea = size.height - valFromYaxys;
    double separator = finalArea / yValues.length.ceil();
    int helper = separator.ceil();
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

  ///vai desenhar o ponto de encontro entre os eixos x e y
  void drawPoint(
      Canvas canvas,
      Size size,
      List<List<int>> values,
      List<List<Offset>> xPoints,
      List<List<Offset>> yPoints,
      List<int> yValues) {
    xPointValues = [];
    xPointValuesInt = [];
    yPointValuesInt = [];
    Offset endPoint = const Offset(
        0, 0); //armazena os valores finais dos pontos de interceção
    for (int j = 0; j < names.length; j++) {
      xPointValues.add([]);
      yPointValuesInt.add([]);
      Offset pointZero = Offset(30, size.height - 30);
      Offset initialPoint = pointZero;
      for (int i = 0; i < values[j].length; i++) {
        if (values[j].length == labels.length) {
          var value = values[j][i];
          var pos = yValues.indexOf(value);

          final paint = Paint()
            ..color = colors[j]
            ..strokeWidth = 3
            ..style = PaintingStyle.fill;

          canvas.drawCircle(
              Offset(xPoints[i][2].dx, yPoints[pos][2].dy), 3.5, paint);

          drawLineLink(canvas, initialPoint,
              Offset(xPoints[i][2].dx, yPoints[pos][2].dy), colors[j]);
          endPoint = Offset(xPoints[i][2].dx, yPoints[pos][2].dy);

          initialPoint = Offset(xPoints[i][2].dx, yPoints[pos][2].dy);
          xPointValues[j].add(Offset(endPoint.dx, endPoint.dy));
          if (names.length == 1) {
            if (yFinalValuesSingleMap.length < values[j].length) {
              yFinalValuesSingleMap[endPoint.dx.toInt()] = (values[j][i]);
            }
          } else {
            yFinalValuesMap[endPoint.dx.toInt()] = [values[0][i], values[1][i]];
          }

          if (!xPointValuesInt.contains(endPoint.dx.toInt())) {
            xPointValuesInt.add(endPoint.dx.toInt());
          }
          yPointValuesInt[j].add(endPoint.dy.toInt());
        } else {
          developer.log('This element has diferent size than labels');
        }
      }
    }
  }

  ///desenha uma linha que liga dois pontos
  drawLineLink(Canvas canvas, Offset p1, Offset p2, Color color) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawLine(p1, p2, paint);
  }

  ///size: é o tamanho da area onde vamos desenhar
  ///canvas: é o objeto que vamos desenhar
  ///paint: é o objeto que contém as propriedades do que desejamos desenhar: cor, espessura da linha, etc
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
    for (int i = 0; i < yPoints.length; i++) {
      setText(yValues[i].toString(), canvas, size, yPoints[i][0], "y");
    }
    //aqui escrevo os labels no eixo x
    for (int i = 0; i < labels.length; i++) {
      setText(labels[i].length > 5 ? labels[i].substring(0, 4) : labels[i],
          canvas, size, xPoints[i][0], "x");
      yFinalValuesMap[xPoints[i][0].dx.toInt()] = [];
    }
    drawPoint(canvas, size, values, xPoints, yPoints, yValues);
    drawInitialPoint(canvas, size, const Color.fromARGB(255, 0, 0, 0), 0, 0);
    drawTrackBall(canvas, size, x1Trackball, labels.length);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
