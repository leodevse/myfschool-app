import 'package:flutter/material.dart';

class StaffClassFormScreen extends StatefulWidget {
  final Map<String, dynamic>? classItem;

  const StaffClassFormScreen({
    super.key,
    this.classItem,
  });

  @override
  State<StaffClassFormScreen> createState() =>
      _StaffClassFormScreenState();
}

class _StaffClassFormScreenState
    extends State<StaffClassFormScreen> {
  final TextEditingController idController =
  TextEditingController();

  final TextEditingController nameController =
  TextEditingController();

  final TextEditingController roomController =
  TextEditingController();

  final TextEditingController studentCountController =
  TextEditingController();

  String selectedGrade = "Khối 10";
  String selectedTeacher = "Nguyễn Văn A";
  String selectedSchoolYear = "2026-2027";

  final List<String> grades = [
    "Khối 10",
    "Khối 11",
    "Khối 12",
  ];

  final List<String> teachers = [
    "Nguyễn Văn A",
    "Trần Thị B",
    "Lê Văn C",
    "Phạm Thị D",
  ];

  final List<String> schoolYears = [
    "2025-2026",
    "2026-2027",
    "2027-2028",
  ];

  bool get isEditing => widget.classItem != null;

  @override
  void initState() {
    super.initState();

    if (widget.classItem != null) {
      idController.text =
          widget.classItem!["id"].toString();

      nameController.text =
          widget.classItem!["name"].toString();

      roomController.text =
          widget.classItem!["room"].toString();

      studentCountController.text =
          widget.classItem!["studentCount"].toString();

      selectedGrade =
          widget.classItem!["grade"].toString();

      selectedTeacher =
          widget.classItem!["teacher"].toString();

      selectedSchoolYear =
          widget.classItem!["schoolYear"].toString();
    }
  }

  void saveClass() {
    if (idController.text.trim().isEmpty ||
        nameController.text.trim().isEmpty ||
        roomController.text.trim().isEmpty ||
        studentCountController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Vui lòng nhập đầy đủ thông tin",
          ),
        ),
      );

      return;
    }

    final int? studentCount =
    int.tryParse(studentCountController.text.trim());

    if (studentCount == null || studentCount < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Sĩ số phải là số hợp lệ",
          ),
        ),
      );

      return;
    }

    final Map<String, dynamic> classItem = {
      "id": idController.text.trim(),
      "name": nameController.text.trim(),
      "grade": selectedGrade,
      "teacher": selectedTeacher,
      "studentCount": studentCount,
      "room": roomController.text.trim(),
      "schoolYear": selectedSchoolYear,
    };

    Navigator.pop(
      context,
      classItem,
    );
  }

  @override
  void dispose() {
    idController.dispose();
    nameController.dispose();
    roomController.dispose();
    studentCountController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text(
          isEditing
              ? "Sửa lớp học"
              : "Thêm lớp học",
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF18324F),
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),

        child: Column(
          children: [
            TextField(
              controller: idController,
              enabled: !isEditing,
              decoration: const InputDecoration(
                labelText: "Mã lớp *",
                prefixIcon: Icon(Icons.badge),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Tên lớp *",
                prefixIcon: Icon(Icons.class_),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              initialValue: selectedGrade,
              decoration: const InputDecoration(
                labelText: "Khối",
                prefixIcon: Icon(Icons.school),
                border: OutlineInputBorder(),
              ),
              items: grades.map((grade) {
                return DropdownMenuItem<String>(
                  value: grade,
                  child: Text(grade),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedGrade = value;
                  });
                }
              },
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              initialValue: selectedTeacher,
              decoration: const InputDecoration(
                labelText: "Giáo viên chủ nhiệm",
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              items: teachers.map((teacher) {
                return DropdownMenuItem<String>(
                  value: teacher,
                  child: Text(teacher),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedTeacher = value;
                  });
                }
              },
            ),

            const SizedBox(height: 15),

            TextField(
              controller: roomController,
              decoration: const InputDecoration(
                labelText: "Phòng học *",
                prefixIcon: Icon(Icons.meeting_room),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: studentCountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Sĩ số *",
                prefixIcon: Icon(Icons.people),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              initialValue: selectedSchoolYear,
              decoration: const InputDecoration(
                labelText: "Năm học",
                prefixIcon: Icon(Icons.calendar_month),
                border: OutlineInputBorder(),
              ),
              items: schoolYears.map((year) {
                return DropdownMenuItem<String>(
                  value: year,
                  child: Text(year),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedSchoolYear = value;
                  });
                }
              },
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: saveClass,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                ),
                child: Text(
                  isEditing
                      ? "Lưu thay đổi"
                      : "Thêm lớp học",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
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