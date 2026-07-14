import 'package:flutter/material.dart';

class TeacherInternalNotificationScreen extends StatelessWidget {
  const TeacherInternalNotificationScreen({super.key});

  final List<Map<String, String>> notices = const [
    {
      "title": "Họp chuyên môn tổ Toán",
      "sender": "Trưởng bộ môn",
      "date": "03/07/2026",
      "content": "Giáo viên tổ Toán họp chuyên môn lúc 14:00 tại phòng A201.",
    },
    {
      "title": "Thông báo lịch coi thi giữa kỳ",
      "sender": "Phòng đào tạo",
      "date": "05/07/2026",
      "content": "Giáo viên kiểm tra lịch coi thi trên hệ thống.",
    },
    {
      "title": "Cập nhật quy định nhập điểm",
      "sender": "Ban giám hiệu",
      "date": "08/07/2026",
      "content": "Giáo viên hoàn thành nhập điểm trước ngày 15/07/2026.",
    },
  ];

  Widget buildNoticeCard(Map<String, String> notice) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(
          Icons.notifications_active,
          color: Colors.deepOrange,
        ),
        title: Text(
          notice["title"]!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "Người gửi: ${notice["sender"]}\n"
              "Ngày: ${notice["date"]}\n"
              "${notice["content"]}",
        ),
        isThreeLine: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("Thông báo nhà trường"),
        centerTitle: true,
        backgroundColor: const Color(0xFF18324F),
        foregroundColor: Colors.white,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: notices.length,
        itemBuilder: (context, index) {
          return buildNoticeCard(notices[index]);
        },
      ),
    );
  }
}