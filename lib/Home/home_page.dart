import 'package:flutter/material.dart';
import '../API/weather_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherData? weatherData;

  @override
  void initState() {
    super.initState();
    getWeatherData();
  }

  Future<void> getWeatherData() async {
    weatherData = await WeatherAPI().getWeatherData("London");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Weather Data"),
        ),
        body: weatherData != null
            ? Column(
                children: [
                  Text(weatherData!.city),
                  Text(weatherData!.country),
                  Text(weatherData!.temperature),
                  Text(weatherData!.weatherDescription)
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [CircularProgressIndicator()],
                ),
              ));
  }
}
