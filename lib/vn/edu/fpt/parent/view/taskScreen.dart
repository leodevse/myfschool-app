import 'package:flutter/material.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  final List<Map<String, String>> tasks = const [
    {
      "subject": "Toán",
      "title": "Làm bài tập chương Hàm số",
      "deadline": "05/07/2026",
      "status": "Chưa nộp",
    },
    {
      "subject": "Ngữ văn",
      "title": "Soạn bài Tuyên ngôn độc lập",
      "deadline": "06/07/2026",
      "status": "Đã nộp",
    },
    {
      "subject": "Tiếng Anh",
      "title": "Làm worksheet Unit 3",
      "deadline": "07/07/2026",
      "status": "Chưa nộp",
    },
  ];

  Color getStatusColor(String status) {
    return status == "Đã nộp" ? Colors.green : Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nhiệm vụ, bài tập"),
        backgroundColor: const Color(0xFF18324F),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 15),
            child: ListTile(
              leading: const Icon(Icons.assignment),
              title: Text(
                task["title"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Môn: ${task["subject"]}\nHạn nộp: ${task["deadline"]}",
              ),
              trailing: Text(
                task["status"]!,
                style: TextStyle(
                  color: getStatusColor(task["status"]!),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}