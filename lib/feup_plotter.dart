library feup_plotter;

//this will be the plot page basically
import 'package:flutter/material.dart';

class FeupPlotter extends StatefulWidget {
  var texto;
  FeupPlotter({required this.texto});
  //this widget must bring all information we need to plot:
  //the data, the type of plot, the labels, the title, etc.

  @override
  State<FeupPlotter> createState() => _FeupPlotterState();
}

@override
void initState() {
  initState();
}

class _FeupPlotterState extends State<FeupPlotter> {
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
