import 'package:flutter/material.dart';
import 'dart:convert';
import 'weather.dart';
import 'cityscreen.dart';

class LocationScreen extends StatefulWidget {
  String? locationWeather;

  LocationScreen({this.locationWeather});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int? temperature;
  String? city;
  String? cityMessage;
  String? weatherIcon;
  WeatherModel weatherModel = WeatherModel();

  void updateUI(dynamic weatherData) {
    if (weatherData == null) {
      temperature = 0;
      city = "Sorry Error";
      weatherIcon = "0";
      cityMessage = "Opps unexpected";
    } else {
      setState(() {
        var temp = jsonDecode(weatherData)["main"]["temp"];
        var cityID = jsonDecode(weatherData)["weather"][0]["id"];
        var cityName = jsonDecode(weatherData)["name"];
        temperature = temp.toInt();
        weatherIcon = weatherModel.getWeatherIcon(cityID);
        cityMessage = weatherModel.getMessage(temperature!);
        city = cityName;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepOrangeAccent[100],
        padding: EdgeInsets.all(2),
        child: Column(
          children: [
            SizedBox.fromSize(
              size: Size(1, 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () async {
                    var typedNamed = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return CityScreen();
                        },
                      ),
                    );
                    var collectedData =
                        await weatherModel.getCityWeather(typedNamed);
                    updateUI(collectedData);
                  },
                  child: const Icon(
                    Icons.location_city,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    var weatherData = await weatherModel.getLocationWeather();
                    updateUI(weatherData);
                  },
                  child: const Icon(
                    Icons.location_history,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox.fromSize(
              size: Size(1, 40),
            ),
            Text(
              "$city",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 4),
            ),
            SizedBox.fromSize(
              size: Size(1, 80),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Temperature in your City is $temperature F $weatherIcon",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2),
              ),
            ),
            SizedBox.fromSize
              size: Size(1, 100),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Condition of the city is:- $cityMessage",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
