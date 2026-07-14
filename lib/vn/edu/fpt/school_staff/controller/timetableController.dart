import 'package:flutter/foundation.dart';

import '../model/timetable.dart';
import '../service/timetableService.dart';

class TimetableController extends ChangeNotifier {
  final TimetableService service;

  TimetableController({
    required this.service,
  });

  bool isLoading = false;
  String? errorMessage;

  String selectedClass = "";
  String selectedSchoolYear = "";
  int selectedSemester = 1;
  int selectedDay = 1;

  List<String> classes = [];
  List<String> schoolYears = [];
  List<String> subjects = [];
  List<String> teachers = [];
  List<String> rooms = [];

  List<TimetableEntry> entries = [];

  Future<void> initialize() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      classes = await service.getClasses();
      schoolYears = await service.getSchoolYears();
      subjects = await service.getSubjects();
      teachers = await service.getTeachers();
      rooms = await service.getRooms();

      if (classes.isNotEmpty) {
        selectedClass = classes.first;
      }

      if (schoolYears.isNotEmpty) {
        selectedSchoolYear = schoolYears.first;
      }

      await loadEntries();
    } catch (error) {
      errorMessage = "Không thể tải thời khóa biểu";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadEntries() async {
    if (selectedClass.isEmpty ||
        selectedSchoolYear.isEmpty) {
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      entries = await service.getEntries(
        className: selectedClass,
        schoolYear: selectedSchoolYear,
        semester: selectedSemester,
      );
    } catch (error) {
      errorMessage = "Không thể tải danh sách tiết học";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  List<TimetableEntry> get currentDayEntries {
    final List<TimetableEntry> result = entries.where(
          (entry) => entry.weekDay == selectedDay,
    ).toList();

    result.sort(
          (a, b) => a.slot.compareTo(b.slot),
    );

    return result;
  }

  Future<void> changeClass(String value) async {
    selectedClass = value;
    await loadEntries();
  }

  Future<void> changeSchoolYear(String value) async {
    selectedSchoolYear = value;
    await loadEntries();
  }

  Future<void> changeSemester(int value) async {
    selectedSemester = value;
    await loadEntries();
  }

  void changeDay(int value) {
    selectedDay = value;
    notifyListeners();
  }

  Future<void> saveEntry(
      TimetableEntry entry,
      ) async {
    await service.saveEntry(entry);
    await loadEntries();
  }

  Future<void> deleteEntry(
      TimetableEntry entry,
      ) async {
    await service.deleteEntry(entry.id);
    await loadEntries();
  }

  bool hasSlotConflict({
    required int weekDay,
    required int slot,
    String? ignoredId,
  }) {
    return entries.any((entry) {
      return entry.weekDay == weekDay &&
          entry.slot == slot &&
          entry.id != ignoredId;
    });
  }
}