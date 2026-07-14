class TeachingAssignment {
  final String id;
  final String className;
  final String subjectName;
  final String teacherName;
  final String schoolYear;
  final int semester;

  TeachingAssignment({
    required this.id,
    required this.className,
    required this.subjectName,
    required this.teacherName,
    required this.schoolYear,
    required this.semester,
  });

  // Tạo một đối tượng mới dựa trên đối tượng hiện tại.
  // Chỉ những giá trị được truyền vào mới bị thay đổi.
  TeachingAssignment copyWith({
    String? id,
    String? className,
    String? subjectName,
    String? teacherName,
    String? schoolYear,
    int? semester,
  }) {
    return TeachingAssignment(
      id: id ?? this.id,
      className: className ?? this.className,
      subjectName: subjectName ?? this.subjectName,
      teacherName: teacherName ?? this.teacherName,
      schoolYear: schoolYear ?? this.schoolYear,
      semester: semester ?? this.semester,
    );
  }

  // Chuyển đối tượng Dart thành Map.
  // Sau này có thể dùng Map này để chuyển thành JSON gửi sang Java Web.
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "className": className,
      "subjectName": subjectName,
      "teacherName": teacherName,
      "schoolYear": schoolYear,
      "semester": semester,
    };
  }

  // Chuyển dữ liệu JSON từ Java Web thành đối tượng Dart.
  factory TeachingAssignment.fromJson(
      Map<String, dynamic> json,
      ) {
    return TeachingAssignment(
      id: json["id"].toString(),
      className: json["className"].toString(),
      subjectName: json["subjectName"].toString(),
      teacherName: json["teacherName"].toString(),
      schoolYear: json["schoolYear"].toString(),
      semester: int.parse(
        json["semester"].toString(),
      ),
    );
  }
}