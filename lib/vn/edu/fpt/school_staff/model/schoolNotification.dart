class SchoolNotification {
  final String id;
  final String title;
  final String content;

  // Toàn trường, Toàn giáo viên, Toàn phụ huynh,
  // Theo khối hoặc Theo lớp
  final String receiverType;

  // Ví dụ: Khối 12 hoặc 12A1.
  // Nếu gửi toàn trường thì có thể để trống.
  final String receiverName;

  // Nháp, Đã gửi hoặc Đã lên lịch
  final String status;

  final DateTime createdDate;
  final DateTime? scheduledDate;

  SchoolNotification({
    required this.id,
    required this.title,
    required this.content,
    required this.receiverType,
    required this.receiverName,
    required this.status,
    required this.createdDate,
    this.scheduledDate,
  });

  SchoolNotification copyWith({
    String? id,
    String? title,
    String? content,
    String? receiverType,
    String? receiverName,
    String? status,
    DateTime? createdDate,
    DateTime? scheduledDate,
  }) {
    return SchoolNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      receiverType: receiverType ?? this.receiverType,
      receiverName: receiverName ?? this.receiverName,
      status: status ?? this.status,
      createdDate: createdDate ?? this.createdDate,
      scheduledDate: scheduledDate ?? this.scheduledDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "content": content,
      "receiverType": receiverType,
      "receiverName": receiverName,
      "status": status,
      "createdDate": createdDate.toIso8601String(),
      "scheduledDate": scheduledDate?.toIso8601String(),
    };
  }

  factory SchoolNotification.fromJson(
      Map<String, dynamic> json,
      ) {
    return SchoolNotification(
      id: json["id"].toString(),
      title: json["title"].toString(),
      content: json["content"].toString(),
      receiverType: json["receiverType"].toString(),
      receiverName: json["receiverName"]?.toString() ?? "",
      status: json["status"].toString(),
      createdDate: DateTime.parse(
        json["createdDate"].toString(),
      ),
      scheduledDate: json["scheduledDate"] == null
          ? null
          : DateTime.parse(
        json["scheduledDate"].toString(),
      ),
    );
  }
}