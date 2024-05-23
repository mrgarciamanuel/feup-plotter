library feup_plotter;

//this will be the plot page basically
import 'package:feup_plotter/controllers/functions.dart';
import 'package:flutter/material.dart';
import 'package:feup_plotter/models/data.dart';

class FeupPlotter extends StatefulWidget {
  final List<Data> data;
  final List<List<int>> result;
  final List<String> labels;
  final String texto;//to remove later
  const FeupPlotter({super.key, required this.data, required this.result,required this.labels,  required this.texto});
  //this widget must bring all information we need to plot:
  //the data, the type of plot, the labels, the title, etc.

  @override
  State<FeupPlotter> createState() => _FeupPlotterState(values: result);
}

@override
void initState() {
  initState();
  //List<int> yValues = returnPossibleValues(widget.result);
}

class _FeupPlotterState extends State<FeupPlotter> { 
  List<List<int>> values;
  String defaultDropdownvalue = "line";
  CustomPainter? selectedPlot;
  Map<String, CustomPainter> plots = {};

  _FeupPlotterState({required this.values});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plotter page'),
      ),
      body: Center(
        child: Text(widget.texto),
      ),
    );
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
