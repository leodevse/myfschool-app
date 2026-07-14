import 'package:flutter/material.dart';

class TeacherAddNotificationScreen extends StatefulWidget {
  const TeacherAddNotificationScreen({super.key});

  @override
  State<TeacherAddNotificationScreen> createState() =>
      _TeacherAddNotificationScreenState();
}

class _TeacherAddNotificationScreenState
    extends State<TeacherAddNotificationScreen> {
  final TextEditingController titleController =
  TextEditingController();

  final TextEditingController contentController =
  TextEditingController();

  String selectedClass = "12A1";

  final List<String> classes = [
    "12A1",
    "12A2",
    "11A1",
    "10A3",
  ];

  void saveDraft() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Đã lưu nháp thông báo"),
      ),
    );

    Navigator.pop(context);
  }

  void sendNotification() {
    if (titleController.text.isEmpty ||
        contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Vui lòng nhập đầy đủ tiêu đề và nội dung"),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Đã gửi thông báo thành công"),
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("Thêm thông báo"),
        centerTitle: true,
        backgroundColor: const Color(0xff18324F),
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Thông tin thông báo",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Tiêu đề",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              value: selectedClass,
              decoration: const InputDecoration(
                labelText: "Chọn lớp",
                border: OutlineInputBorder(),
              ),
              items: classes.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedClass = value!;
                });
              },
            ),

            const SizedBox(height: 15),

            TextField(
              controller: contentController,
              maxLines: 8,
              decoration: const InputDecoration(
                labelText: "Nội dung thông báo",
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: saveDraft,
                    child: const Text("Lưu nháp"),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton(
                    onPressed: sendNotification,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                    ),
                    child: const Text(
                      "Gửi thông báo",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}