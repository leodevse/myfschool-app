import '../model/assignment.dart';

class AssignmentService {
  // Danh sách lớp giả lập.
  final List<String> _classes = [
    "10A1",
    "10A2",
    "11A1",
    "11A2",
    "12A1",
    "12A2",
  ];

  // Danh sách năm học giả lập.
  final List<String> _schoolYears = [
    "2025-2026",
    "2026-2027",
    "2027-2028",
  ];

  // Danh sách môn học THPT.
  final List<String> _subjects = [
    "Toán",
    "Ngữ văn",
    "Tiếng Anh",
    "Vật lý",
    "Hóa học",
    "Sinh học",
    "Lịch sử",
    "Địa lý",
    "Giáo dục kinh tế và pháp luật",
    "Tin học",
    "Công nghệ",
    "Giáo dục thể chất",
  ];

  // Giáo viên được chia theo bộ môn.
  final Map<String, List<String>> _teachersBySubject = {
    "Toán": [
      "Nguyễn Văn A",
      "Trần Thị Toán",
      "Phạm Minh Đức",
    ],
    "Ngữ văn": [
      "Lê Thị C",
      "Nguyễn Thị Hoa",
      "Trần Văn Bình",
    ],
    "Tiếng Anh": [
      "Phạm Minh D",
      "Hoàng Thị Lan",
      "Nguyễn Anh Tuấn",
    ],
    "Vật lý": [
      "Trần Văn B",
      "Lê Minh Quang",
    ],
    "Hóa học": [
      "Nguyễn Thị Hương",
      "Phạm Văn Hùng",
    ],
    "Sinh học": [
      "Lê Thị Mai",
      "Đỗ Văn Nam",
    ],
    "Lịch sử": [
      "Trần Thị Hải",
      "Nguyễn Văn Sơn",
    ],
    "Địa lý": [
      "Phạm Thị Hà",
      "Lê Minh Hoàng",
    ],
    "Giáo dục kinh tế và pháp luật": [
      "Nguyễn Thị Hạnh",
      "Trần Văn Long",
    ],
    "Tin học": [
      "Lê Văn Cường",
      "Nguyễn Minh Khoa",
    ],
    "Công nghệ": [
      "Phạm Văn Thành",
      "Đỗ Minh Anh",
    ],
    "Giáo dục thể chất": [
      "Nguyễn Văn Khỏe",
      "Trần Minh Phúc",
    ],
  };

  // Dữ liệu phân công giả lập lưu trong bộ nhớ.
  final List<TeachingAssignment> _assignments = [
    TeachingAssignment(
      id: "PC001",
      className: "12A1",
      subjectName: "Toán",
      teacherName: "Nguyễn Văn A",
      schoolYear: "2026-2027",
      semester: 1,
    ),
    TeachingAssignment(
      id: "PC002",
      className: "12A1",
      subjectName: "Ngữ văn",
      teacherName: "Lê Thị C",
      schoolYear: "2026-2027",
      semester: 1,
    ),
    TeachingAssignment(
      id: "PC003",
      className: "12A1",
      subjectName: "Tiếng Anh",
      teacherName: "Phạm Minh D",
      schoolYear: "2026-2027",
      semester: 1,
    ),
  ];

  // Giả lập lấy danh sách lớp từ backend.
  Future<List<String>> getClasses() async {
    await Future.delayed(
      const Duration(milliseconds: 300),
    );

    return List<String>.from(_classes);
  }

  // Giả lập lấy danh sách năm học.
  Future<List<String>> getSchoolYears() async {
    await Future.delayed(
      const Duration(milliseconds: 300),
    );

    return List<String>.from(_schoolYears);
  }

  // Giả lập lấy danh sách môn.
  Future<List<String>> getSubjects() async {
    await Future.delayed(
      const Duration(milliseconds: 300),
    );

    return List<String>.from(_subjects);
  }

  // Lấy danh sách giáo viên theo môn.
  Future<List<String>> getTeachersBySubject(
      String subjectName,
      ) async {
    await Future.delayed(
      const Duration(milliseconds: 200),
    );

    return List<String>.from(
      _teachersBySubject[subjectName] ?? [],
    );
  }

  // Lấy danh sách phân công theo lớp, năm học và học kỳ.
  Future<List<TeachingAssignment>> getAssignments({
    required String className,
    required String schoolYear,
    required int semester,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 400),
    );

    return _assignments.where((assignment) {
      return assignment.className == className &&
          assignment.schoolYear == schoolYear &&
          assignment.semester == semester;
    }).toList();
  }

  // Lưu toàn bộ danh sách phân công.
  Future<void> saveAssignments(
      List<TeachingAssignment> assignments,
      ) async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    for (final assignment in assignments) {
      final int index = _assignments.indexWhere(
            (item) => item.id == assignment.id,
      );

      if (index >= 0) {
        // Nếu đã tồn tại thì cập nhật.
        _assignments[index] = assignment;
      } else {
        // Nếu chưa tồn tại thì thêm mới.
        _assignments.add(assignment);
      }
    }
  }
}