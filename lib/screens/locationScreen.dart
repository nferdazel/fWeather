import 'package:flutter/material.dart';
import 'package:fWeather/components/card.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
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
                  child: RCard(),
                ),
                Expanded(
                  child: RCard(),
                ),
              ],
            ),
          ),
          Expanded(
            child: RCard(),
          ),
        ],
      ),
    );
  }
}
