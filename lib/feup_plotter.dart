library feup_plotter;

//this will be the plot page basically
import 'package:feup_plotter/controllers/constant_and_values.dart';
import 'package:feup_plotter/controllers/functions.dart';
import 'package:feup_plotter/controllers/plotter_tooltip.dart';
import 'package:feup_plotter/views/plots/areaplot.dart';
import 'package:feup_plotter/views/plots/lineplot.dart';
import 'package:feup_plotter/views/plots/barplot.dart';
import 'package:flutter/material.dart';

class FeupPlotter extends StatefulWidget {
  final List<String> names;
  final List<Color> colors;
  final List<List<int>> result;
  final List<String> labels;
  final Color appBarBgColor;
  final String screenTitle;

  const FeupPlotter({
    super.key,
    required this.names,
    required this.colors,
    required this.result,
    required this.labels,
    required this.appBarBgColor,
    required this.screenTitle,
  });
  //this widget must bring all information we need to plot:
  //the data, the type of plot, the labels, the title, etc.

  @override
  State<FeupPlotter> createState() => _FeupPlotterState(values: result);
}

class _FeupPlotterState
    extends State<FeupPlotter> /*with TickerProviderStateMixin*/ {
  //double _progress = 0.0;
  late Animation<double> animation;
  List<List<int>> values;
  String defaultDropdownvalue = "line";
  CustomPainter? selectedPlot;
  Map<String, CustomPainter> plots = {};
  final GlobalKey<TooltipState> tooltipKey = GlobalKey<TooltipState>();

  _FeupPlotterState({required this.values});
  double xTrackball = 30;
  double yTrackball = 100;
  //double yPOs = 100;
  double ball = 20;
  bool isClick = false;
  double trackActualPositionX = 0;
  double trackActualPositionY = 0;
  String trackBallValue = "";

  @override
  void initState() {
    super.initState();

    selectedPlot = LinePlot(widget.names, widget.colors, widget.labels,
        returnPossibleValues(widget.result), widget.result, xTrackball);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    LinePlot linePlot = LinePlot(widget.names, widget.colors, widget.labels,
        returnPossibleValues(widget.result), widget.result, xTrackball);

    AreaPlot areaPlot = AreaPlot(widget.names, widget.colors, widget.labels,
        returnPossibleValues(widget.result), widget.result, xTrackball);

    BarPlot barPlot = BarPlot(widget.names, widget.colors, widget.labels,
        returnPossibleValues(widget.result), widget.result, xTrackball);

    plots = {
      "line": linePlot,
      "area": areaPlot,
      "bar": barPlot,
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.screenTitle.length < 20
            ? widget.screenTitle
            : "${widget.screenTitle.substring(0, 20)}..."),
        backgroundColor: widget.appBarBgColor,
      ),
      body: widget.labels.isNotEmpty &&
              widget.names.isNotEmpty &&
              widget.colors.isNotEmpty &&
              widget.result.isNotEmpty
          ? SizedBox(
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButton(
                        items: charts,
                        onChanged: (String? value) {
                          setState(() {
                            defaultDropdownvalue = value!;
                            selectedPlot = plots[value];
                          });
                        },
                        value: defaultDropdownvalue,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                      child: GestureDetector(
                          onHorizontalDragDown: (details) {
                            setState(() {
                              isClick = true;
                            });
                          },
                          onHorizontalDragEnd: (details) {
                            setState(() {
                              trackBallValue = getValuesFromActualTrackPosition(
                                  xTrackball, yTrackball, widget.names);
                              isClick = false;
                            });
                          },
                          onHorizontalDragUpdate: (details) {
                            if (isClick) {
                              setState(() {
                                xTrackball = details.localPosition.dx;
                                yTrackball = details.localPosition.dy;
                              });
                            }
                          },
                          onVerticalDragUpdate: (details) {
                            if (isClick) {
                              setState(() {
                                xTrackball = details.localPosition.dx;
                              });
                            }
                          },
                          child: SizedBox(
                            width: width - 10,
                            height: width - 10,
                            child: CustomPaint(
                              size: Size(width - 10, width - 10),
                              painter: selectedPlot.runtimeType ==
                                      linePlot.runtimeType
                                  ? linePlot
                                  : selectedPlot.runtimeType ==
                                          areaPlot.runtimeType
                                      ? areaPlot
                                      : barPlot,
                              child: PlotterToolTip(
                                message: trackBallValue.toString(),
                                triggerMode: TooltipTriggerMode.tap,
                                key: tooltipKey,
                                child: Container(),
                              ),
                            ),
                          ))),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(widget.names[0]),
                          Text("_______________",
                              style: TextStyle(color: widget.colors[0]))
                        ],
                      ),
                      widget.names.length > 1
                          ? Column(
                              children: [
                                Text(widget.names[1]),
                                Text(
                                  "_______________",
                                  style: TextStyle(color: widget.colors[1]),
                                )
                              ],
                            )
                          : const SizedBox(),
                    ],
                  )
                ],
              ),
            )
          : showSomethingWentWrong(width, width, "Something went wrong",
              "Please try again later or verify the data you are trying to plot."),
    );
  }
}
