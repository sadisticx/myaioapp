import 'package:flutter/material.dart';

class SpecialPage extends StatelessWidget {
  static const String id = 'RegisterPage';

  const SpecialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Special App',
          style: TextStyle(fontSize: 55.6, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
