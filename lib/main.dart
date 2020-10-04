import 'package:flutter/material.dart';
import 'package:fWeather/screens/LoadScreen.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home:LoadingScreen(),
    );
  }
}