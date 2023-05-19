import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_keys.dart';

class WeatherAPI {
  final String apiKey = weatherAPIKey;

  Future<WeatherData> getWeatherData(String city) async {
    final url = Uri.parse(
        "http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data['current']['condition']['text']);
      return WeatherData.fromJson(data);
    } else {
      throw Exception('Error getting weather data');
    }
  }
}

class WeatherData {
  final String city;
  final String country;
  final String temperature;
  final String weatherDescription;

  WeatherData({
    required this.city,
    required this.country,
    required this.temperature,
    required this.weatherDescription,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      city: json['location']['name'] as String,
      country: json['location']['country'] as String,
      temperature: json['current']['temp_c'].toString(),
      weatherDescription: json['current']['condition']['text'] as String,
    );
  }
}
