import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_keys.dart';
import '../Model/weather_model.dart';

class WeatherAPI {
  final String apiKey = weatherAPIKey;

  Future<WeatherData> getWeatherData(String city) async {
    final url = Uri.parse(
        "http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return WeatherData.fromJson(data);
    } else {
      throw Exception('Error getting weather data');
    }
  }
}
