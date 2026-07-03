import 'package:flutter/material.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  final List<Map<String, String>> events = const [
    {
      "title": "Lễ khai giảng năm học mới",
      "date": "05/09/2026",
      "place": "Sân trường",
    },
    {
      "title": "Hội thao học sinh THPT",
      "date": "20/10/2026",
      "place": "Nhà đa năng",
    },
    {
      "title": "Ngày hội câu lạc bộ",
      "date": "15/11/2026",
      "place": "Khu A",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sự kiện"),
        backgroundColor: const Color(0xFF18324F),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 15),
            child: ListTile(
              leading: const Icon(Icons.event),
              title: Text(
                event["title"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Ngày: ${event["date"]}\nĐịa điểm: ${event["place"]}",
              ),
            ),
          );
        },
      ),
    );
  }
}