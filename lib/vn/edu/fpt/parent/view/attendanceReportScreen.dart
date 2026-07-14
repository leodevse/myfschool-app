import 'package:flutter/material.dart';

class AttendanceReportScreen extends StatelessWidget {
  const AttendanceReportScreen({super.key});

  final List<Map<String, String>> attendanceList = const [
    {
      "date": "01/07/2026",
      "status": "Có mặt",
      "note": "Đi học đúng giờ",
    },
    {
      "date": "02/07/2026",
      "status": "Vắng có phép",
      "note": "Gia đình có việc",
    },
    {
      "date": "03/07/2026",
      "status": "Đi muộn",
      "note": "Muộn 10 phút",
    },
  ];

  Color getColor(String status) {
    if (status == "Có mặt") return Colors.green;
    if (status == "Đi muộn") return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Báo cáo điểm danh"),
        backgroundColor: const Color(0xFF18324F),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: attendanceList.length,
        itemBuilder: (context, index) {
          final item = attendanceList[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 15),
            child: ListTile(
              leading: Icon(
                Icons.fact_check,
                color: getColor(item["status"]!),
              ),
              title: Text(
                item["date"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(item["note"]!),
              trailing: Text(
                item["status"]!,
                style: TextStyle(
                  color: getColor(item["status"]!),
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