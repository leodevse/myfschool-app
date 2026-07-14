class TimetableEntry {
  final String id;
  final String className;
  final String schoolYear;
  final int semester;
  final int weekDay;
  final int slot;
  final String subjectName;
  final String teacherName;
  final String roomName;

  TimetableEntry({
    required this.id,
    required this.className,
    required this.schoolYear,
    required this.semester,
    required this.weekDay,
    required this.slot,
    required this.subjectName,
    required this.teacherName,
    required this.roomName,
  });

  TimetableEntry copyWith({
    String? id,
    String? className,
    String? schoolYear,
    int? semester,
    int? weekDay,
    int? slot,
    String? subjectName,
    String? teacherName,
    String? roomName,
  }) {
    return TimetableEntry(
      id: id ?? this.id,
      className: className ?? this.className,
      schoolYear: schoolYear ?? this.schoolYear,
      semester: semester ?? this.semester,
      weekDay: weekDay ?? this.weekDay,
      slot: slot ?? this.slot,
      subjectName: subjectName ?? this.subjectName,
      teacherName: teacherName ?? this.teacherName,
      roomName: roomName ?? this.roomName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "className": className,
      "schoolYear": schoolYear,
      "semester": semester,
      "weekDay": weekDay,
      "slot": slot,
      "subjectName": subjectName,
      "teacherName": teacherName,
      "roomName": roomName,
    };
  }

  factory TimetableEntry.fromJson(
      Map<String, dynamic> json,
      ) {
    return TimetableEntry(
      id: json["id"].toString(),
      className: json["className"].toString(),
      schoolYear: json["schoolYear"].toString(),
      semester: int.parse(
        json["semester"].toString(),
      ),
      weekDay: int.parse(
        json["weekDay"].toString(),
      ),
      slot: int.parse(
        json["slot"].toString(),
      ),
      subjectName: json["subjectName"].toString(),
      teacherName: json["teacherName"].toString(),
      roomName: json["roomName"].toString(),
    );
  }
}