import 'package:flutter/material.dart';

class LinePlot extends CustomPainter {
  final List<String> names = [];
  final List<Color> colors = [];
  final List<String> labels = [];
  final List<int> yValues = [];
  List<List<int>> values = [];

  LinePlot(
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

  ///designs the y axis
  ///canvas: is the object we are going to draw
  ///size: is the size of the area where we are going to draw
  ///the function return an int value in where will start building the markers of this axis
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

  ///designs the x axis
  ///canvas: is the object we are going to draw
  ///size: is the size of the area where we are going to draw
  ///returns an array containing: firs two are coordinates where we'll start building the markers of this axis and the last one are real points in the x axis
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
    return [x1.toInt() + 10, y1.toInt(), x1.toInt()];
  }

  ///desenha o ponto inicial de cruzamento os dois eixos
  void drawInitailPoint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 0, 0, 0)
      ..strokeWidth = 3
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(30, size.width - 30), 2, paint);
  }

  ///desenha marcadores no eixo X
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

  ///desenha marcadores no eixo Y
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

  ///vai desenhar o ponto de encontro entre os eixos x e y
  void drawPoint(
      Canvas canvas,
      Size size,
      List<List<int>> values,
      List<List<Offset>> xPoints,
      List<List<Offset>> yPoints,
      List<int> yValues) {
    //Map<int, Color> colors = {0: Colors.black, 1: Colors.red};
    Offset initialPoint = const Offset(0, 0);
    Offset endPoint = const Offset(0, 0);
    for (int j = 0; j < names.length; j++) {
      int cont = 0;
      for (int i = (values[j].length - 1); i >= 0; i--) {
        if (values[j].length == labels.length) {
          //posição do valor no eixo y
          var value = values[j][i];
          var pos = yValues.indexOf(value);
          //como estamos a desenhar de trás para frente, precisamos pegar o próximo valor que será tratado como o ponto inicial do próximo desenho
          if (i >= 1) {
            var nextValue = values[j][i - 1];

            var nextLabel = labels[i -
                1]; //problema nessa linha, isso obriga as labels a terem o mesmo tamanho que os valores
            var nextPosY = yValues.indexOf(nextValue);
            var nextPosX = labels.indexOf(nextLabel);
            //se for o último valor, o ponto inicial é o mesmo do final
            if (i == values[j].length - 1) {
              initialPoint =
                  Offset(xPoints[nextPosX][2].dx, yPoints[nextPosY][2].dy);
            }
            endPoint = Offset(xPoints[nextPosX][2].dx, yPoints[nextPosY][2].dy);
          }

          if (cont == 0) {
            endPoint = Offset(xPoints[i][2].dx, yPoints[pos][2].dy);
          }
          final paint = Paint()
            ..color = colors[j]
            ..strokeWidth = 3
            ..style = PaintingStyle.fill;

          canvas.drawCircle(
              Offset(xPoints[i][2].dx, yPoints[pos][2].dy), 2, paint);

          //desenho da primeira linha, começar do zero
          if (i == 0) {
            drawLineLink(canvas, Offset(30, size.height - 30),
                Offset(xPoints[i][2].dx, yPoints[pos][2].dy), colors[j]);
          } else if (i == (values[j].length - 1)) {
            //desenho da última linha
            drawLineLink(canvas, initialPoint, endPoint, colors[j]);
          } else {
            //desenho da penúltima linha até a segunda
            drawLineLink(canvas, initialPoint, endPoint, colors[j]);
            initialPoint = endPoint;
          }
          cont++;
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

  //escrever textos no canvas
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
    for (int i = 0; i < xPoints.length; i++) {
      setText(yValues[i].toString(), canvas, size, yPoints[i][0], "y");
    }
    //aqui escrevo os labels no eixo x
    for (int i = 0; i < labels.length; i++) {
      setText(labels[i], canvas, size, xPoints[i][0], "x");
    }

    drawPoint(canvas, size, values, xPoints, yPoints, yValues);
    drawInitailPoint(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
