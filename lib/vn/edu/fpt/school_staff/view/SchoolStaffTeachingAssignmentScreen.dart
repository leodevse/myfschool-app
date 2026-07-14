import 'package:flutter/material.dart';

import '../controller/assignmentController.dart';
import '../model/assignment.dart';
import '../service/assignmentService.dart';



class StaffTeachingAssignmentScreen
    extends StatefulWidget {
  const StaffTeachingAssignmentScreen({super.key});

  @override
  State<StaffTeachingAssignmentScreen> createState() =>
      _StaffTeachingAssignmentScreenState();
}

class _StaffTeachingAssignmentScreenState
    extends State<StaffTeachingAssignmentScreen> {
  late final AssignmentController controller;

  @override
  void initState() {
    super.initState();

    // Tạo service.
    final AssignmentService service =
    AssignmentService();

    // Truyền service vào controller.
    controller = AssignmentController(
      service: service,
    );

    // Tải dữ liệu sau khi tạo màn hình.
    controller.initialize();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  Widget buildSemesterButton({
    required String title,
    required int semester,
  }) {
    final bool selected =
        controller.selectedSemester == semester;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          controller.changeSemester(semester);
        },
        child: Container(
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected
                ? Colors.deepOrange
                : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: selected
                  ? Colors.white
                  : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFilterSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                initialValue:
                controller.selectedClass.isEmpty
                    ? null
                    : controller.selectedClass,
                decoration: const InputDecoration(
                  labelText: "Lớp",
                  prefixIcon: Icon(Icons.class_),
                  border: OutlineInputBorder(),
                ),
                items: controller.classes.map((className) {
                  return DropdownMenuItem<String>(
                    value: className,
                    child: Text(className),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.changeClass(value);
                  }
                },
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: DropdownButtonFormField<String>(
                initialValue:
                controller.selectedSchoolYear.isEmpty
                    ? null
                    : controller.selectedSchoolYear,
                decoration: const InputDecoration(
                  labelText: "Năm học",
                  prefixIcon: Icon(
                    Icons.calendar_month,
                  ),
                  border: OutlineInputBorder(),
                ),
                items:
                controller.schoolYears.map((schoolYear) {
                  return DropdownMenuItem<String>(
                    value: schoolYear,
                    child: Text(schoolYear),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.changeSchoolYear(value);
                  }
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 15),

        Row(
          children: [
            buildSemesterButton(
              title: "Học kỳ I",
              semester: 1,
            ),

            const SizedBox(width: 10),

            buildSemesterButton(
              title: "Học kỳ II",
              semester: 2,
            ),
          ],
        ),
      ],
    );
  }

  Widget buildAssignmentCard(
      int index,
      TeachingAssignment assignment,
      ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),

      child: Padding(
        padding: const EdgeInsets.all(12),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue.shade50,
                  child: const Icon(
                    Icons.menu_book,
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    assignment.subjectName,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            FutureBuilder<List<String>>(
              future: controller.getTeachers(
                assignment.subjectName,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const LinearProgressIndicator();
                }

                if (snapshot.hasError) {
                  return const Text(
                    "Không thể tải giáo viên",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  );
                }

                final List<String> teachers =
                    snapshot.data ?? [];

                String? selectedTeacher;

                if (assignment.teacherName.isNotEmpty &&
                    teachers.contains(
                      assignment.teacherName,
                    )) {
                  selectedTeacher =
                      assignment.teacherName;
                }

                return DropdownButtonFormField<String>(
                  initialValue: selectedTeacher,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: "Giáo viên phụ trách",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  hint: const Text(
                    "Chọn giáo viên",
                  ),
                  items: teachers.map((teacherName) {
                    return DropdownMenuItem<String>(
                      value: teacherName,
                      child: Text(
                        teacherName,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.changeTeacher(
                        index,
                        value,
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAssignmentList() {
    if (controller.assignments.isEmpty) {
      return const Center(
        child: Text(
          "Chưa có môn học để phân công",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 15),
      itemCount: controller.assignments.length,
      itemBuilder: (context, index) {
        return buildAssignmentCard(
          index,
          controller.assignments[index],
        );
      },
    );
  }

  Future<void> saveAssignments() async {
    final bool success =
    await controller.saveAssignments();

    if (!mounted) {
      return;
    }

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Đã lưu phân công giảng dạy",
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            controller.errorMessage ??
                "Không thể lưu phân công",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      appBar: AppBar(
        title: const Text(
          "Phân công giảng dạy",
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF18324F),
        foregroundColor: Colors.white,
      ),

      body: ListenableBuilder(
        listenable: controller,
        builder: (context, child) {
          if (controller.isLoading &&
              controller.classes.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(15),

            child: Column(
              children: [
                buildFilterSection(),

                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Danh sách môn học",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      "${controller.assignments.length} môn",
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),

                if (controller.errorMessage != null)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                    child: Text(
                      controller.errorMessage!,
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),

                Expanded(
                  child: controller.isLoading
                      ? const Center(
                    child:
                    CircularProgressIndicator(),
                  )
                      : buildAssignmentList(),
                ),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: controller.isSaving
                        ? null
                        : saveAssignments,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      Colors.deepOrange,
                      foregroundColor: Colors.white,
                    ),
                    icon: controller.isSaving
                        ? const SizedBox(
                      width: 20,
                      height: 20,
                      child:
                      CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                        : const Icon(Icons.save),
                    label: Text(
                      controller.isSaving
                          ? "Đang lưu..."
                          : "Lưu phân công",
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}