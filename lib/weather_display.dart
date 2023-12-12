// weather_page.dart
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weatherUI.dart';
import 'fetch_data.dart';
import 'namedLocation.dart';
import 'weather.dart'; // Import the LocationInput class

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _getLocationAndWeather();
  }

  Future<void> _getLocationAndWeather() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    Weather weather = (await WeatherService.fetchWeatherByCoordinates(position.latitude, position.longitude)) as Weather;
    setState(() {
      _weather = weather;
    });
  }

  Future<void> _getWeatherForLocation(String location) async {
    Weather weather = await WeatherService.fetchWeatherByLocationName(location);
    setState(() {
      _weather = weather;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        backgroundColor: Colors.cyan,
      ),
      body: Center(
        child: _weather != null
            ? WeatherUI(_weather!)
            : CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String? location = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LocationInput()),
          );
          if (location != null) {
            await _getWeatherForLocation(location);
          }
        },
        child: Icon(Icons.search),
      ),
    );
  }
}
