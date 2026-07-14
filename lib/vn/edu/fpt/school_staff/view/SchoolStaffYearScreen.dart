import 'package:flutter/material.dart';

import '../controller/schoolYearController.dart';
import '../model/schoolYear.dart';
import '../service/schoolYearService.dart';
import 'SchoolStaffYearFormScreen.dart';



class StaffSchoolYearScreen extends StatefulWidget {
  const StaffSchoolYearScreen({super.key});

  @override
  State<StaffSchoolYearScreen> createState() =>
      _StaffSchoolYearScreenState();
}

class _StaffSchoolYearScreenState
    extends State<StaffSchoolYearScreen> {
  late final SchoolYearController controller;

  @override
  void initState() {
    super.initState();

    controller = SchoolYearController(
      service: SchoolYearService(),
    );

    controller.loadSchoolYears();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String formatDate(DateTime date) {
    final String day =
    date.day.toString().padLeft(2, "0");

    final String month =
    date.month.toString().padLeft(2, "0");

    return "$day/$month/${date.year}";
  }

  Future<void> openAddScreen() async {
    final SchoolYear? newSchoolYear =
    await Navigator.push<SchoolYear>(
      context,
      MaterialPageRoute(
        builder: (context) =>
        const StaffSchoolYearFormScreen(),
      ),
    );

    if (newSchoolYear != null) {
      await controller.addSchoolYear(newSchoolYear);
    }
  }

  Future<void> openEditScreen(
      SchoolYear schoolYear,
      ) async {
    final SchoolYear? updated =
    await Navigator.push<SchoolYear>(
      context,
      MaterialPageRoute(
        builder: (context) =>
            StaffSchoolYearFormScreen(
              schoolYear: schoolYear,
            ),
      ),
    );

    if (updated != null) {
      await controller.updateSchoolYear(updated);
    }
  }

  void confirmDelete(SchoolYear schoolYear) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Xóa năm học"),
          content: Text(
            "Bạn có chắc muốn xóa năm học "
                "${schoolYear.name} không?",
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
              onPressed: () async {
                Navigator.pop(dialogContext);

                await controller.deleteSchoolYear(
                  schoolYear,
                );
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

  Widget buildSemesterCard({
    required SchoolYear schoolYear,
    required Semester semester,
    required int semesterIndex,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Học kỳ ${semester.semesterNumber}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                semester.gradeEntryOpen
                    ? "Đang mở nhập điểm"
                    : "Đã khóa nhập điểm",
                style: TextStyle(
                  color: semester.gradeEntryOpen
                      ? Colors.green
                      : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "${formatDate(semester.startDate)}"
                  " - "
                  "${formatDate(semester.endDate)}",
            ),
          ),

          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              "Cho phép giáo viên nhập điểm",
            ),
            value: semester.gradeEntryOpen,
            onChanged: (value) {
              controller.changeGradeEntryStatus(
                schoolYear: schoolYear,
                semesterIndex: semesterIndex,
                isOpen: value,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildSchoolYearCard(
      SchoolYear schoolYear,
      ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: schoolYear.active
                      ? Colors.green.shade50
                      : Colors.grey.shade200,
                  child: Icon(
                    Icons.calendar_month,
                    color: schoolYear.active
                        ? Colors.green
                        : Colors.grey,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        schoolYear.name,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        schoolYear.active
                            ? "Năm học đang hoạt động"
                            : "Năm học không hoạt động",
                        style: TextStyle(
                          color: schoolYear.active
                              ? Colors.green
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == "active") {
                      controller.setActiveSchoolYear(
                        schoolYear,
                      );
                    }

                    if (value == "edit") {
                      openEditScreen(schoolYear);
                    }

                    if (value == "delete") {
                      confirmDelete(schoolYear);
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      if (!schoolYear.active)
                        const PopupMenuItem(
                          value: "active",
                          child: Text(
                            "Đặt làm năm học hiện tại",
                          ),
                        ),
                      const PopupMenuItem(
                        value: "edit",
                        child: Text("Sửa"),
                      ),
                      const PopupMenuItem(
                        value: "delete",
                        child: Text("Xóa"),
                      ),
                    ];
                  },
                ),
              ],
            ),

            for (int index = 0;
            index < schoolYear.semesters.length;
            index++)
              buildSemesterCard(
                schoolYear: schoolYear,
                semester:
                schoolYear.semesters[index],
                semesterIndex: index,
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      appBar: AppBar(
        title: const Text("Năm học và học kỳ"),
        centerTitle: true,
        backgroundColor: const Color(0xFF18324F),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: openAddScreen,
            icon: const Icon(Icons.add),
          ),
        ],
      ),

      body: ListenableBuilder(
        listenable: controller,
        builder: (context, child) {
          if (controller.isLoading &&
              controller.schoolYears.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (controller.schoolYears.isEmpty) {
            return const Center(
              child: Text("Chưa có năm học"),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: controller.schoolYears.length,
            itemBuilder: (context, index) {
              return buildSchoolYearCard(
                controller.schoolYears[index],
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: openAddScreen,
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}