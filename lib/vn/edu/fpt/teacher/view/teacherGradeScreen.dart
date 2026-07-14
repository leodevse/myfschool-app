import 'package:flutter/material.dart';

class TeacherGradeScreen extends StatefulWidget {
  const TeacherGradeScreen({super.key});

  @override
  State<TeacherGradeScreen> createState() => _TeacherGradeScreenState();
}

class _TeacherGradeScreenState extends State<TeacherGradeScreen> {
  String selectedClass = "12A1";
  String selectedSubject = "Toán";
  String searchText = "";
  int currentPage = 1;
  static const int pageSize = 3;

  final List<String> classes = ["12A1", "12A2", "11A1", "10A3"];
  final List<String> subjects = ["Toán", "Ngữ văn", "Tiếng Anh", "Vật lý"];

  final List<Map<String, dynamic>> students = [
    {"name": "Nguyễn Xuân Long", "class": "12A1", "group": "Tổ 1"},
    {"name": "Nguyễn Minh", "class": "12A1", "group": "Tổ 2"},
    {"name": "Trần Hoàng Anh", "class": "12A1", "group": "Tổ 3"},
    {"name": "Lê Minh Khang", "class": "12A1", "group": "Tổ 4"},
    {"name": "Phạm Gia Hân", "class": "12A2", "group": "Tổ 1"},
    {"name": "Vũ Quốc Bảo", "class": "12A2", "group": "Tổ 2"},
    {"name": "Nguyễn Huy", "class": "11A1", "group": "Tổ 3"},
    {"name": "Đỗ Khánh Linh", "class": "11A1", "group": "Tổ 4"},
    {"name": "Bùi Anh Thư", "class": "10A3", "group": "Tổ 1"},
  ];

  List<Map<String, dynamic>> get filteredStudents {
    return students.where((student) {
      final matchesClass = student["class"] == selectedClass;
      final matchesSearch = student["name"].toString().toLowerCase().contains(
        searchText.toLowerCase(),
      );

      return matchesClass && matchesSearch;
    }).toList();
  }

  int get totalPages {
    final total = (filteredStudents.length / pageSize).ceil();
    return total == 0 ? 1 : total;
  }

  List<Map<String, dynamic>> get currentStudents {
    if (filteredStudents.isEmpty) {
      return [];
    }

    final start = (currentPage - 1) * pageSize;
    var end = start + pageSize;

    if (end > filteredStudents.length) {
      end = filteredStudents.length;
    }

    return filteredStudents.sublist(start, end);
  }

  void resetToFirstPage() {
    currentPage = 1;
  }

  Widget buildStudentTable() {
    if (currentStudents.isEmpty) {
      return const Center(
        child: Text(
          "Không có học sinh phù hợp",
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text("Tên học sinh")),
          DataColumn(label: Text("Nhóm")),
          DataColumn(label: Text("Action")),
        ],
        rows: currentStudents.map((student) {
          return DataRow(
            cells: [
              DataCell(Text(student["name"])),
              DataCell(Text(student["group"])),
              DataCell(
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TeacherEditGradeScreen(
                          studentName: student["name"],
                          className: selectedClass,
                          subjectName: selectedSubject,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget buildFilterRow() {
    final classDropdown = DropdownButtonFormField<String>(
      value: selectedClass,
      isExpanded: true,
      decoration: const InputDecoration(
        labelText: "Lớp",
        border: OutlineInputBorder(),
      ),
      items: classes.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item, overflow: TextOverflow.ellipsis),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedClass = value!;
          resetToFirstPage();
        });
      },
    );

    final subjectDropdown = DropdownButtonFormField<String>(
      value: selectedSubject,
      isExpanded: true,
      decoration: const InputDecoration(
        labelText: "Môn",
        border: OutlineInputBorder(),
      ),
      items: subjects.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item, overflow: TextOverflow.ellipsis),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedSubject = value!;
          resetToFirstPage();
        });
      },
    );

    final searchField = TextField(
      decoration: const InputDecoration(
        labelText: "Tìm kiếm học sinh",
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        setState(() {
          searchText = value;
          resetToFirstPage();
        });
      },
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 520) {
          return Column(
            children: [
              classDropdown,
              const SizedBox(height: 10),
              subjectDropdown,
              const SizedBox(height: 10),
              searchField,
            ],
          );
        }

        return Row(
          children: [
            Expanded(child: classDropdown),
            const SizedBox(width: 8),
            Expanded(child: subjectDropdown),
            const SizedBox(width: 8),
            Expanded(flex: 2, child: searchField),
          ],
        );
      },
    );
  }

  Widget buildPagination() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: currentPage > 1
                ? () {
                    setState(() {
                      currentPage--;
                    });
                  }
                : null,
            child: const Text("Trước"),
          ),
          const SizedBox(width: 20),
          Text(
            "$currentPage / $totalPages",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: currentPage < totalPages
                ? () {
                    setState(() {
                      currentPage++;
                    });
                  }
                : null,
            child: const Text("Sau"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Nhập điểm"),
        centerTitle: true,
        backgroundColor: const Color(0xFF18324F),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            buildFilterRow(),
            const SizedBox(height: 20),
            Expanded(child: buildStudentTable()),
            buildPagination(),
          ],
        ),
      ),
    );
  }
}

class TeacherEditGradeScreen extends StatefulWidget {
  final String studentName;
  final String className;
  final String subjectName;

  const TeacherEditGradeScreen({
    super.key,
    required this.studentName,
    required this.className,
    required this.subjectName,
  });

  @override
  State<TeacherEditGradeScreen> createState() => _TeacherEditGradeScreenState();
}

class _TeacherEditGradeScreenState extends State<TeacherEditGradeScreen> {
  final TextEditingController oral1Controller = TextEditingController();
  final TextEditingController oral2Controller = TextEditingController();
  final TextEditingController oral3Controller = TextEditingController();

  final TextEditingController test15_1Controller = TextEditingController();
  final TextEditingController test15_2Controller = TextEditingController();
  final TextEditingController test15_3Controller = TextEditingController();

  final TextEditingController test45_1Controller = TextEditingController();
  final TextEditingController test45_2Controller = TextEditingController();

  Widget buildScoreField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget buildScoreGroup(String title, List<Widget> fields) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 10,
          children: fields
              .map((field) => SizedBox(width: 100, child: field))
              .toList(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  void saveGrade() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Đã lưu điểm học sinh")));

    Navigator.pop(context);
  }

  @override
  void dispose() {
    oral1Controller.dispose();
    oral2Controller.dispose();
    oral3Controller.dispose();

    test15_1Controller.dispose();
    test15_2Controller.dispose();
    test15_3Controller.dispose();

    test45_1Controller.dispose();
    test45_2Controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Sửa điểm"),
        centerTitle: true,
        backgroundColor: const Color(0xFF18324F),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.studentName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Lớp: ${widget.className} - Môn: ${widget.subjectName}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 25),
            buildScoreGroup("Điểm miệng", [
              buildScoreField("Miệng 1", oral1Controller),
              buildScoreField("Miệng 2", oral2Controller),
              buildScoreField("Miệng 3", oral3Controller),
            ]),
            buildScoreGroup("Điểm 15 phút", [
              buildScoreField("15p 1", test15_1Controller),
              buildScoreField("15p 2", test15_2Controller),
              buildScoreField("15p 3", test15_3Controller),
            ]),
            buildScoreGroup("Điểm 45 phút", [
              buildScoreField("45p 1", test45_1Controller),
              buildScoreField("45p 2", test45_2Controller),
            ]),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: saveGrade,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                ),
                child: const Text(
                  "Lưu điểm",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
