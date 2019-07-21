import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const APIkey = '134c38e9e0a9c5c80d36aa2cd7bedd79';
const ServiceURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {


  Future<dynamic> getWeatherDatabyCity(String cityName) async {

    NetworkHelper net = NetworkHelper('$ServiceURL?q=${cityName}&APPID=$APIkey&units=metric');

    var data = await net.getData();

    return data;
  }

  Future<dynamic> getWeatherData() async {

    Location loc = Location();
    await loc.getCurrentLocation();

    NetworkHelper net = NetworkHelper('$ServiceURL?lat=${loc.latitude}&lon=${loc.longitude}&APPID=$APIkey&units=metric');

    var data = await net.getData();

    return data;

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
