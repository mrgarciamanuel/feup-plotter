import 'package:flutter/material.dart';

class Data {
  final String name;
  final String simbol;
  final String location;
  final String imgURL;
  final String country;
  final String industry;
  final String url;
  final MaterialColor color;
  bool? value;

  Data(
      {required this.name,
      required this.simbol,
      required this.location,
      required this.imgURL,
      required this.country,
      required this.industry,
      required this.url,
      required this.color,
      this.value});

  factory Data.fromJson(Map<String, dynamic> jsonObj) => Data(
        name: jsonObj['name'],
        simbol: jsonObj['simbol'],
        location: jsonObj['location'],
        imgURL: jsonObj['imgURL'],
        country: jsonObj['country'],
        industry: jsonObj['industry'],
        url: jsonObj['url'],
        color: jsonObj['color'],
      );
}
