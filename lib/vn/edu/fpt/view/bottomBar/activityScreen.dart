import 'package:flutter/material.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  final List<Map<String, String>> activities = const [
    {
      "title": "Đăng nhập hệ thống",
      "time": "03/07/2026 08:30",
      "content": "Phụ huynh đã đăng nhập vào hệ thống",
    },
    {
      "title": "Xem bảng điểm",
      "time": "03/07/2026 08:35",
      "content": "Đã xem điểm học kỳ của học sinh Nguyễn Xuân Long",
    },
    {
      "title": "Gửi đơn xin nghỉ học",
      "time": "02/07/2026 21:00",
      "content": "Đơn xin nghỉ học đã được gửi tới giáo viên chủ nhiệm",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text("Hoạt động"),
        centerTitle: true,
        backgroundColor: const Color(0xFF18324F),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: activities.length,
        itemBuilder: (context, index) {
          final item = activities[index];

          return Card(
            child: ListTile(
              leading: const Icon(Icons.history),
              title: Text(
                item["title"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("${item["time"]}\n${item["content"]}"),
            ),
          );
        },
      ),
    );
  }
}