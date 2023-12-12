import 'package:flutter/material.dart';
import 'package:weather/weather_display.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
