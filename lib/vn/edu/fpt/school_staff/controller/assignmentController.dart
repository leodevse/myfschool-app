import 'package:flutter/foundation.dart';

import '../model/assignment.dart';
import '../service/assignmentService.dart';

class AssignmentController extends ChangeNotifier {
  final AssignmentService service;

  AssignmentController({
    required this.service,
  });

  // Trạng thái loading.
  bool isLoading = false;

  // Trạng thái đang lưu.
  bool isSaving = false;

  // Thông báo lỗi.
  String? errorMessage;

  // Các giá trị đang được chọn.
  String selectedClass = "";
  String selectedSchoolYear = "";
  int selectedSemester = 1;

  // Các danh sách dùng cho dropdown.
  List<String> classes = [];
  List<String> schoolYears = [];
  List<String> subjects = [];

  // Danh sách phân công hiển thị trên màn hình.
  List<TeachingAssignment> assignments = [];

  // Khởi tạo dữ liệu ban đầu.
  Future<void> initialize() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      classes = await service.getClasses();
      schoolYears = await service.getSchoolYears();
      subjects = await service.getSubjects();

      if (classes.isNotEmpty) {
        selectedClass = classes.first;
      }

      if (schoolYears.isNotEmpty) {
        selectedSchoolYear = schoolYears.first;
      }

      await loadAssignments();
    } catch (error) {
      errorMessage = "Không thể tải dữ liệu phân công";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Tải phân công theo bộ lọc hiện tại.
  Future<void> loadAssignments() async {
    if (selectedClass.isEmpty ||
        selectedSchoolYear.isEmpty) {
      return;
    }

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final existingAssignments =
      await service.getAssignments(
        className: selectedClass,
        schoolYear: selectedSchoolYear,
        semester: selectedSemester,
      );

      assignments = [];

      // Tạo một dòng phân công cho mỗi môn học.
      for (int index = 0; index < subjects.length; index++) {
        final String subject = subjects[index];

        TeachingAssignment? existingAssignment;

        for (final item in existingAssignments) {
          if (item.subjectName == subject) {
            existingAssignment = item;
            break;
          }
        }

        if (existingAssignment != null) {
          assignments.add(existingAssignment);
        } else {
          assignments.add(
            TeachingAssignment(
              id: _createAssignmentId(index),
              className: selectedClass,
              subjectName: subject,
              teacherName: "",
              schoolYear: selectedSchoolYear,
              semester: selectedSemester,
            ),
          );
        }
      }
    } catch (error) {
      errorMessage = "Không thể tải danh sách phân công";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Thay đổi lớp.
  Future<void> changeClass(String value) async {
    selectedClass = value;
    notifyListeners();

    await loadAssignments();
  }

  // Thay đổi năm học.
  Future<void> changeSchoolYear(String value) async {
    selectedSchoolYear = value;
    notifyListeners();

    await loadAssignments();
  }

  // Thay đổi học kỳ.
  Future<void> changeSemester(int value) async {
    selectedSemester = value;
    notifyListeners();

    await loadAssignments();
  }

  // Cập nhật giáo viên cho một môn.
  void changeTeacher(
      int assignmentIndex,
      String teacherName,
      ) {
    final TeachingAssignment oldAssignment =
    assignments[assignmentIndex];

    assignments[assignmentIndex] =
        oldAssignment.copyWith(
          teacherName: teacherName,
        );

    notifyListeners();
  }

  // Lấy giáo viên theo môn.
  Future<List<String>> getTeachers(
      String subjectName,
      ) {
    return service.getTeachersBySubject(subjectName);
  }

  // Lưu danh sách phân công.
  Future<bool> saveAssignments() async {
    // Kiểm tra có môn nào chưa được chọn giáo viên.
    final bool hasEmptyTeacher = assignments.any(
          (assignment) =>
      assignment.teacherName.trim().isEmpty,
    );

    if (hasEmptyTeacher) {
      errorMessage =
      "Vui lòng phân công giáo viên cho tất cả môn học";
      notifyListeners();

      return false;
    }

    isSaving = true;
    errorMessage = null;
    notifyListeners();

    try {
      await service.saveAssignments(assignments);

      return true;
    } catch (error) {
      errorMessage = "Không thể lưu phân công";

      return false;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  // Sinh mã phân công đơn giản.
  String _createAssignmentId(int index) {
    final String classPart =
    selectedClass.replaceAll(" ", "");

    final String yearPart =
    selectedSchoolYear.replaceAll("-", "");

    return "PC_${classPart}_${yearPart}_"
        "${selectedSemester}_${index + 1}";
  }
}