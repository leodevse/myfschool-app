import 'package:flutter/material.dart';

import '../model/timetable.dart';

class StaffTimetableFormScreen extends StatefulWidget {
  final TimetableEntry? entry;
  final String className;
  final String schoolYear;
  final int semester;
  final int initialDay;
  final List<String> subjects;
  final List<String> teachers;
  final List<String> rooms;
  final bool Function({
  required int weekDay,
  required int slot,
  String? ignoredId,
  }) hasSlotConflict;

  const StaffTimetableFormScreen({
    super.key,
    this.entry,
    required this.className,
    required this.schoolYear,
    required this.semester,
    required this.initialDay,
    required this.subjects,
    required this.teachers,
    required this.rooms,
    required this.hasSlotConflict,
  });

  @override
  State<StaffTimetableFormScreen> createState() =>
      _StaffTimetableFormScreenState();
}

class _StaffTimetableFormScreenState
    extends State<StaffTimetableFormScreen> {
  late int selectedDay;
  late int selectedSlot;
  late String selectedSubject;
  late String selectedTeacher;
  late String selectedRoom;

  bool get isEditing => widget.entry != null;

  final List<String> dayNames = [
    "Thứ 2",
    "Thứ 3",
    "Thứ 4",
    "Thứ 5",
    "Thứ 6",
    "Thứ 7",
  ];

  @override
  void initState() {
    super.initState();

    selectedDay =
        widget.entry?.weekDay ?? widget.initialDay;

    selectedSlot = widget.entry?.slot ?? 1;

    selectedSubject =
        widget.entry?.subjectName ??
            widget.subjects.first;

    selectedTeacher =
        widget.entry?.teacherName ??
            widget.teachers.first;

    selectedRoom =
        widget.entry?.roomName ??
            widget.rooms.first;
  }

  void saveEntry() {
    final bool conflict =
    widget.hasSlotConflict(
      weekDay: selectedDay,
      slot: selectedSlot,
      ignoredId: widget.entry?.id,
    );

    if (conflict) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Tiết học này đã có môn khác",
          ),
        ),
      );
      return;
    }

    final TimetableEntry result = TimetableEntry(
      id: widget.entry?.id ??
          "TKB${DateTime.now().millisecondsSinceEpoch}",
      className: widget.className,
      schoolYear: widget.schoolYear,
      semester: widget.semester,
      weekDay: selectedDay,
      slot: selectedSlot,
      subjectName: selectedSubject,
      teacherName: selectedTeacher,
      roomName: selectedRoom,
    );

    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text(
          isEditing
              ? "Sửa tiết học"
              : "Thêm tiết học",
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF18324F),
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),

        child: Column(
          children: [
            InputDecorator(
              decoration: const InputDecoration(
                labelText: "Lớp",
                border: OutlineInputBorder(),
              ),
              child: Text(widget.className),
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<int>(
                    initialValue: selectedDay,
                    decoration: const InputDecoration(
                      labelText: "Ngày",
                      border: OutlineInputBorder(),
                    ),
                    items: List.generate(
                      6,
                          (index) {
                        return DropdownMenuItem<int>(
                          value: index + 1,
                          child: Text(dayNames[index]),
                        );
                      },
                    ),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedDay = value;
                        });
                      }
                    },
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: DropdownButtonFormField<int>(
                    initialValue: selectedSlot,
                    decoration: const InputDecoration(
                      labelText: "Tiết",
                      border: OutlineInputBorder(),
                    ),
                    items: List.generate(
                      7,
                          (index) {
                        return DropdownMenuItem<int>(
                          value: index + 1,
                          child: Text(
                            "Tiết ${index + 1}",
                          ),
                        );
                      },
                    ),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedSlot = value;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              initialValue: selectedSubject,
              decoration: const InputDecoration(
                labelText: "Môn học",
                prefixIcon: Icon(Icons.menu_book),
                border: OutlineInputBorder(),
              ),
              items: widget.subjects.map((subject) {
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

            DropdownButtonFormField<String>(
              initialValue: selectedTeacher,
              decoration: const InputDecoration(
                labelText: "Giáo viên",
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              items: widget.teachers.map((teacher) {
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

            DropdownButtonFormField<String>(
              initialValue: selectedRoom,
              decoration: const InputDecoration(
                labelText: "Phòng học",
                prefixIcon: Icon(Icons.meeting_room),
                border: OutlineInputBorder(),
              ),
              items: widget.rooms.map((room) {
                return DropdownMenuItem<String>(
                  value: room,
                  child: Text(room),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedRoom = value;
                  });
                }
              },
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: saveEntry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.save),
                label: Text(
                  isEditing
                      ? "Lưu thay đổi"
                      : "Thêm tiết học",
                  style: const TextStyle(
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