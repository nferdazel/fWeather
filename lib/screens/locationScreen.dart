import 'package:fWeather/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:fWeather/components/card.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();

  int temperature;
  String weatherIcon;
  String cityName;
  String weatherMsg;

  @override
  void initState() {
    super.initState();
    updateUi(widget.locationWeather);
  }

  void updateUi(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMsg = 'Unable to fetch data';
        cityName = '';
        return;
      }

      cityName = weatherData['name'];
      double temp = weatherData['main']['temp'].toDouble();
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMsg = weather.getMessage(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('fWeather'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: RCard(
                    cardChild: Text(
                      '$temperature°',
                    ),
                  ),
                ),
                Expanded(
                  child: RCard(
                    cardChild: Text(
                      '$weatherIcon',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: RCard(
              cardChild: Text(
                '$weatherMsg in $cityName',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
