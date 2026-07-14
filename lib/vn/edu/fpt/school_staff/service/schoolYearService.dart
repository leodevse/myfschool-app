import '../model/schoolYear.dart';

class SchoolYearService {
  final List<SchoolYear> _schoolYears = [
    SchoolYear(
      id: "NH001",
      name: "2025-2026",
      active: false,
      semesters: [
        Semester(
          semesterNumber: 1,
          startDate: DateTime(2025, 9, 5),
          endDate: DateTime(2026, 1, 15),
          gradeEntryOpen: false,
        ),
        Semester(
          semesterNumber: 2,
          startDate: DateTime(2026, 1, 20),
          endDate: DateTime(2026, 5, 25),
          gradeEntryOpen: false,
        ),
      ],
    ),
    SchoolYear(
      id: "NH002",
      name: "2026-2027",
      active: true,
      semesters: [
        Semester(
          semesterNumber: 1,
          startDate: DateTime(2026, 9, 5),
          endDate: DateTime(2027, 1, 15),
          gradeEntryOpen: true,
        ),
        Semester(
          semesterNumber: 2,
          startDate: DateTime(2027, 1, 20),
          endDate: DateTime(2027, 5, 25),
          gradeEntryOpen: false,
        ),
      ],
    ),
  ];

  Future<List<SchoolYear>> getSchoolYears() async {
    await Future.delayed(
      const Duration(milliseconds: 400),
    );

    return List<SchoolYear>.from(_schoolYears);
  }

  Future<void> addSchoolYear(
      SchoolYear schoolYear,
      ) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
    );

    _schoolYears.add(schoolYear);
  }

  Future<void> updateSchoolYear(
      SchoolYear schoolYear,
      ) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
    );

    final int index = _schoolYears.indexWhere(
          (item) => item.id == schoolYear.id,
    );

    if (index >= 0) {
      _schoolYears[index] = schoolYear;
    }
  }

  Future<void> deleteSchoolYear(
      String id,
      ) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
    );

    _schoolYears.removeWhere(
          (item) => item.id == id,
    );
  }
}