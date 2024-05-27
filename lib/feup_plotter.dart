library feup_plotter;

//this will be the plot page basically
import 'package:feup_plotter/controllers/constant_and_values.dart';
import 'package:feup_plotter/controllers/functions.dart';
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

  const FeupPlotter({
    super.key,
    required this.names,
    required this.colors,
    required this.result,
    required this.labels,
    required this.appBarBgColor,
  });
  //this widget must bring all information we need to plot:
  //the data, the type of plot, the labels, the title, etc.

  @override
  State<FeupPlotter> createState() => _FeupPlotterState(values: result);
}

class _FeupPlotterState extends State<FeupPlotter> {
  List<List<int>> values;
  String defaultDropdownvalue = "line";
  CustomPainter? selectedPlot;
  Map<String, CustomPainter> plots = {};

  _FeupPlotterState({required this.values});

  @override
  void initState() {
    super.initState();
    selectedPlot = LinePlot(widget.names, widget.colors, widget.labels,
        returnPossibleValues(widget.result), widget.result);

    plots = {
      "line": LinePlot(widget.names, widget.colors, widget.labels,
          returnPossibleValues(widget.result), widget.result),
      "area": AreaPlot(widget.names, widget.colors, widget.labels,
          returnPossibleValues(widget.result), widget.result),
      "bar": BarPlot(widget.names, widget.colors, widget.labels,
          returnPossibleValues(widget.result), widget.result),
    };
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plotter page'),
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
                    child: CustomPaint(
                      size: Size(width - 10, width - 10),
                      painter: selectedPlot,
                    ),
                  ),
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
          : showSomethingWentWrong(
              width, width, "No data to plot", "Please provide data to plot"),
    );
  }
}
