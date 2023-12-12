import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'weather.dart';

class WeatherService {
  static const String apiKey = 'de735372448245f853abca2548cf0d22'; // Replace with your actual API key
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  static Future<Weather> fetchWeatherByLocationName(String locationName) async {
    final url = '$baseUrl?q=$locationName&appid=$apiKey&units=metric'; // Using metric units for temperature

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final location = data['name'];
      final temperature = data['main']['temp'];
      final description = data['weather'][0]['description'];

      return Weather(location: location, temperature: temperature, description: description);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  static Future<Weather> fetchWeatherByCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      return fetchWeatherByCoordinates(position.latitude, position.longitude);
    } catch (e) {
      throw Exception('Failed to get current location: $e');
    }
  }

  static Future<Weather> fetchWeatherByCoordinates(double latitude, double longitude) async {
    final url = '$baseUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric'; // Using metric units for temperature

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final location = data['name'];
      final temperature = data['main']['temp'];
      final description = data['weather'][0]['description'];

      return Weather(location: location, temperature: temperature, description: description);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
