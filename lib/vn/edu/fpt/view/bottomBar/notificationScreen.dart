import 'package:flutter/material.dart';
import 'notificationDetailScreen.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  final List<Map<String, String>> notifications = const [
    {
      "title": "Thông báo điểm thi kết thúc học phần lần 2",
      "date": "03/07/2026",
      "author": "Phòng khảo thí",
      "content":
      "Phòng Khảo thí thông báo đã có điểm thi kết thúc học phần lần 2. Các em đăng nhập hệ thống để xem chi tiết điểm.",
    },
    {
      "title": "Thông báo về việc đảm bảo an ninh an toàn",
      "date": "02/07/2026",
      "author": "Ban giám hiệu",
      "content":
      "Nhà trường thông báo học sinh cần tuân thủ nội quy, đảm bảo an toàn trong thời gian học tập tại trường.",
    },
    {
      "title": "THÔNG BÁO NỘP HỌC PHÍ KỲ I",
      "date": "10/06/2026",
      "author": "Phòng tài chính",
      "content":
      "Phụ huynh vui lòng hoàn thành học phí kỳ I theo thời hạn nhà trường đã thông báo.",
    },
  ];

  Widget buildNotificationCard(
      BuildContext context,
      Map<String, String> item,
      ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => NotificationDetailScreen(notification: item),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: const Border(
            left: BorderSide(
              color: Colors.orange,
              width: 5,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 5,
            ),
          ],
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
                    item["title"]!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Date: ${item["date"]}",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
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
        title: const Text("Notification"),
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
                suffixIcon: Container(
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
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
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return buildNotificationCard(
                  context,
                  notifications[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}