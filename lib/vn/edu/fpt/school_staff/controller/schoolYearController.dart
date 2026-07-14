import 'package:flutter/foundation.dart';

import '../model/schoolYear.dart';
import '../service/schoolYearService.dart';

class SchoolYearController extends ChangeNotifier {
  final SchoolYearService service;

  SchoolYearController({
    required this.service,
  });

  bool isLoading = false;
  bool isSaving = false;
  String? errorMessage;

  List<SchoolYear> schoolYears = [];

  Future<void> loadSchoolYears() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      schoolYears = await service.getSchoolYears();
    } catch (error) {
      errorMessage = "Không thể tải danh sách năm học";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addSchoolYear(
      SchoolYear schoolYear,
      ) async {
    isSaving = true;
    errorMessage = null;
    notifyListeners();

    try {
      await service.addSchoolYear(schoolYear);
      await loadSchoolYears();

      return true;
    } catch (error) {
      errorMessage = "Không thể thêm năm học";
      return false;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  Future<bool> updateSchoolYear(
      SchoolYear schoolYear,
      ) async {
    isSaving = true;
    errorMessage = null;
    notifyListeners();

    try {
      await service.updateSchoolYear(schoolYear);
      await loadSchoolYears();

      return true;
    } catch (error) {
      errorMessage = "Không thể cập nhật năm học";
      return false;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  Future<void> deleteSchoolYear(
      SchoolYear schoolYear,
      ) async {
    await service.deleteSchoolYear(schoolYear.id);
    await loadSchoolYears();
  }

  Future<void> setActiveSchoolYear(
      SchoolYear selectedSchoolYear,
      ) async {
    for (final schoolYear in schoolYears) {
      final SchoolYear updated = schoolYear.copyWith(
        active: schoolYear.id == selectedSchoolYear.id,
      );

      await service.updateSchoolYear(updated);
    }

    await loadSchoolYears();
  }

  Future<void> changeGradeEntryStatus({
    required SchoolYear schoolYear,
    required int semesterIndex,
    required bool isOpen,
  }) async {
    final List<Semester> updatedSemesters =
    List<Semester>.from(schoolYear.semesters);

    updatedSemesters[semesterIndex] =
        updatedSemesters[semesterIndex].copyWith(
          gradeEntryOpen: isOpen,
        );

    final SchoolYear updatedSchoolYear =
    schoolYear.copyWith(
      semesters: updatedSemesters,
    );

    await service.updateSchoolYear(updatedSchoolYear);
    await loadSchoolYears();
  }
}