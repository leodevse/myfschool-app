class SchoolFee {
  final String id;
  final String title;
  final String description;
  final double amount;
  final String targetType;
  final String targetName;
  final DateTime dueDate;
  final String status;
  final int totalStudents;
  final int paidStudents;

  SchoolFee({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.targetType,
    required this.targetName,
    required this.dueDate,
    required this.status,
    required this.totalStudents,
    required this.paidStudents,
  });

  int get unpaidStudents {
    return totalStudents - paidStudents;
  }

  double get paymentRate {
    if (totalStudents == 0) {
      return 0;
    }

    return paidStudents / totalStudents * 100;
  }

  SchoolFee copyWith({
    String? id,
    String? title,
    String? description,
    double? amount,
    String? targetType,
    String? targetName,
    DateTime? dueDate,
    String? status,
    int? totalStudents,
    int? paidStudents,
  }) {
    return SchoolFee(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      targetType: targetType ?? this.targetType,
      targetName: targetName ?? this.targetName,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
      totalStudents: totalStudents ?? this.totalStudents,
      paidStudents: paidStudents ?? this.paidStudents,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "amount": amount,
      "targetType": targetType,
      "targetName": targetName,
      "dueDate": dueDate.toIso8601String(),
      "status": status,
      "totalStudents": totalStudents,
      "paidStudents": paidStudents,
    };
  }

  factory SchoolFee.fromJson(Map<String, dynamic> json) {
    return SchoolFee(
      id: json["id"].toString(),
      title: json["title"].toString(),
      description: json["description"].toString(),
      amount: double.parse(json["amount"].toString()),
      targetType: json["targetType"].toString(),
      targetName: json["targetName"].toString(),
      dueDate: DateTime.parse(json["dueDate"].toString()),
      status: json["status"].toString(),
      totalStudents: int.parse(
        json["totalStudents"].toString(),
      ),
      paidStudents: int.parse(
        json["paidStudents"].toString(),
      ),
    );
  }
}