import 'package:flutter/material.dart';
import 'package:feup_plotter/feup_plotter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<int>> result = [];
  @override
  void initState() {
    super.initState();
    result = [
      [193, 192, 190, 1, 190, 188, 1, 8, 200, 193, 192, 190],
      [160, 177, 177, 190, 173, 172, 170, 160, 180, 8, 188, 160]
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FeupPlotter(
      names: const ["Microsoft Inc.", "Tesla"],
      colors: const [Colors.red, Colors.blue],
      labels: const [
        "january",
        "february",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December"
      ],
      result: result,
      appBarBgColor: Colors.green,
      screenTitle: "Company's revenue in last seven days",
    );
  }
}
