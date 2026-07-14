import 'package:flutter/material.dart';
import 'SchoolStaffTeacherFormScreen.dart';

class StaffTeacherScreen extends StatefulWidget {
  const StaffTeacherScreen({super.key});

  @override
  State<StaffTeacherScreen> createState() => _StaffTeacherScreenState();
}

class _StaffTeacherScreenState extends State<StaffTeacherScreen> {
  String selectedSubject = "Tất cả";
  String searchText = "";

  final List<String> subjects = [
    "Tất cả",
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

  final List<Map<String, String>> teachers = [
    {
      "id": "GV001",
      "name": "Nguyễn Văn A",
      "subject": "Toán",
      "phone": "0987654321",
      "email": "vana@fpt.edu.vn",
      "role": "Giáo viên chủ nhiệm",
      "class": "12A1",
    },
    {
      "id": "GV002",
      "name": "Trần Văn B",
      "subject": "Vật lý",
      "phone": "0987654000",
      "email": "tranb@fpt.edu.vn",
      "role": "Giáo viên bộ môn",
      "class": "",
    },
    {
      "id": "GV003",
      "name": "Lê Thị C",
      "subject": "Ngữ văn",
      "phone": "0987000111",
      "email": "lethic@fpt.edu.vn",
      "role": "Trưởng bộ môn",
      "class": "",
    },
    {
      "id": "GV004",
      "name": "Phạm Minh D",
      "subject": "Tiếng Anh",
      "phone": "0977123456",
      "email": "phamminhd@fpt.edu.vn",
      "role": "Giáo viên chủ nhiệm",
      "class": "11A2",
    },
  ];

  List<Map<String, String>> get filteredTeachers {
    return teachers.where((teacher) {
      final bool matchSubject = selectedSubject == "Tất cả" ||
          teacher["subject"] == selectedSubject;

      final String keyword = searchText.toLowerCase();

      final bool matchSearch =
          teacher["name"]!.toLowerCase().contains(keyword) ||
              teacher["id"]!.toLowerCase().contains(keyword);

      return matchSubject && matchSearch;
    }).toList();
  }

  Future<void> openAddTeacherScreen() async {
    final Map<String, String>? newTeacher =
    await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (context) => const StaffTeacherFormScreen(),
      ),
    );

    if (newTeacher != null) {
      setState(() {
        teachers.add(newTeacher);
      });

      showMessage("Đã thêm giáo viên thành công");
    }
  }

  Future<void> openEditTeacherScreen(
      Map<String, String> teacher,
      ) async {
    final int originalIndex = teachers.indexOf(teacher);

    final Map<String, String>? updatedTeacher =
    await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (context) => StaffTeacherFormScreen(
          teacher: Map<String, String>.from(teacher),
        ),
      ),
    );

    if (updatedTeacher != null) {
      setState(() {
        teachers[originalIndex] = updatedTeacher;
      });

      showMessage("Đã cập nhật thông tin giáo viên");
    }
  }

  void confirmDeleteTeacher(
      Map<String, String> teacher,
      ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Xóa giáo viên"),
          content: Text(
            "Bạn có chắc muốn xóa giáo viên "
                "${teacher["name"]} không?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text("Hủy"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                setState(() {
                  teachers.remove(teacher);
                });

                Navigator.pop(dialogContext);

                showMessage("Đã xóa giáo viên");
              },
              child: const Text(
                "Xóa",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void openTeacherDetail(
      Map<String, String> teacher,
      ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (bottomSheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 45,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  teacher["name"]!,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Divider(),

                buildDetailRow(
                  "Mã giáo viên",
                  teacher["id"]!,
                ),

                buildDetailRow(
                  "Bộ môn",
                  teacher["subject"]!,
                ),

                buildDetailRow(
                  "Email",
                  teacher["email"]!,
                ),

                buildDetailRow(
                  "Điện thoại",
                  teacher["phone"]!,
                ),

                buildDetailRow(
                  "Vai trò",
                  teacher["role"]!,
                ),

                if (teacher["class"]!.isNotEmpty)
                  buildDetailRow(
                    "Chủ nhiệm lớp",
                    teacher["class"]!,
                  ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildDetailRow(
      String label,
      String value,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 7,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget buildTeacherCard(
      Map<String, String> teacher,
      ) {
    return Card(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.orange.shade50,
              child: const Icon(
                Icons.person,
                color: Colors.deepOrange,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    teacher["name"]!,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "Mã giáo viên: ${teacher["id"]}",
                  ),

                  const SizedBox(height: 3),

                  Text(
                    "Bộ môn: ${teacher["subject"]}",
                  ),

                  const SizedBox(height: 3),

                  Text(
                    "Vai trò: ${teacher["role"]}",
                  ),

                  if (teacher["class"]!.isNotEmpty) ...[
                    const SizedBox(height: 3),
                    Text(
                      "Chủ nhiệm: ${teacher["class"]}",
                    ),
                  ],
                ],
              ),
            ),

            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == "view") {
                  openTeacherDetail(teacher);
                }

                if (value == "edit") {
                  openEditTeacherScreen(teacher);
                }

                if (value == "delete") {
                  confirmDeleteTeacher(teacher);
                }
              },
              itemBuilder: (context) {
                return const [
                  PopupMenuItem(
                    value: "view",
                    child: Row(
                      children: [
                        Icon(Icons.visibility),
                        SizedBox(width: 10),
                        Text("Xem chi tiết"),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: "edit",
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 10),
                        Text("Sửa"),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: "delete",
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        SizedBox(width: 10),
                        Text("Xóa"),
                      ],
                    ),
                  ),
                ];
              },
            ),
          ],
        ),
      ),
    );
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      appBar: AppBar(
        title: const Text("Quản lý giáo viên"),
        centerTitle: true,
        backgroundColor: const Color(0xFF18324F),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: "Thêm giáo viên",
            onPressed: openAddTeacherScreen,
          ),
        ],
      ),

      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField<String>(
                    initialValue: selectedSubject,
                    decoration: const InputDecoration(
                      labelText: "Bộ môn",
                      border: OutlineInputBorder(),
                    ),
                    items: subjects.map((subject) {
                      return DropdownMenuItem<String>(
                        value: subject,
                        child: Text(
                          subject,
                          overflow: TextOverflow.ellipsis,
                        ),
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
                ),

                const SizedBox(width: 10),

                Expanded(
                  flex: 2,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "Tìm tên hoặc mã giáo viên",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchText = value.trim();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(
              15,
              15,
              15,
              10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Danh sách giáo viên",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${filteredTeachers.length} giáo viên",
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: filteredTeachers.isEmpty
                ? const Center(
              child: Text(
                "Không tìm thấy giáo viên",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              itemCount: filteredTeachers.length,
              itemBuilder: (context, index) {
                return buildTeacherCard(
                  filteredTeachers[index],
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: openAddTeacherScreen,
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}