class Semester {
  final int semesterNumber;
  final DateTime startDate;
  final DateTime endDate;
  final bool gradeEntryOpen;

  Semester({
    required this.semesterNumber,
    required this.startDate,
    required this.endDate,
    required this.gradeEntryOpen,
  });

  Semester copyWith({
    int? semesterNumber,
    DateTime? startDate,
    DateTime? endDate,
    bool? gradeEntryOpen,
  }) {
    return Semester(
      semesterNumber: semesterNumber ?? this.semesterNumber,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      gradeEntryOpen: gradeEntryOpen ?? this.gradeEntryOpen,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "semesterNumber": semesterNumber,
      "startDate": startDate.toIso8601String(),
      "endDate": endDate.toIso8601String(),
      "gradeEntryOpen": gradeEntryOpen,
    };
  }

  factory Semester.fromJson(Map<String, dynamic> json) {
    return Semester(
      semesterNumber: int.parse(
        json["semesterNumber"].toString(),
      ),
      startDate: DateTime.parse(
        json["startDate"].toString(),
      ),
      endDate: DateTime.parse(
        json["endDate"].toString(),
      ),
      gradeEntryOpen:
      json["gradeEntryOpen"].toString() == "true",
    );
  }
}

class SchoolYear {
  final String id;
  final String name;
  final bool active;
  final List<Semester> semesters;

  SchoolYear({
    required this.id,
    required this.name,
    required this.active,
    required this.semesters,
  });

  SchoolYear copyWith({
    String? id,
    String? name,
    bool? active,
    List<Semester>? semesters,
  }) {
    return SchoolYear(
      id: id ?? this.id,
      name: name ?? this.name,
      active: active ?? this.active,
      semesters: semesters ?? this.semesters,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "active": active,
      "semesters": semesters
          .map((semester) => semester.toJson())
          .toList(),
    };
  }

  factory SchoolYear.fromJson(
      Map<String, dynamic> json,
      ) {
    return SchoolYear(
      id: json["id"].toString(),
      name: json["name"].toString(),
      active: json["active"].toString() == "true",
      semesters: (json["semesters"] as List)
          .map(
            (item) => Semester.fromJson(
          item as Map<String, dynamic>,
        ),
      )
          .toList(),
    );
  }
}