class WeatherData {
  final String city;
  final String country;
  final String temperatureCelsius;
  final String temperatureFahrenheit;
  final String weatherDescription;

  WeatherData({
    required this.city,
    required this.country,
    required this.temperatureCelsius,
    required this.temperatureFahrenheit,
    required this.weatherDescription,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      city: json['location']['name'],
      country: json['location']['country'],
      temperatureCelsius: json['current']['temp_c'].round().toString(),
      temperatureFahrenheit: json['current']['temp_f'].round().toString(),
      weatherDescription:
          "http://${json['current']['condition']['icon'].substring(2)}",
    );
  }
}
