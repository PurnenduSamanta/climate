import 'package:climate/services/location.dart';
import 'package:climate/services/networking.dart';

const apiKey="Enter Your Own API key found on https://openweathermap.org/";
class WeatherModel {

  Future<dynamic> getLocationWeather() async
  {
    Location location=Location();
    await location.getCurrentLocation();
    double latitude=location.latitude;
    double longitude=location.longitude;
    NetworkHelper networkHelper=NetworkHelper('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&&units=metric');
    var weatherData=await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getCityWeather(String cityName) async
  {
    String url='https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&&units=metric';
    NetworkHelper networkHelper=new NetworkHelper(url);
    var weatherData=await networkHelper.getData();
    return weatherData;
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
