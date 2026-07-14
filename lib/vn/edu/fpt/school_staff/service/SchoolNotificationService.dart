
import '../model/schoolNotification.dart';

class SchoolNotificationService {
  final List<SchoolNotification> _notifications = [
    SchoolNotification(
      id: "TB001",
      title: "Thông báo nghỉ học do thời tiết",
      content:
      "Do ảnh hưởng của thời tiết xấu, toàn trường nghỉ học ngày 15/07/2026.",
      receiverType: "Toàn trường",
      receiverName: "",
      status: "Đã gửi",
      createdDate: DateTime(2026, 7, 14),
    ),
    SchoolNotification(
      id: "TB002",
      title: "Thông báo họp giáo viên",
      content:
      "Toàn bộ giáo viên tham gia họp chuyên môn lúc 14 giờ tại hội trường.",
      receiverType: "Toàn giáo viên",
      receiverName: "",
      status: "Nháp",
      createdDate: DateTime(2026, 7, 13),
    ),
    SchoolNotification(
      id: "TB003",
      title: "Thông báo họp phụ huynh lớp 12A1",
      content:
      "Nhà trường tổ chức họp phụ huynh lớp 12A1 vào sáng Chủ nhật.",
      receiverType: "Theo lớp",
      receiverName: "12A1",
      status: "Đã lên lịch",
      createdDate: DateTime(2026, 7, 12),
      scheduledDate: DateTime(2026, 7, 18, 8, 0),
    ),
  ];

  Future<List<SchoolNotification>> getNotifications() async {
    await Future.delayed(
      const Duration(milliseconds: 400),
    );

    return List<SchoolNotification>.from(
      _notifications,
    );
  }

  Future<void> addNotification(
      SchoolNotification notification,
      ) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
    );

    _notifications.add(notification);
  }

  Future<void> updateNotification(
      SchoolNotification notification,
      ) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
    );

    final int index = _notifications.indexWhere(
          (item) => item.id == notification.id,
    );

    if (index < 0) {
      throw Exception("Không tìm thấy thông báo");
    }

    _notifications[index] = notification;
  }

  Future<void> deleteNotification(
      String id,
      ) async {
    await Future.delayed(
      const Duration(milliseconds: 250),
    );

    _notifications.removeWhere(
          (item) => item.id == id,
    );
  }

  Future<void> sendNotification(
      String id,
      ) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
    );

    final int index = _notifications.indexWhere(
          (item) => item.id == id,
    );

    if (index < 0) {
      throw Exception("Không tìm thấy thông báo");
    }

    _notifications[index] =
        _notifications[index].copyWith(
          status: "Đã gửi",
        );
  }
}