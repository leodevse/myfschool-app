import 'package:flutter/material.dart';

import '../controller/timetableController.dart';
import '../model/timetable.dart';
import '../service/timetableService.dart';
import 'SchoolStaffTimetableFormScreen.dart';

class StaffTimetableScreen extends StatefulWidget {
  const StaffTimetableScreen({super.key});

  @override
  State<StaffTimetableScreen> createState() =>
      _StaffTimetableScreenState();
}

class _StaffTimetableScreenState
    extends State<StaffTimetableScreen> {
  late final TimetableController controller;

  final List<String> dayNames = [
    "T2",
    "T3",
    "T4",
    "T5",
    "T6",
    "T7",
  ];

  @override
  void initState() {
    super.initState();

    controller = TimetableController(
      service: TimetableService(),
    );

    controller.initialize();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String getSlotTime(int slot) {
    const Map<int, String> times = {
      1: "07:00 - 07:45",
      2: "07:55 - 08:40",
      3: "08:50 - 09:35",
      4: "09:50 - 10:35",
      5: "10:45 - 11:30",
      6: "13:30 - 14:15",
      7: "14:25 - 15:10",
    };

    return times[slot] ?? "";
  }

  Future<void> openAddEntry() async {
    final TimetableEntry? result =
    await Navigator.push<TimetableEntry>(
      context,
      MaterialPageRoute(
        builder: (context) =>
            StaffTimetableFormScreen(
              className: controller.selectedClass,
              schoolYear:
              controller.selectedSchoolYear,
              semester: controller.selectedSemester,
              initialDay: controller.selectedDay,
              subjects: controller.subjects,
              teachers: controller.teachers,
              rooms: controller.rooms,
              hasSlotConflict:
              controller.hasSlotConflict,
            ),
      ),
    );

    if (result != null) {
      await controller.saveEntry(result);
    }
  }

  Future<void> openEditEntry(
      TimetableEntry entry,
      ) async {
    final TimetableEntry? result =
    await Navigator.push<TimetableEntry>(
      context,
      MaterialPageRoute(
        builder: (context) =>
            StaffTimetableFormScreen(
              entry: entry,
              className: controller.selectedClass,
              schoolYear:
              controller.selectedSchoolYear,
              semester: controller.selectedSemester,
              initialDay: controller.selectedDay,
              subjects: controller.subjects,
              teachers: controller.teachers,
              rooms: controller.rooms,
              hasSlotConflict:
              controller.hasSlotConflict,
            ),
      ),
    );

    if (result != null) {
      await controller.saveEntry(result);
    }
  }

  void confirmDelete(TimetableEntry entry) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Xóa tiết học"),
          content: Text(
            "Bạn có chắc muốn xóa "
                "${entry.subjectName} - Tiết ${entry.slot} không?",
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
                await controller.deleteEntry(entry);
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

  Widget buildSemesterButton(
      String title,
      int semester,
      ) {
    final bool selected =
        controller.selectedSemester == semester;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          controller.changeSemester(semester);
        },
        child: Container(
          height: 42,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected
                ? Colors.deepOrange
                : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(22),
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

  Widget buildDayButton(int index) {
    final int day = index + 1;
    final bool selected =
        controller.selectedDay == day;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          controller.changeDay(day);
        },
        child: Container(
          height: 44,
          margin: const EdgeInsets.symmetric(
            horizontal: 3,
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected
                ? Colors.blue
                : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selected
                  ? Colors.blue
                  : Colors.grey,
            ),
          ),
          child: Text(
            dayNames[index],
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

  Widget buildEntryCard(
      TimetableEntry entry,
      ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade50,
          child: Text(
            entry.slot.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          entry.subjectName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "${getSlotTime(entry.slot)}\n"
              "GV: ${entry.teacherName}\n"
              "Phòng: ${entry.roomName}",
        ),
        isThreeLine: true,
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == "edit") {
              openEditEntry(entry);
            }

            if (value == "delete") {
              confirmDelete(entry);
            }
          },
          itemBuilder: (context) {
            return const [
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      appBar: AppBar(
        title: const Text("Quản lý thời khóa biểu"),
        centerTitle: true,
        backgroundColor: const Color(0xFF18324F),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: openAddEntry,
            icon: const Icon(Icons.add),
          ),
        ],
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
                Row(
                  children: [
                    Expanded(
                      child:
                      DropdownButtonFormField<String>(
                        initialValue:
                        controller.selectedClass,
                        decoration:
                        const InputDecoration(
                          labelText: "Lớp",
                          border: OutlineInputBorder(),
                        ),
                        items: controller.classes.map(
                              (className) {
                            return DropdownMenuItem(
                              value: className,
                              child: Text(className),
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            controller.changeClass(value);
                          }
                        },
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child:
                      DropdownButtonFormField<String>(
                        initialValue: controller
                            .selectedSchoolYear,
                        decoration:
                        const InputDecoration(
                          labelText: "Năm học",
                          border: OutlineInputBorder(),
                        ),
                        items:
                        controller.schoolYears.map(
                              (year) {
                            return DropdownMenuItem(
                              value: year,
                              child: Text(year),
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            controller
                                .changeSchoolYear(value);
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
                      "Học kỳ I",
                      1,
                    ),
                    const SizedBox(width: 10),
                    buildSemesterButton(
                      "Học kỳ II",
                      2,
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                Row(
                  children: List.generate(
                    6,
                    buildDayButton,
                  ),
                ),

                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Lịch học ${dayNames[controller.selectedDay - 1]}",
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${controller.currentDayEntries.length} tiết",
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Expanded(
                  child: controller.isLoading
                      ? const Center(
                    child:
                    CircularProgressIndicator(),
                  )
                      : controller
                      .currentDayEntries.isEmpty
                      ? const Center(
                    child: Text(
                      "Chưa có tiết học",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  )
                      : ListView.builder(
                    itemCount: controller
                        .currentDayEntries
                        .length,
                    itemBuilder:
                        (context, index) {
                      return buildEntryCard(
                        controller
                            .currentDayEntries[
                        index],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: openAddEntry,
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}