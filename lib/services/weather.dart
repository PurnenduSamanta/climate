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
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
