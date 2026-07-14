import '../model/timetable.dart';

class TimetableService {
  final List<String> _classes = [
    "10A1",
    "10A2",
    "11A1",
    "11A2",
    "12A1",
    "12A2",
  ];

  final List<String> _schoolYears = [
    "2025-2026",
    "2026-2027",
    "2027-2028",
  ];

  final List<String> _subjects = [
    "Toán",
    "Ngữ văn",
    "Tiếng Anh",
    "Vật lý",
    "Hóa học",
    "Sinh học",
    "Lịch sử",
    "Địa lý",
    "Tin học",
    "Công nghệ",
    "Giáo dục thể chất",
  ];

  final List<String> _teachers = [
    "Nguyễn Văn A",
    "Trần Thị B",
    "Lê Văn C",
    "Phạm Thị D",
    "Hoàng Văn E",
  ];

  final List<String> _rooms = [
    "A101",
    "A102",
    "A201",
    "B101",
    "B201",
    "C301",
  ];

  final List<TimetableEntry> _entries = [
    TimetableEntry(
      id: "TKB001",
      className: "12A1",
      schoolYear: "2026-2027",
      semester: 1,
      weekDay: 1,
      slot: 1,
      subjectName: "Toán",
      teacherName: "Nguyễn Văn A",
      roomName: "A101",
    ),
    TimetableEntry(
      id: "TKB002",
      className: "12A1",
      schoolYear: "2026-2027",
      semester: 1,
      weekDay: 1,
      slot: 2,
      subjectName: "Ngữ văn",
      teacherName: "Trần Thị B",
      roomName: "A101",
    ),
    TimetableEntry(
      id: "TKB003",
      className: "12A1",
      schoolYear: "2026-2027",
      semester: 1,
      weekDay: 2,
      slot: 1,
      subjectName: "Tiếng Anh",
      teacherName: "Lê Văn C",
      roomName: "A201",
    ),
  ];

  Future<List<String>> getClasses() async {
    await Future.delayed(
      const Duration(milliseconds: 200),
    );

    return List<String>.from(_classes);
  }

  Future<List<String>> getSchoolYears() async {
    await Future.delayed(
      const Duration(milliseconds: 200),
    );

    return List<String>.from(_schoolYears);
  }

  Future<List<String>> getSubjects() async {
    await Future.delayed(
      const Duration(milliseconds: 200),
    );

    return List<String>.from(_subjects);
  }

  Future<List<String>> getTeachers() async {
    await Future.delayed(
      const Duration(milliseconds: 200),
    );

    return List<String>.from(_teachers);
  }

  Future<List<String>> getRooms() async {
    await Future.delayed(
      const Duration(milliseconds: 200),
    );

    return List<String>.from(_rooms);
  }

  Future<List<TimetableEntry>> getEntries({
    required String className,
    required String schoolYear,
    required int semester,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
    );

    return _entries.where((entry) {
      return entry.className == className &&
          entry.schoolYear == schoolYear &&
          entry.semester == semester;
    }).toList();
  }

  Future<void> saveEntry(
      TimetableEntry entry,
      ) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
    );

    final int index = _entries.indexWhere(
          (item) => item.id == entry.id,
    );

    if (index >= 0) {
      _entries[index] = entry;
    } else {
      _entries.add(entry);
    }
  }

  Future<void> deleteEntry(
      String id,
      ) async {
    await Future.delayed(
      const Duration(milliseconds: 200),
    );

    _entries.removeWhere(
          (entry) => entry.id == id,
    );
  }
}