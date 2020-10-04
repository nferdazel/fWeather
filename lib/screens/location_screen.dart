import 'package:flutter/material.dart';
import 'package:fWeather/services/weather.dart';
import 'package:fWeather/screens/city_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();

  int temp;
  Icon weatherIcon;
  String displayText;
  int minTemp;
  int maxTemp;
  String subText;
  String cityName;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temp = 0;
        weatherIcon = Icon(Icons.error_outline);
        cityName = 'the app';
        return;
      }
      temp = weatherData['main']['temp'].toInt();

      minTemp = (weatherData['main']['minTemp']);
      maxTemp = (weatherData['main']['maxTemp']);

      displayText = weather.getMessage(temp);

      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      subText = weather.subText(condition);
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () async {
                        var weatherData = await weather.locationWeather();
                        updateUI(weatherData);
                      },
                      child: Icon(
                        Icons.gps_fixed,
                        size: 30,
                        color: Colors.blueAccent,
                      ),
                    ),
                    FlatButton(
                      onPressed: () async {
                        var typedName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CityScreen();
                            },
                          ),
                        );
                        if (typedName != null) {
                          var weatherData =
                              await weather.cityWeather(typedName);
                          updateUI(weatherData);
                        }
                      },
                      child: Icon(
                        FontAwesomeIcons.city,
                        size: 28.0,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(50, 50, 50, 0),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        child: Text(
                          cityName,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 35,
                          ),
                        ),
                      ),
                    ],
                  )),
              Expanded(
                flex: 9,
                child: Container(
                  margin: EdgeInsets.fromLTRB(50, 30, 50, 80),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            '$temp°',
                            style: TextStyle(
                              fontSize: 75,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            subText,
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 10, 50),
                        child: Container(
                          child: Text(
                            "$displayText in $cityName",
                            style: TextStyle(
                              fontSize: 21,
                              color: Colors.grey[500],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          child: Divider(
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 38),
                            //padding: const EdgeInsets.all(8.0),
                            child: weatherIcon,
                          )),
                          SizedBox(
                            width: 100,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 0, 38),
                              child: Text(
                                '$minTemp°-$maxTemp°',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF0C0C0C),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
