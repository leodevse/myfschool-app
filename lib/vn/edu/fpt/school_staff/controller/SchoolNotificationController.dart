import 'package:flutter/foundation.dart';

import '../model/schoolNotification.dart';
import '../service/SchoolNotificationService.dart';



class SchoolNotificationController extends ChangeNotifier {
  final SchoolNotificationService service;

  SchoolNotificationController({
    required this.service,
  });

  bool isLoading = false;
  bool isProcessing = false;

  String? errorMessage;

  String selectedStatus = "Tất cả";
  String searchText = "";

  List<SchoolNotification> notifications = [];

  final List<String> statuses = [
    "Tất cả",
    "Nháp",
    "Đã gửi",
    "Đã lên lịch",
  ];

  List<SchoolNotification> get filteredNotifications {
    final String keyword = searchText.toLowerCase();

    final List<SchoolNotification> result =
    notifications.where((notification) {
      final bool matchStatus =
          selectedStatus == "Tất cả" ||
              notification.status == selectedStatus;

      final bool matchSearch = notification.title
          .toLowerCase()
          .contains(keyword) ||
          notification.receiverType
              .toLowerCase()
              .contains(keyword) ||
          notification.receiverName
              .toLowerCase()
              .contains(keyword);

      return matchStatus && matchSearch;
    }).toList();

    result.sort(
          (a, b) => b.createdDate.compareTo(a.createdDate),
    );

    return result;
  }

  Future<void> loadNotifications() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      notifications =
      await service.getNotifications();
    } catch (error) {
      errorMessage =
      "Không thể tải danh sách thông báo";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void changeStatus(String value) {
    selectedStatus = value;
    notifyListeners();
  }

  void changeSearchText(String value) {
    searchText = value.trim();
    notifyListeners();
  }

  Future<bool> addNotification(
      SchoolNotification notification,
      ) async {
    isProcessing = true;
    errorMessage = null;
    notifyListeners();

    try {
      await service.addNotification(notification);
      await loadNotifications();

      return true;
    } catch (error) {
      errorMessage = "Không thể thêm thông báo";
      return false;
    } finally {
      isProcessing = false;
      notifyListeners();
    }
  }

  Future<bool> updateNotification(
      SchoolNotification notification,
      ) async {
    isProcessing = true;
    errorMessage = null;
    notifyListeners();

    try {
      await service.updateNotification(notification);
      await loadNotifications();

      return true;
    } catch (error) {
      errorMessage = "Không thể cập nhật thông báo";
      return false;
    } finally {
      isProcessing = false;
      notifyListeners();
    }
  }

  Future<bool> sendNotification(
      SchoolNotification notification,
      ) async {
    isProcessing = true;
    errorMessage = null;
    notifyListeners();

    try {
      await service.sendNotification(
        notification.id,
      );

      await loadNotifications();

      return true;
    } catch (error) {
      errorMessage = "Không thể gửi thông báo";
      return false;
    } finally {
      isProcessing = false;
      notifyListeners();
    }
  }

  Future<void> deleteNotification(
      SchoolNotification notification,
      ) async {
    await service.deleteNotification(
      notification.id,
    );

    await loadNotifications();
  }
}