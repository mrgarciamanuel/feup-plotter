library feup_plotter;

//this will be the plot page basically
import 'package:feup_plotter/controllers/constant_and_values.dart';
import 'package:feup_plotter/controllers/functions.dart';
import 'package:feup_plotter/views/plots/lineplot.dart';
import 'package:flutter/material.dart';
import 'package:feup_plotter/models/data.dart';

class FeupPlotter extends StatefulWidget {
  final List<String> names;
  final List<Color> colors;
  final List<List<int>> result;
  final List<String> labels;
  final String texto; //to remove later
  const FeupPlotter(
      {super.key,
      required this.names,
      required this.colors,
      required this.result,
      required this.labels,
      required this.texto});
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
    /*plots = {
      "line" : LinePlot(),
      "area": LinePlot();
    } */
    //List<int> yValues = returnPossibleValues(widget.result);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Plotter page'),
        ),
        body: SizedBox(
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
              )
            ],
          ),
        ));
  }
}


/*class CustomButtom extends StatelessWidget {
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

  //TODO: implementar a os devidos plots começar com o lineplot
  //criar o plot page, poderá ser mesmo essa página
}*/
