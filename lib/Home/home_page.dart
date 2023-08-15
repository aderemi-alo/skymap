import 'package:flutter/material.dart';
import '../API/weather_api.dart';
import '../Model/location_model.dart';
import '../Model/weather_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherData? weatherData;
  TextEditingController placeController = TextEditingController();
  dynamic location = "Lekki";
  late Position position;

  @override
  void initState() {
    super.initState();
    getWeatherData(location);
  }

  Future<void> getWeatherData(dynamic location) async {
    weatherData = await WeatherAPI().getWeatherData(location);
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
                  TextFormField(
                    controller: placeController,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              getWeatherData(placeController.text.trim());
                            },
                            icon: Icon(Icons.check))),
                  ),
                  Text(weatherData!.city),
                  Text(weatherData!.country),
                  Text(weatherData!.temperature),
                  Text(weatherData!.weatherDescription),
                  IconButton(
                      onPressed: () async {
                        position = await Geolocator.getCurrentPosition(
                            desiredAccuracy: LocationAccuracy.best);
                        getWeatherData(
                            "${position.longitude} ${position.latitude}");
                      },
                      icon: Icon(CupertinoIcons.map_pin_ellipse))
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [CircularProgressIndicator()],
                ),
              ));
  }
}
