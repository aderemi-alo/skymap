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
      city: json['location']['name'],
      country: json['location']['country'],
      temperature: json['current']['temp_c'].toString(),
      weatherDescription: json['current']['condition']['text'],
    );
  }
}
