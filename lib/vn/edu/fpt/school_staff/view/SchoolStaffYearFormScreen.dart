import 'package:flutter/material.dart';

import '../model/schoolYear.dart';



class StaffSchoolYearFormScreen
    extends StatefulWidget {
  final SchoolYear? schoolYear;

  const StaffSchoolYearFormScreen({
    super.key,
    this.schoolYear,
  });

  @override
  State<StaffSchoolYearFormScreen> createState() =>
      _StaffSchoolYearFormScreenState();
}

class _StaffSchoolYearFormScreenState
    extends State<StaffSchoolYearFormScreen> {
  final TextEditingController nameController =
  TextEditingController();

  DateTime semester1Start = DateTime(2026, 9, 5);
  DateTime semester1End = DateTime(2027, 1, 15);

  DateTime semester2Start = DateTime(2027, 1, 20);
  DateTime semester2End = DateTime(2027, 5, 25);

  bool semester1GradeOpen = false;
  bool semester2GradeOpen = false;

  bool get isEditing => widget.schoolYear != null;

  @override
  void initState() {
    super.initState();

    if (widget.schoolYear != null) {
      final SchoolYear item = widget.schoolYear!;

      nameController.text = item.name;

      semester1Start = item.semesters[0].startDate;
      semester1End = item.semesters[0].endDate;
      semester1GradeOpen =
          item.semesters[0].gradeEntryOpen;

      semester2Start = item.semesters[1].startDate;
      semester2End = item.semesters[1].endDate;
      semester2GradeOpen =
          item.semesters[1].gradeEntryOpen;
    }
  }

  String formatDate(DateTime date) {
    final String day =
    date.day.toString().padLeft(2, "0");

    final String month =
    date.month.toString().padLeft(2, "0");

    return "$day/$month/${date.year}";
  }

  Future<DateTime?> selectDate(
      DateTime initialDate,
      ) {
    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2040),
    );
  }

  Widget buildDateField({
    required String label,
    required DateTime date,
    required Function(DateTime) onSelected,
  }) {
    return InkWell(
      onTap: () async {
        final DateTime? selectedDate =
        await selectDate(date);

        if (selectedDate != null) {
          onSelected(selectedDate);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon:
          const Icon(Icons.calendar_month),
        ),
        child: Text(formatDate(date)),
      ),
    );
  }

  Widget buildSemesterSection({
    required String title,
    required DateTime startDate,
    required DateTime endDate,
    required bool gradeEntryOpen,
    required Function(DateTime) onStartChanged,
    required Function(DateTime) onEndChanged,
    required Function(bool) onGradeOpenChanged,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 18),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            buildDateField(
              label: "Ngày bắt đầu",
              date: startDate,
              onSelected: onStartChanged,
            ),

            const SizedBox(height: 15),

            buildDateField(
              label: "Ngày kết thúc",
              date: endDate,
              onSelected: onEndChanged,
            ),

            const SizedBox(height: 5),

            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text("Cho phép nhập điểm"),
              subtitle: Text(
                gradeEntryOpen
                    ? "Giáo viên được phép nhập điểm"
                    : "Đang khóa chức năng nhập điểm",
              ),
              value: gradeEntryOpen,
              onChanged: onGradeOpenChanged,
            ),
          ],
        ),
      ),
    );
  }

  void saveSchoolYear() {
    final String name = nameController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Vui lòng nhập tên năm học"),
        ),
      );
      return;
    }

    if (semester1Start.isAfter(semester1End) ||
        semester2Start.isAfter(semester2End)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Ngày bắt đầu phải trước ngày kết thúc",
          ),
        ),
      );
      return;
    }

    final SchoolYear schoolYear = SchoolYear(
      id: widget.schoolYear?.id ??
          "NH${DateTime.now().millisecondsSinceEpoch}",
      name: name,
      active: widget.schoolYear?.active ?? false,
      semesters: [
        Semester(
          semesterNumber: 1,
          startDate: semester1Start,
          endDate: semester1End,
          gradeEntryOpen: semester1GradeOpen,
        ),
        Semester(
          semesterNumber: 2,
          startDate: semester2Start,
          endDate: semester2End,
          gradeEntryOpen: semester2GradeOpen,
        ),
      ],
    );

    Navigator.pop(context, schoolYear);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      appBar: AppBar(
        title: Text(
          isEditing
              ? "Sửa năm học"
              : "Thêm năm học",
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
              controller: nameController,
              decoration: const InputDecoration(
                labelText:
                "Tên năm học, ví dụ 2026-2027",
                prefixIcon:
                Icon(Icons.calendar_month),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            buildSemesterSection(
              title: "Học kỳ I",
              startDate: semester1Start,
              endDate: semester1End,
              gradeEntryOpen: semester1GradeOpen,
              onStartChanged: (value) {
                setState(() {
                  semester1Start = value;
                });
              },
              onEndChanged: (value) {
                setState(() {
                  semester1End = value;
                });
              },
              onGradeOpenChanged: (value) {
                setState(() {
                  semester1GradeOpen = value;
                });
              },
            ),

            buildSemesterSection(
              title: "Học kỳ II",
              startDate: semester2Start,
              endDate: semester2End,
              gradeEntryOpen: semester2GradeOpen,
              onStartChanged: (value) {
                setState(() {
                  semester2Start = value;
                });
              },
              onEndChanged: (value) {
                setState(() {
                  semester2End = value;
                });
              },
              onGradeOpenChanged: (value) {
                setState(() {
                  semester2GradeOpen = value;
                });
              },
            ),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: saveSchoolYear,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.save),
                label: Text(
                  isEditing
                      ? "Lưu thay đổi"
                      : "Thêm năm học",
                  style: const TextStyle(fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}