import 'package:flutter/material.dart';

class SchoolStaffStudentScreen extends StatefulWidget {
  const SchoolStaffStudentScreen({super.key});

  @override
  State<SchoolStaffStudentScreen> createState() => _StaffStudentScreenState();
}

class _StaffStudentScreenState extends State<SchoolStaffStudentScreen> {
  // Lớp đang được chọn để lọc
  String selectedClass = "Tất cả";

  // Nội dung tìm kiếm
  String searchText = "";

  // Danh sách lớp
  final List<String> classes = [
    "Tất cả",
    "10A1",
    "10A2",
    "11A1",
    "11A5",
    "12A1",
    "12A2",
  ];

  // Dữ liệu học sinh giả lập
  final List<Map<String, String>> students = [
    {
      "id": "HS001",
      "name": "Nguyễn Xuân Long",
      "class": "12A1",
      "gender": "Nam",
      "dateOfBirth": "12/05/2008",
      "parentName": "Nguyễn Văn Nam",
      "parentPhone": "0987654321",
    },
    {
      "id": "HS002",
      "name": "Nguyễn Minh",
      "class": "12A1",
      "gender": "Nam",
      "dateOfBirth": "20/08/2008",
      "parentName": "Nguyễn Thị Hoa",
      "parentPhone": "0912345678",
    },
    {
      "id": "HS003",
      "name": "Trần Ngọc Mai",
      "class": "11A5",
      "gender": "Nữ",
      "dateOfBirth": "15/02/2009",
      "parentName": "Trần Văn Hùng",
      "parentPhone": "0909123456",
    },
    {
      "id": "HS004",
      "name": "Lê Hoàng Huy",
      "class": "10A1",
      "gender": "Nam",
      "dateOfBirth": "08/11/2010",
      "parentName": "Lê Thị Lan",
      "parentPhone": "0978123456",
    },
  ];

  // Danh sách học sinh sau khi lọc và tìm kiếm
  List<Map<String, String>> get filteredStudents {
    return students.where((student) {
      final bool matchClass = selectedClass == "Tất cả" ||
          student["class"] == selectedClass;

      final String keyword = searchText.toLowerCase();

      final bool matchSearch =
          student["name"]!.toLowerCase().contains(keyword) ||
              student["id"]!.toLowerCase().contains(keyword);

      return matchClass && matchSearch;
    }).toList();
  }

