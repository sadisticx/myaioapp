import 'package:flutter/material.dart';
import 'newdiaryentry.dart';

class DiaryPage extends StatelessWidget {
  static const String id = 'DiaryPage';

  const DiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F7), // Light gray page background

      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F6F7), // same light gray
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              const Icon(Icons.search, color: Colors.black45),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search diary entries...',
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.only(bottom: 0),
                    hintStyle: TextStyle(color: Colors.black38),
                  ),
                  style: const TextStyle(color: Colors.black87),
                ),
              ),
              const Icon(Icons.filter_list, color: Colors.black45),
            ],
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: ListView(
          children: const [
            DiaryEntryCard(
              date: 'December 15, 2025',
              time: '8:30 PM',
              title: 'A Beautiful Day',
              description:
              'Today was one of those perfect days where everything seemed to fall into place. The morning started with a gentle breeze and the sound of birds chirping outside my window...',
            ),
            SizedBox(height: 12),
            DiaryEntryCard(
              date: 'December 14, 2025',
              time: '10:15 PM',
              title: 'Reflections on Growth',
              description:
              'I\'ve been thinking a lot about personal growth lately. It\'s fascinating how we change without even realizing it sometimes. Looking back at my entries from last year...',
            ),
            SizedBox(height: 12),
            DiaryEntryCard(
              date: 'December 13, 2025',
              time: '7:45 PM',
              title: 'Coffee Shop Chronicles',
              description:
              'Spent the afternoon at my favorite coffee shop downtown. There\'s something magical about the atmosphere there - the gentle hum of conversations, the aroma of freshly ground beans...',
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const NewDiaryEntryPage()),
          );
        },
        backgroundColor: Colors.black87,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class DiaryEntryCard extends StatelessWidget {
  final String date;
  final String time;
  final String title;
  final String description;

  const DiaryEntryCard({
    Key? key,
    required this.date,
    required this.time,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white, // white background for card
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2, // subtle shadow like in the screenshot
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                  ),
                ),
                Text(
                  time,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 15,
                height: 1.4,
                color: Colors.black87,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            const Text(
              'Read more',
              style: TextStyle(
                color: Color(0xFF666666), // dark gray #666
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}