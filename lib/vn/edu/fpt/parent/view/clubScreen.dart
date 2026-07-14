import 'package:flutter/material.dart';

class ClubScreen extends StatelessWidget {
  const ClubScreen({super.key});

  final List<Map<String, String>> clubs = const [
    {
      "name": "CLB Bóng đá",
      "teacher": "Thầy Nguyễn Văn A",
      "time": "Thứ 3, 16:30",
    },
    {
      "name": "CLB Tiếng Anh",
      "teacher": "Cô Trần Thị B",
      "time": "Thứ 5, 16:00",
    },
    {
      "name": "CLB Lập trình",
      "teacher": "Thầy Lê Văn C",
      "time": "Thứ 7, 08:00",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Câu lạc bộ"),
        backgroundColor: const Color(0xFF18324F),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: clubs.length,
        itemBuilder: (context, index) {
          final club = clubs[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 15),
            child: ListTile(
              leading: const Icon(Icons.groups),
              title: Text(
                club["name"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Phụ trách: ${club["teacher"]}\nThời gian: ${club["time"]}",
              ),
              trailing: ElevatedButton(
                onPressed: () {},
                child: const Text("Đăng ký"),
              ),
            ),
          );
        },
      ),
    );
  }
}