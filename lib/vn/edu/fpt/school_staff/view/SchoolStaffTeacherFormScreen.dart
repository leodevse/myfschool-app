import 'package:flutter/material.dart';

class StaffTeacherFormScreen extends StatefulWidget {
  final Map<String, String>? teacher;

  const StaffTeacherFormScreen({
    super.key,
    this.teacher,
  });

  @override
  State<StaffTeacherFormScreen> createState() =>
      _StaffTeacherFormScreenState();
}

class _StaffTeacherFormScreenState
    extends State<StaffTeacherFormScreen> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String selectedSubject = "Toán";
  String selectedRole = "Giáo viên bộ môn";
  String selectedClass = "Không chủ nhiệm";

  final List<String> subjects = [
    "Toán",
    "Ngữ văn",
    "Tiếng Anh",
    "Vật lý",
    "Hóa học",
    "Sinh học",
    "Lịch sử",
    "Địa lý",
    "Tin học",
  ];

  final List<String> roles = [
    "Giáo viên bộ môn",
    "Giáo viên chủ nhiệm",
    "Trưởng bộ môn",
  ];

  final List<String> classes = [
    "Không chủ nhiệm",
    "10A1",
    "10A2",
    "11A1",
    "11A2",
    "12A1",
    "12A2",
  ];

  bool get isEditing => widget.teacher != null;

  @override
  void initState() {
    super.initState();

    if (widget.teacher != null) {
      idController.text = widget.teacher!["id"]!;
      nameController.text = widget.teacher!["name"]!;
      emailController.text = widget.teacher!["email"]!;
      phoneController.text = widget.teacher!["phone"]!;

      selectedSubject = widget.teacher!["subject"]!;
      selectedRole = widget.teacher!["role"]!;

      final String currentClass = widget.teacher!["class"]!;

      selectedClass = currentClass.isEmpty
          ? "Không chủ nhiệm"
          : currentClass;
    }
  }

  void saveTeacher() {
    if (idController.text.trim().isEmpty ||
        nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Vui lòng nhập đầy đủ thông tin bắt buộc",
          ),
        ),
      );

      return;
    }

    if (!emailController.text.contains("@")) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Email không hợp lệ",
          ),
        ),
      );

      return;
    }

    if (selectedRole == "Giáo viên chủ nhiệm" &&
        selectedClass == "Không chủ nhiệm") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Vui lòng chọn lớp chủ nhiệm",
          ),
        ),
      );

      return;
    }

    final Map<String, String> teacher = {
      "id": idController.text.trim(),
      "name": nameController.text.trim(),
      "subject": selectedSubject,
      "phone": phoneController.text.trim(),
      "email": emailController.text.trim(),
      "role": selectedRole,
      "class": selectedRole == "Giáo viên chủ nhiệm" &&
          selectedClass != "Không chủ nhiệm"
          ? selectedClass
          : "",
    };

    Navigator.pop(
      context,
      teacher,
    );
  }

  @override
  void dispose() {
    idController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool showClassField =
        selectedRole == "Giáo viên chủ nhiệm";

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text(
          isEditing
              ? "Sửa giáo viên"
              : "Thêm giáo viên",
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
                labelText: "Mã giáo viên *",
                prefixIcon: Icon(Icons.badge),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Họ và tên *",
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              initialValue: selectedSubject,
              decoration: const InputDecoration(
                labelText: "Bộ môn",
                prefixIcon: Icon(Icons.menu_book),
                border: OutlineInputBorder(),
              ),
              items: subjects.map((subject) {
                return DropdownMenuItem<String>(
                  value: subject,
                  child: Text(subject),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedSubject = value;
                  });
                }
              },
            ),

            const SizedBox(height: 15),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email *",
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Số điện thoại *",
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              initialValue: selectedRole,
              decoration: const InputDecoration(
                labelText: "Vai trò",
                prefixIcon: Icon(Icons.work),
                border: OutlineInputBorder(),
              ),
              items: roles.map((role) {
                return DropdownMenuItem<String>(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedRole = value;

                    if (selectedRole != "Giáo viên chủ nhiệm") {
                      selectedClass = "Không chủ nhiệm";
                    }
                  });
                }
              },
            ),

            if (showClassField) ...[
              const SizedBox(height: 15),

              DropdownButtonFormField<String>(
                initialValue: selectedClass,
                decoration: const InputDecoration(
                  labelText: "Lớp chủ nhiệm",
                  prefixIcon: Icon(Icons.class_),
                  border: OutlineInputBorder(),
                ),
                items: classes.map((className) {
                  return DropdownMenuItem<String>(
                    value: className,
                    child: Text(className),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedClass = value;
                    });
                  }
                },
              ),
            ],

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: saveTeacher,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                ),
                child: Text(
                  isEditing
                      ? "Lưu thay đổi"
                      : "Thêm giáo viên",
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