import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SpecialPage extends StatefulWidget {
  static const String id = 'SpecialPage';

  const SpecialPage({super.key});

  @override
  State<SpecialPage> createState() => _SpecialPageState();
}

class _SpecialPageState extends State<SpecialPage> {
  List<dynamic> events = [];
  Map<int, String> expandedSummaries = {}; // store summaries by index
  bool loading = true;
  int? expandedIndex; // track which card is expanded

  @override
  void initState() {
    super.initState();
    fetchOnThisDay();
  }

  Future<void> fetchOnThisDay() async {
    try {
      final today = DateTime.now();
      final url = Uri.parse(
          'https://en.wikipedia.org/api/rest_v1/feed/onthisday/events/${today.month}/${today.day}'
      );

      final res = await http.get(url);

      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        setState(() {
          events = data['events'] ?? [];
          loading = false;
        });
      } else {
        debugPrint("Wikipedia API error: ${res.statusCode}");
        debugPrint("Response body: ${res.body}");
        setState(() => loading = false);
      }
    } catch (e) {
      debugPrint("Error: $e");
      setState(() => loading = false);
    }
  }


  Future<void> fetchSummary(int index, String title) async {
    try {
      final url = Uri.parse(
          'https://en.wikipedia.org/api/rest_v1/page/summary/${Uri.encodeComponent(title)}');
      final res = await http.get(url);

      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        setState(() {
          expandedSummaries[index] = data['extract'] ?? 'No details available';
          expandedIndex = index; // expand this one
        });
      }
    } catch (e) {
      debugPrint("Error fetching summary: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final dateStr =
        "${_monthName(today.month)} ${today.day}, ${today.year}";

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F7),
      body: SafeArea(
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "On This Day in History",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text(dateStr,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.grey)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Events list
              ...events.take(5).toList().asMap().entries.map((entry) {
                final i = entry.key;
                final event = entry.value;

                final year = event['year'] ?? '';
                final text = event['text'] ?? '';
                final title = text.split(".").first;
                final desc = text;
                final pages = event['pages'] as List<dynamic>?;
                final thumb = (pages != null && pages.isNotEmpty)
                    ? (pages.first['thumbnail'] != null
                    ? pages.first['thumbnail']['source']
                    : null)
                    : null;
                final wikiTitle =
                (pages != null && pages.isNotEmpty)
                    ? pages.first['title']
                    : null;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        if (expandedIndex == i) {
                          // collapse if tapped again
                          expandedIndex = null;
                        } else {
                          // expand and fetch summary
                          if (wikiTitle != null) {
                            fetchSummary(i, wikiTitle);
                          }
                        }
                      });
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Year + title
                            Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 4,
                                  height: 40,
                                  margin:
                                  const EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.teal,
                                    borderRadius:
                                    BorderRadius.circular(4),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        year.toString(),
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.teal),
                                      ),
                                      Text(
                                        title,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(desc,
                                style:
                                const TextStyle(fontSize: 14)),
                            const SizedBox(height: 8),
                            if (thumb != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(thumb),
                              ),

                            // Expanded details
                            if (expandedIndex == i &&
                                expandedSummaries.containsKey(i)) ...[
                              const SizedBox(height: 12),
                              Text(
                                expandedSummaries[i]!,
                                style:
                                const TextStyle(fontSize: 14),
                              ),
                            ]
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  String _monthName(int m) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return months[m - 1];
  }
}
