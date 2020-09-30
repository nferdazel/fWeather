import 'package:flutter/material.dart';
import 'package:fWeather/screens/loadingScreen.dart';

void main() => runApp(FWeather());

class FWeather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: LoadingScreen(),
    );
  }
}
