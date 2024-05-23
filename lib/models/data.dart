import 'package:flutter/material.dart';

class Data {
  final String name;
  final MaterialColor color;
  bool? value;

  Data(
      {required this.name,
      required this.color,
      this.value});

  factory Data.fromJson(Map<String, dynamic> jsonObj) => Data(
        name: jsonObj['name'],
        color: jsonObj['color'],
      );
}
