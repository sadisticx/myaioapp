import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherPage extends StatefulWidget {
  static const String id = 'WeatherPage';
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Map<String, dynamic>? weatherData;
  Map<String, dynamic>? forecastData;

  final String apiKey = 'bb8e29e84fa3b497626c186e9840222d'; // <-- replace with your OpenWeather API key
  final String city = 'Capas,PH';

  @override
  void initState() {
    super.initState();
    loadWeather();
  }

  Future<void> loadWeather() async {
    try {
      // Current weather
      final currentUrl = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric');
      final currentRes = await http.get(currentUrl);
      final currentJson = json.decode(currentRes.body);

      // 5-day / 3-hour forecast
      final forecastUrl = Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric');
      final forecastRes = await http.get(forecastUrl);
      final forecastJson = json.decode(forecastRes.body);

      if (!mounted) return;

      setState(() {
        weatherData = currentJson;
        forecastData = forecastJson;
      });
    } catch (e) {
      debugPrint("Error fetching weather: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF0F4),
      body: weatherData == null || forecastData == null
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: loadWeather, // <-- pull-to-refresh
        child: buildWeatherUI(),
      ),
    );
  }

  Widget buildWeatherUI() {
    final cityName = weatherData?['name'] ?? 'Unknown';
    final currentTemp = weatherData?['main']?['temp']?.round().toString() ?? "--";
    final desc = weatherData?['weather']?[0]?['description'] ?? "";

    // Forecast list (40 entries, every 3 hours)
    final forecastList = forecastData?['list'] ?? [];

    if (forecastList.isEmpty) {
      return const Center(
        child: Text("Weather data not available", style: TextStyle(fontSize: 16)),
      );
    }

    return SafeArea(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(), // required for pull-to-refresh
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Current weather card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(cityName,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(
                      "$currentTemp°",
                      style: const TextStyle(
                          fontSize: 60, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.cloud, color: Colors.teal, size: 28),
                        const SizedBox(width: 8),
                        Text(desc,
                            style: const TextStyle(
                              fontSize: 16,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Today (next 5 forecasts, ~15 hours)
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Today",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(5, (i) {
                        if (i >= forecastList.length) {
                          return const SizedBox();
                        }
                        final hourData = forecastList[i];
                        final dt = DateTime.fromMillisecondsSinceEpoch(
                            hourData['dt'] * 1000);
                        final hour =
                            "${dt.hour > 12 ? dt.hour - 12 : dt.hour == 0 ? 12 : dt.hour} ${dt.hour >= 12 ? 'PM' : 'AM'}";
                        final temp = "${hourData['main']['temp'].round()}°";
                        return _TodayWeather(
                          time: hour,
                          temp: temp,
                          icon: Icons.wb_sunny, // TODO: map weather icon
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 5-Day Forecast (pick one forecast per day at noon)
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "5-Day Forecast",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Column(
                      children: List.generate(5, (i) {
                        final index = i * 8; // every 24h (8 * 3h = 24h)
                        if (index >= forecastList.length) {
                          return const SizedBox();
                        }
                        final dayData = forecastList[index];
                        final dt = DateTime.fromMillisecondsSinceEpoch(
                            dayData['dt'] * 1000);
                        final dayName =
                        ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
                        [dt.weekday % 7];
                        final min = dayData['main']['temp_min'].round();
                        final max = dayData['main']['temp_max'].round();
                        return _ForecastRow(
                          day: dayName,
                          icon: Icons.wb_sunny, // TODO: map weather icon
                          temp: "$min° / $max°",
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Swim message
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.pool, color: Colors.teal),
                    SizedBox(width: 8),
                    Text(
                      "Perfect time to swim!",
                      style: TextStyle(fontSize: 16),
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

// Custom widget for Today weather small boxes
class _TodayWeather extends StatelessWidget {
  final String time;
  final String temp;
  final IconData icon;

  const _TodayWeather({
    required this.time,
    required this.temp,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(time, style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 4),
        Icon(icon, color: Colors.orange, size: 24),
        const SizedBox(height: 4),
        Text(temp, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}

// Custom widget for forecast rows
class _ForecastRow extends StatelessWidget {
  final String day;
  final IconData icon;
  final String temp;

  const _ForecastRow({
    required this.day,
    required this.icon,
    required this.temp,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(day, style: const TextStyle(fontSize: 14)),
          Row(
            children: [
              Icon(icon, color: Colors.orange, size: 20),
              const SizedBox(width: 12),
              Text(temp, style: const TextStyle(fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }
}
