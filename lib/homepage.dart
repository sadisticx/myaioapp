import 'package:flutter/material.dart';
import 'diaryhomepage.dart';
import 'weatherpage.dart';
import 'specialpage.dart';

class HomePage extends StatefulWidget {
  static const String id = 'HomePage';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    const DiaryPage(),
    const WeatherPage(),
    const SpecialPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Go Back')),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Diary'),
          BottomNavigationBarItem(icon: Icon(Icons.cloud), label: 'Weather'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'SF'),
        ],
      ),
    );
  }
}
