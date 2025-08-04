import 'package:flutter/material.dart';

class DiaryPage extends StatelessWidget {
  static const String id = 'DiaryPage';

  const DiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Diary',
          style: TextStyle(fontSize: 55.6, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
