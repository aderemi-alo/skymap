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
  TextEditingController locationController = TextEditingController();
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
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SearchBar(
                      onSubmitted: (value) async {
                        await getWeatherData(value);
                        locationController.clear();
                      },
                      elevation: MaterialStateProperty.all(0),
                      controller: locationController,
                      hintText: "Where?",
                      backgroundColor: MaterialStateProperty.all(
                        Colors.transparent.withOpacity(0.2),
                      ),
                      trailing: [
                        IconButton(
                          onPressed: () {
                            locationController.clear();
                          },
                          icon: Icon(Icons.clear),
                        )
                      ],
                      leading: Icon(Icons.search),
                    ),
                    Text(weatherData!.city),
                    Text(weatherData!.country),
                    Text(weatherData!.temperatureCelsius),
                    Text(weatherData!.temperatureFahrenheit),
                    Image.network(weatherData!.weatherDescription),
                    IconButton(
                        onPressed: () async {
                          position = await Geolocator.getCurrentPosition(
                              desiredAccuracy: LocationAccuracy.best);
                          getWeatherData(
                              "${position.longitude} ${position.latitude}");
                        },
                        icon: const Icon(CupertinoIcons.map_pin_ellipse))
                  ],
                ),
              )
            : const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [CircularProgressIndicator()],
                ),
              ));
  }
}
