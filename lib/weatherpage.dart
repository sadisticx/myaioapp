import 'package:flutter/material.dart';

class WeatherPage extends StatelessWidget {
  static const String id = 'RegisterPage';

  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Weather',
          style: TextStyle(fontSize: 55.6, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
