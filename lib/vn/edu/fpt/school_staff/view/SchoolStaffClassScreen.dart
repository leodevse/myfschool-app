import 'package:flutter/material.dart';
import 'SchoolStaffClassFormScreen.dart';

class StaffClassScreen extends StatefulWidget {
  const StaffClassScreen({super.key});

  @override
  State<StaffClassScreen> createState() => _StaffClassScreenState();
}

class _StaffClassScreenState extends State<StaffClassScreen> {
  String selectedGrade = "Tất cả";
  String searchText = "";

  final List<String> grades = [
    "Tất cả",
    "Khối 10",
    "Khối 11",
    "Khối 12",
  ];

  final List<Map<String, dynamic>> classes = [
    {
      "id": "L001",
      "name": "10A1",
      "grade": "Khối 10",
      "teacher": "Nguyễn Văn A",
      "studentCount": 40,
      "room": "A101",
      "schoolYear": "2026-2027",
    },
    {
      "id": "L002",
      "name": "11A1",
      "grade": "Khối 11",
      "teacher": "Trần Thị B",
      "studentCount": 39,
      "room": "B201",
      "schoolYear": "2026-2027",
    },
    {
      "id": "L003",
      "name": "11A5",
      "grade": "Khối 11",
      "teacher": "Lê Văn C",
      "studentCount": 41,
      "room": "B205",
      "schoolYear": "2026-2027",
    },
    {
      "id": "L004",
      "name": "12A1",
      "grade": "Khối 12",
      "teacher": "Phạm Thị D",
      "studentCount": 42,
      "room": "C301",
      "schoolYear": "2026-2027",
    },
  ];

  List<Map<String, dynamic>> get filteredClasses {
    return classes.where((classItem) {
      final bool matchGrade =
          selectedGrade == "Tất cả" ||
              classItem["grade"] == selectedGrade;

      final String keyword = searchText.toLowerCase();

      final bool matchSearch =
          classItem["name"]
              .toString()
              .toLowerCase()
              .contains(keyword) ||
              classItem["teacher"]
                  .toString()
                  .toLowerCase()
                  .contains(keyword);

      return matchGrade && matchSearch;
    }).toList();
  }

  Future<void> openAddClassScreen() async {
    final Map<String, dynamic>? newClass =
    await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => const StaffClassFormScreen(),
      ),
    );

    if (newClass != null) {
      setState(() {
        classes.add(newClass);
      });

      showMessage("Đã thêm lớp học");
    }
  }

  Future<void> openEditClassScreen(
      Map<String, dynamic> classItem,
      ) async {
    final int originalIndex = classes.indexOf(classItem);

    final Map<String, dynamic>? updatedClass =
    await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => StaffClassFormScreen(
          classItem: Map<String, dynamic>.from(classItem),
        ),
      ),
    );

    if (updatedClass != null) {
      setState(() {
        classes[originalIndex] = updatedClass;
      });

      showMessage("Đã cập nhật lớp học");
    }
  }

  void confirmDeleteClass(
      Map<String, dynamic> classItem,
      ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Xóa lớp học"),
          content: Text(
            "Bạn có chắc muốn xóa lớp "
                "${classItem["name"]} không?",
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
                  classes.remove(classItem);
                });

                Navigator.pop(dialogContext);

                showMessage("Đã xóa lớp học");
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

  void openClassDetail(
      Map<String, dynamic> classItem,
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
                  "Lớp ${classItem["name"]}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Divider(),

                buildDetailRow(
                  "Mã lớp",
                  classItem["id"].toString(),
                ),

                buildDetailRow(
                  "Khối",
                  classItem["grade"].toString(),
                ),

                buildDetailRow(
                  "Giáo viên CN",
                  classItem["teacher"].toString(),
                ),

                buildDetailRow(
                  "Sĩ số",
                  "${classItem["studentCount"]} học sinh",
                ),

                buildDetailRow(
                  "Phòng học",
                  classItem["room"].toString(),
                ),

                buildDetailRow(
                  "Năm học",
                  classItem["schoolYear"].toString(),
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
            width: 125,
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

  Widget buildClassCard(
      Map<String, dynamic> classItem,
      ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),

      child: Padding(
        padding: const EdgeInsets.all(12),

        child: Row(
          children: [
            CircleAvatar(
              radius: 27,
              backgroundColor: Colors.blue.shade50,
              child: const Icon(
                Icons.class_,
                color: Colors.blue,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    classItem["name"].toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    classItem["grade"].toString(),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    "GVCN: ${classItem["teacher"]}",
                  ),

                  const SizedBox(height: 3),

                  Text(
                    "Sĩ số: ${classItem["studentCount"]}",
                  ),

                  const SizedBox(height: 3),

                  Text(
                    "Phòng: ${classItem["room"]}",
                  ),
                ],
              ),
            ),

            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == "view") {
                  openClassDetail(classItem);
                }

                if (value == "edit") {
                  openEditClassScreen(classItem);
                }

                if (value == "delete") {
                  confirmDeleteClass(classItem);
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
        title: const Text("Quản lý lớp học"),
        centerTitle: true,
        backgroundColor: const Color(0xFF18324F),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: openAddClassScreen,
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
                    initialValue: selectedGrade,
                    decoration: const InputDecoration(
                      labelText: "Khối",
                      border: OutlineInputBorder(),
                    ),
                    items: grades.map((grade) {
                      return DropdownMenuItem<String>(
                        value: grade,
                        child: Text(
                          grade,
                          overflow: TextOverflow.ellipsis,
                        ),
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
                ),

                const SizedBox(width: 10),

                Expanded(
                  flex: 2,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText:
                      "Tìm tên lớp hoặc giáo viên",
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
                  "Danh sách lớp học",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  "${filteredClasses.length} lớp",
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: filteredClasses.isEmpty
                ? const Center(
              child: Text(
                "Không tìm thấy lớp học",
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
              itemCount: filteredClasses.length,
              itemBuilder: (context, index) {
                return buildClassCard(
                  filteredClasses[index],
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: openAddClassScreen,
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}