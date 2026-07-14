import 'package:flutter/material.dart';

class TeacherAssignmentScreen extends StatefulWidget {
  const TeacherAssignmentScreen({super.key});

  @override
  State<TeacherAssignmentScreen> createState() =>
      _TeacherAssignmentScreenState();
}

class _TeacherAssignmentScreenState
    extends State<TeacherAssignmentScreen> {
  final List<Map<String, String>> assignments = [
    {
      "title": "Bài tập chương Hàm số",
      "subject": "Toán",
      "class": "12A1",
      "deadline": "05/07/2026",
      "status": "Đã giao",
    },
    {
      "title": "Ôn tập kiểm tra 45 phút",
      "subject": "Toán",
      "class": "11A2",
      "deadline": "08/07/2026",
      "status": "Nháp",
    },
  ];

  Color getStatusColor(String status) {
    if (status == "Đã giao") {
      return Colors.green;
    }
    return Colors.orange;
  }

  void openAddAssignmentScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddAssignmentScreen(
          onAdd: (newAssignment) {
            setState(() {
              assignments.add(newAssignment);
            });
          },
        ),
      ),
    );
  }

  Widget buildAssignmentCard(Map<String, String> item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: const Icon(Icons.assignment),
        title: Text(
          item["title"]!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "Môn: ${item["subject"]}\n"
              "Lớp: ${item["class"]}\n"
              "Hạn nộp: ${item["deadline"]}",
        ),
        trailing: Text(
          item["status"]!,
          style: TextStyle(
            color: getStatusColor(item["status"]!),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFF18324F),
        foregroundColor: Colors.white,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          "Giao bài tập",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,

        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: openAddAssignmentScreen,
          ),
        ],
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: assignments.length,
        itemBuilder: (context, index) {
          return buildAssignmentCard(
            assignments[index],
          );
        },
      ),
    );
  }
}

class AddAssignmentScreen extends StatefulWidget {
  final Function(Map<String, String>) onAdd;

  const AddAssignmentScreen({
    super.key,
    required this.onAdd,
  });

  @override
  State<AddAssignmentScreen> createState() =>
      _AddAssignmentScreenState();
}

class _AddAssignmentScreenState
    extends State<AddAssignmentScreen> {
  final TextEditingController titleController =
  TextEditingController();

  final TextEditingController deadlineController =
  TextEditingController();

  String selectedClass = "12A1";
  String selectedSubject = "Toán";
  String selectedStatus = "Nháp";

  final List<String> classes = [
    "12A1",
    "12A2",
    "11A1",
    "10A3",
  ];

  final List<String> subjects = [
    "Toán",
    "Ngữ văn",
    "Tiếng Anh",
    "Vật lý",
    "Hóa học",
  ];

  final List<String> statuses = [
    "Nháp",
    "Đã giao",
  ];

  void saveAssignment() {
    if (titleController.text.isEmpty ||
        deadlineController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Vui lòng nhập đầy đủ thông tin"),
        ),
      );
      return;
    }

    Map<String, String> newAssignment = {
      "title": titleController.text,
      "subject": selectedSubject,
      "class": selectedClass,
      "deadline": deadlineController.text,
      "status": selectedStatus,
    };

    widget.onAdd(newAssignment);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFF18324F),
        foregroundColor: Colors.white,
        title: const Text("Thêm bài tập"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),

        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Tiêu đề bài tập",
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

            DropdownButtonFormField<String>(
              value: selectedSubject,
              decoration: const InputDecoration(
                labelText: "Chọn môn",
                border: OutlineInputBorder(),
              ),
              items: subjects.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedSubject = value!;
                });
              },
            ),

            const SizedBox(height: 15),

            TextField(
              controller: deadlineController,
              decoration: const InputDecoration(
                labelText: "Hạn nộp, ví dụ: 05/07/2026",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              value: selectedStatus,
              decoration: const InputDecoration(
                labelText: "Trạng thái",
                border: OutlineInputBorder(),
              ),
              items: statuses.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedStatus = value!;
                });
              },
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: saveAssignment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                ),
                child: const Text(
                  "Lưu bài tập",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}