import 'package:flutter/material.dart';

var charts = [
  const DropdownMenuItem(
    value: "line",
    child: Text("Line Graph"),
  ),
  const DropdownMenuItem(
    value: "area",
    child: Text("Area Graph"),
  ),
  const DropdownMenuItem(
    value: "bar",
    child: Text("Bar Graph"),
  ),
];

List<List<Offset>> xPointValues = [];
List<int> xPointValuesInt = [];
List<List<int>> yPointValuesInt = [];
Map<int, List<int>> yFinalValuesMap = {};
Map<int, int> yFinalValuesSingleMap = {};
