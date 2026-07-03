import 'package:flutter/material.dart';
import 'messageDetailScreen.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  final List<Map<String, String>> messages = const [
    {
      "title": "Thông báo lịch học kỳ Spring 2026",
      "date": "04/01/2026",
      "author": "huongpt",
      "content":
      "Chào các em sinh viên, ngày mai là ngày bắt đầu học kỳ Spring 2026. Các em vui lòng kiểm tra lịch học chi tiết trên hệ thống.",
    },
    {
      "title": "Thông báo khẩn về lịch học chiều ngày 30/9/2025",
      "date": "30/09/2025",
      "author": "phòng đào tạo",
      "content":
      "Do tình hình thời tiết xấu, nhà trường thông báo các lớp học chiều nay chuyển sang học online.",
    },
  ];

  Widget buildMessageCard(BuildContext context, Map<String, String> message) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MessageDetailScreen(message: message),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: const Border(
            left: BorderSide(
              color: Colors.orange,
              width: 5,
            ),
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.orange.shade50,
              child: const Icon(
                Icons.notifications,
                color: Colors.orange,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message["title"]!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${message["date"]} · ${message["author"]}",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    message["content"]!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text("Messages"),
        centerTitle: true,
        backgroundColor: const Color(0xFF18324F),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return buildMessageCard(
                  context,
                  messages[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}