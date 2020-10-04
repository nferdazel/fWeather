import 'package:flutter/material.dart';
import 'package:fWeather/services/location.dart';
import 'package:fWeather/services/network.dart';
import 'package:fWeather/config.dart';
import 'package:weather_icons/weather_icons.dart';

const openWeatherURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> cityWeather(String cityName) async {
    var apiUrl = '$openWeatherURL?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(apiUrl);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> locationWeather() async {
    Location location = new Location();
    await location.getCurrentLocation();
    NetworkHelper networkhelper = NetworkHelper(
        '$openWeatherURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weatherData = await networkhelper.getData();

    return weatherData;
  }

  String getMessage(int temp) {
    if (temp > 33) {
      return 'It\'s 🍦 time';
    } else if (temp > 28) {
      return 'Time for shorts,shades and 👕';
    } else if (temp < 17) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 & ☂ (just in case)';
    }
  }

  Icon getWeatherIcon(int condition) {
    if (condition < 300) {
      return Icon(
        WeatherIcons.thunderstorm,
        color: Colors.blue,
      );
    } else if (condition < 400) {
      return Icon(
        WeatherIcons.rain_mix,
        color: Colors.blue,
      );
    } else if (condition < 600) {
      return Icon(
        WeatherIcons.rain,
        color: Colors.blue,
      );
    } else if (condition < 700) {
      return Icon(
        WeatherIcons.snowflake_cold,
        color: Colors.blue,
      );
    } else if (condition < 800) {
      return Icon(
        WeatherIcons.day_windy,
        color: Colors.blue,
      );
    } else if (condition == 800) {
      return Icon(
        WeatherIcons.day_sunny,
        color: Colors.blue,
      );
    } else if (condition <= 804) {
      return Icon(
        WeatherIcons.cloud,
        color: Colors.blue,
      );
    } else {
      return null;
    }
  }

  String subText(int condition) {
    if (condition < 300) {
      return "Thunderstorm";
    } else if (condition < 400) {
      return "Drizzle";
    } else if (condition < 600) {
      return "Hmm its Raining";
    } else if (condition < 700) {
      return "Snow";
    } else if (condition < 800) {
      return "Wind's Howling";
    } else if (condition == 800) {
      return "Sunny";
    } else if (condition <= 804) {
      return "Cloudy";
    } else
      return null;
  }
}
