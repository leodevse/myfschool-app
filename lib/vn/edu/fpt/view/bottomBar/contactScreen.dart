import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  final List<Map<String, String>> contacts = const [
    {
      "name": "Cô Nguyễn Thị Hoa",
      "role": "Giáo viên chủ nhiệm",
      "phone": "0987654321",
      "email": "hoa.teacher@fpt.edu.vn",
    },
    {
      "name": "Thầy Trần Văn Nam",
      "role": "Giáo viên Toán",
      "phone": "0912345678",
      "email": "nam.math@fpt.edu.vn",
    },
    {
      "name": "Phòng đào tạo",
      "role": "Hỗ trợ học vụ",
      "phone": "0241234567",
      "email": "academic@fpt.edu.vn",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text("Danh bạ"),
        centerTitle: true,
        backgroundColor: const Color(0xFF18324F),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];

          return Card(
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: Text(
                contact["name"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "${contact["role"]}\n${contact["phone"]}\n${contact["email"]}",
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}