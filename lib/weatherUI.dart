import 'package:flutter/material.dart';
import 'weather.dart';

class WeatherUI extends StatelessWidget {
  final Weather weather;

  WeatherUI(this.weather);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Information'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Location: ${weather.location}',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Temperature: ${weather.temperature}°C',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Description: ${weather.description}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
