import 'package:flutter/material.dart';

class DiaryDetailPage extends StatefulWidget {
  final Map<String, dynamic> note;
  final VoidCallback onDelete;
  final Function(Map<String, dynamic>) onUpdate;

  const DiaryDetailPage({
    super.key,
    required this.note,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  State<DiaryDetailPage> createState() => _DiaryDetailPageState();
}

class _DiaryDetailPageState extends State<DiaryDetailPage> {
  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note['title']);
    contentController = TextEditingController(text: widget.note['content']);
  }

  void _saveChanges() {
    final updatedNote = {
      ...widget.note,
      'title': titleController.text,
      'content': contentController.text,
    };
    widget.onUpdate(updatedNote);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final date = DateTime.parse(widget.note['date']);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F6F7),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: Text(
          "Diary Entry",
          style: const TextStyle(color: Colors.black87),
        ),
        actions: [
          IconButton(
            onPressed: _saveChanges,
            icon: const Icon(Icons.save, color: Colors.black87),
          ),
          IconButton(
            onPressed: () {
              widget.onDelete();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${date.month}/${date.day}/${date.year}",
              style: const TextStyle(color: Colors.black54, fontSize: 13),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: titleController,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Title",
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: TextField(
                controller: contentController,
                style: const TextStyle(fontSize: 15, color: Colors.black87, height: 1.5),
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Write your thoughts here...",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
