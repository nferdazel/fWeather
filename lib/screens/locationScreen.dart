import 'package:flutter/material.dart';
import 'package:fWeather/constants.dart';
import 'package:fWeather/components/card.dart';
import 'package:fWeather/services/weather.dart';

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
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(15.0),
                  child: TextField(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                    onChanged: (value) {
                      cityName = value;
                    },
                  ),
                ),
                FlatButton(
                  onPressed: () async {
                    if (cityName != null) {
                      var weatherData = await weather.getCityWeather(cityName);
                      updateUi(weatherData);
                    }
                  },
                  child: Text(
                    'Get Weather',
                    style: kReqularTextStyle,
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: RCard(
                      colour: kActiveCardColour,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$temperature°',
                            style: kNumberTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: RCard(
                      colour: kActiveCardColour,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$weatherIcon',
                            style: kNumberTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: RCard(
                colour: kActiveCardColour,
                cardChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '$weatherMsg in $cityName',
                      textAlign: TextAlign.center,
                      style: kResultTextStyle,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
