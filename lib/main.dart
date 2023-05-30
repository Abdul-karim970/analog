import 'dart:async';

import 'package:analog/analog_clock_painter.dart';
import 'package:flutter/material.dart';

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
        primarySwatch: Colors.blue,
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
  DateTime dateTime = DateTime.now();
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      currentTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade300,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(
                  width * 0.15, height * 0.15, width * 0.15, height * 0.15),
              width: width * 0.9,
              height: height * 0.8,
              child: CustomPaint(
                painter: AnalogClockPainter(dateTime: dateTime),
              ),
            )
          ],
        ),
      ),
    );
  }

  void currentTime() {
    setState(() {
      dateTime = DateTime.now();
    });
  }
}