  // Mở màn hình thêm học sinh
  Future<void> openAddStudentScreen() async {
    final Map<String, String>? newStudent =
    await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (context) => const StaffStudentFormScreen(),
      ),
    );

    if (newStudent != null) {
      setState(() {
        students.add(newStudent);
      });

      showMessage("Đã thêm học sinh thành công");
    }
  }

  // Mở màn hình sửa học sinh
  Future<void> openEditStudentScreen(
      Map<String, String> student,
      ) async {
    final int originalIndex = students.indexOf(student);

    final Map<String, String>? updatedStudent =
    await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (context) => StaffStudentFormScreen(
          student: Map<String, String>.from(student),
        ),
      ),
    );

    if (updatedStudent != null) {
      setState(() {
        students[originalIndex] = updatedStudent;
      });

      showMessage("Đã cập nhật học sinh");
    }
  }

  // Hiển thị hộp thoại xác nhận xóa
  void confirmDeleteStudent(
      Map<String, String> student,
      ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Xóa học sinh"),
          content: Text(
            "Bạn có chắc muốn xóa học sinh "
                "${student["name"]} không?",
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
                  students.remove(student);
                });

                Navigator.pop(dialogContext);

                showMessage("Đã xóa học sinh");
              },
              child: const Text(
                "Xóa",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  // Hiển thị thông báo phía dưới
  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // Một thẻ học sinh
  Widget buildStudentCard(
      Map<String, String> student,
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
              radius: 25,
              backgroundColor: Colors.blue.shade50,
              child: const Icon(
                Icons.person,
                color: Colors.blue,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student["name"]!,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "Mã học sinh: ${student["id"]}",
                  ),

                  const SizedBox(height: 3),

                  Text(
                    "Lớp: ${student["class"]}",
                  ),

                  const SizedBox(height: 3),

                  Text(
                    "Phụ huynh: ${student["parentName"]}",
                  ),
                ],
              ),
            ),

            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == "view") {
                  openStudentDetail(student);
                }

                if (value == "edit") {
                  openEditStudentScreen(student);
                }

                if (value == "delete") {
                  confirmDeleteStudent(student);
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

  // Xem chi tiết học sinh bằng BottomSheet
  void openStudentDetail(
      Map<String, String> student,
      ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (bottomSheetContext) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: SafeArea(
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
                  student["name"]!,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Divider(),

                buildDetailRow(
                  "Mã học sinh",
                  student["id"]!,
                ),

                buildDetailRow(
                  "Lớp",
                  student["class"]!,
                ),

                buildDetailRow(
                  "Giới tính",
                  student["gender"]!,
                ),

                buildDetailRow(
                  "Ngày sinh",
                  student["dateOfBirth"]!,
                ),

                buildDetailRow(
                  "Phụ huynh",
                  student["parentName"]!,
                ),

                buildDetailRow(
                  "Số điện thoại",
                  student["parentPhone"]!,
                ),

                const SizedBox(height: 15),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      appBar: AppBar(
        title: const Text("Quản lý học sinh"),
        centerTitle: true,
        backgroundColor: const Color(0xFF18324F),
        foregroundColor: Colors.white,

        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: "Thêm học sinh",
            onPressed: openAddStudentScreen,
          ),
        ],
      ),

      body: Column(
        children: [
          // Bộ lọc và tìm kiếm
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField<String>(
                    initialValue: selectedClass,
                    decoration: const InputDecoration(
                      labelText: "Lớp",
                      border: OutlineInputBorder(),
                    ),
                    items: classes.map((className) {
                      return DropdownMenuItem<String>(
                        value: className,
                        child: Text(
                          className,
                          overflow: TextOverflow.ellipsis,
                        ),
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
                ),

                const SizedBox(width: 10),

                Expanded(
                  flex: 2,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "Tìm tên hoặc mã học sinh",
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
                  "Danh sách học sinh",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${filteredStudents.length} học sinh",
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // Danh sách học sinh
          Expanded(
            child: filteredStudents.isEmpty
                ? const Center(
              child: Text(
                "Không tìm thấy học sinh",
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
              itemCount: filteredStudents.length,
              itemBuilder: (context, index) {
                return buildStudentCard(
                  filteredStudents[index],
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: openAddStudentScreen,
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Màn hình dùng chung cho thêm và sửa học sinh
class StaffStudentFormScreen extends StatefulWidget {
  final Map<String, String>? student;

  const StaffStudentFormScreen({
    super.key,
    this.student,
  });

  @override
  State<StaffStudentFormScreen> createState() =>
      _StaffStudentFormScreenState();
}

class _StaffStudentFormScreenState
    extends State<StaffStudentFormScreen> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateOfBirthController =
  TextEditingController();
  final TextEditingController parentNameController =
  TextEditingController();
  final TextEditingController parentPhoneController =
  TextEditingController();

  String selectedClass = "10A1";
  String selectedGender = "Nam";

  final List<String> classes = [
    "10A1",
    "10A2",
    "11A1",
    "11A5",
    "12A1",
    "12A2",
  ];

  final List<String> genders = [
    "Nam",
    "Nữ",
  ];

  bool get isEditing => widget.student != null;

  @override
  void initState() {
    super.initState();

    if (widget.student != null) {
      idController.text = widget.student!["id"]!;
      nameController.text = widget.student!["name"]!;
      dateOfBirthController.text =
      widget.student!["dateOfBirth"]!;
      parentNameController.text =
      widget.student!["parentName"]!;
      parentPhoneController.text =
      widget.student!["parentPhone"]!;

      selectedClass = widget.student!["class"]!;
      selectedGender = widget.student!["gender"]!;
    }
  }

  void saveStudent() {
    if (idController.text.trim().isEmpty ||
        nameController.text.trim().isEmpty ||
        parentNameController.text.trim().isEmpty ||
        parentPhoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Vui lòng nhập đầy đủ thông tin bắt buộc",
          ),
        ),
      );

      return;
    }

    final Map<String, String> student = {
      "id": idController.text.trim(),
      "name": nameController.text.trim(),
      "class": selectedClass,
      "gender": selectedGender,
      "dateOfBirth": dateOfBirthController.text.trim(),
      "parentName": parentNameController.text.trim(),
      "parentPhone": parentPhoneController.text.trim(),
    };

    Navigator.pop(
      context,
      student,
    );
  }

  Future<void> selectDate() async {
    final DateTime initialDate = DateTime(2009, 1, 1);

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      final String day =
      selectedDate.day.toString().padLeft(2, "0");
      final String month =
      selectedDate.month.toString().padLeft(2, "0");

      dateOfBirthController.text =
      "$day/$month/${selectedDate.year}";
    }
  }

  @override
  void dispose() {
    idController.dispose();
    nameController.dispose();
    dateOfBirthController.dispose();
    parentNameController.dispose();
    parentPhoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text(
          isEditing ? "Sửa học sinh" : "Thêm học sinh",
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
                labelText: "Mã học sinh *",
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

            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: selectedClass,
                    decoration: const InputDecoration(
                      labelText: "Lớp",
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
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: selectedGender,
                    decoration: const InputDecoration(
                      labelText: "Giới tính",
                      border: OutlineInputBorder(),
                    ),
                    items: genders.map((gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedGender = value;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            TextField(
              controller: dateOfBirthController,
              readOnly: true,
              onTap: selectDate,
              decoration: const InputDecoration(
                labelText: "Ngày sinh",
                prefixIcon: Icon(Icons.calendar_month),
                suffixIcon: Icon(Icons.arrow_drop_down),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: parentNameController,
              decoration: const InputDecoration(
                labelText: "Họ tên phụ huynh *",
                prefixIcon: Icon(Icons.family_restroom),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: parentPhoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Số điện thoại phụ huynh *",
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: saveStudent,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                ),
                child: Text(
                  isEditing ? "Lưu thay đổi" : "Thêm học sinh",
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