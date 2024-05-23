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

returnPossibleValues(List<List<int>> values){
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

/*
generateGraph(BuildContext context, List<Company> companies) {
  List<Company> data = [];
  for (var company in companies) {
    if (company.value == true) {
      data.add(company);
    }
  }

  if (data.isNotEmpty) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PlotPage(
                  companies: data,
                )));
  } else {
    showSnackBar(context, "Need to select at least one company", 1);
  }
}*/