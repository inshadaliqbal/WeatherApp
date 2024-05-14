import 'location.dart';
import 'networking.dart';

const apikey = "fa890d17c937d66d4ed046eaa7af1525";

class WeatherModel {
  Future<dynamic> getCityWeather(String? cityName) async {
    NetworkHelper networkHelper = await NetworkHelper(
        url:
            "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apikey");
    var collectedData = await networkHelper.getData();
    return collectedData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    double? latitude = location.latitude;
    double? longitude = location.longitude;
    NetworkHelper networkHelper = await NetworkHelper(
        url:
            "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apikey");
    var collectedData = await networkHelper.getData();
    return collectedData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
