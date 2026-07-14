import 'package:flutter/material.dart';

import '../controller/SchoolNotificationController.dart';
import '../model/schoolNotification.dart';
import '../service/SchoolNotificationService.dart';
import 'SchoolStaffNotiFormScreen.dart';



class StaffSchoolNotificationScreen
    extends StatefulWidget {
  const StaffSchoolNotificationScreen({
    super.key,
  });

  @override
  State<StaffSchoolNotificationScreen>
  createState() =>
      _StaffSchoolNotificationScreenState();
}

class _StaffSchoolNotificationScreenState
    extends State<StaffSchoolNotificationScreen> {
  late final SchoolNotificationController controller;

  @override
  void initState() {
    super.initState();

    controller = SchoolNotificationController(
      service: SchoolNotificationService(),
    );

    controller.loadNotifications();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  String formatDate(DateTime value) {
    final String day =
    value.day.toString().padLeft(2, "0");

    final String month =
    value.month.toString().padLeft(2, "0");

    return "$day/$month/${value.year}";
  }

  String formatDateTime(DateTime value) {
    final String hour =
    value.hour.toString().padLeft(2, "0");

    final String minute =
    value.minute.toString().padLeft(2, "0");

    return "${formatDate(value)} $hour:$minute";
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Đã gửi":
        return Colors.green;

      case "Đã lên lịch":
        return Colors.blue;

      case "Nháp":
        return Colors.orange;

      default:
        return Colors.grey;
    }
  }

  String getReceiverText(
      SchoolNotification notification,
      ) {
    if (notification.receiverName.isEmpty) {
      return notification.receiverType;
    }

    return "${notification.receiverType}: "
        "${notification.receiverName}";
  }

  Future<void> openAddScreen() async {
    final SchoolNotification? result =
    await Navigator.push<SchoolNotification>(
      context,
      MaterialPageRoute(
        builder: (context) =>
        const StaffSchoolNotificationFormScreen(),
      ),
    );

    if (result == null) {
      return;
    }

    final bool success =
    await controller.addNotification(result);

    if (!mounted) {
      return;
    }

    showMessage(
      success
          ? result.status == "Đã gửi"
          ? "Đã gửi thông báo"
          : result.status == "Đã lên lịch"
          ? "Đã lên lịch thông báo"
          : "Đã lưu nháp"
          : controller.errorMessage ??
          "Không thể thêm thông báo",
    );
  }

  Future<void> openEditScreen(
      SchoolNotification notification,
      ) async {
    if (notification.status == "Đã gửi") {
      showMessage(
        "Thông báo đã gửi không thể chỉnh sửa",
      );
      return;
    }

    final SchoolNotification? result =
    await Navigator.push<SchoolNotification>(
      context,
      MaterialPageRoute(
        builder: (context) =>
            StaffSchoolNotificationFormScreen(
              notification: notification,
            ),
      ),
    );

    if (result == null) {
      return;
    }

    final bool success =
    await controller.updateNotification(
      result,
    );

    if (!mounted) {
      return;
    }

    showMessage(
      success
          ? "Đã cập nhật thông báo"
          : controller.errorMessage ??
          "Không thể cập nhật",
    );
  }

  Future<void> sendDraft(
      SchoolNotification notification,
      ) async {
    final bool success =
    await controller.sendNotification(
      notification,
    );

    if (!mounted) {
      return;
    }

    showMessage(
      success
          ? "Đã gửi thông báo"
          : controller.errorMessage ??
          "Không thể gửi thông báo",
    );
  }

  void confirmDelete(
      SchoolNotification notification,
      ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Xóa thông báo"),
          content: Text(
            "Bạn có chắc muốn xóa thông báo "
                "\"${notification.title}\" không?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text("Hủy"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                Navigator.pop(dialogContext);

                await controller.deleteNotification(
                  notification,
                );

                if (!mounted) {
                  return;
                }

                showMessage(
                  "Đã xóa thông báo",
                );
              },
              child: const Text("Xóa"),
            ),
          ],
        );
      },
    );
  }

  void openDetail(
      SchoolNotification notification,
      ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (bottomSheetContext) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 45,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  notification.title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                buildDetailRow(
                  "Đối tượng",
                  getReceiverText(notification),
                ),

                buildDetailRow(
                  "Trạng thái",
                  notification.status,
                ),

                buildDetailRow(
                  "Ngày tạo",
                  formatDate(
                    notification.createdDate,
                  ),
                ),

                if (notification.scheduledDate != null)
                  buildDetailRow(
                    "Thời gian gửi",
                    formatDateTime(
                      notification.scheduledDate!,
                    ),
                  ),

                const Divider(height: 25),

                const Text(
                  "Nội dung",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  notification.content,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildDetailRow(
      String label,
      String value,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 115,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Widget buildNotificationCard(
      SchoolNotification notification,
      ) {
    final Color statusColor =
    getStatusColor(notification.status);

    return Card(
      margin: const EdgeInsets.only(bottom: 13),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),

      child: Padding(
        padding: const EdgeInsets.all(14),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor:
                  statusColor.withAlpha(25),
                  child: Icon(
                    Icons.campaign,
                    color: statusColor,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        getReceiverText(
                          notification,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        "Ngày tạo: "
                            "${formatDate(notification.createdDate)}",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),

                PopupMenuButton<String>(
                  onSelected: (value) {
                    switch (value) {
                      case "view":
                        openDetail(notification);
                        break;

                      case "edit":
                        openEditScreen(notification);
                        break;

                      case "send":
                        sendDraft(notification);
                        break;

                      case "delete":
                        confirmDelete(notification);
                        break;
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        value: "view",
                        child: Text("Xem chi tiết"),
                      ),

                      if (notification.status != "Đã gửi")
                        const PopupMenuItem(
                          value: "edit",
                          child: Text("Sửa"),
                        ),

                      if (notification.status == "Nháp")
                        const PopupMenuItem(
                          value: "send",
                          child: Text("Gửi ngay"),
                        ),

                      const PopupMenuItem(
                        value: "delete",
                        child: Text(
                          "Xóa",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ];
                  },
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha(25),
                    borderRadius:
                    BorderRadius.circular(20),
                  ),
                  child: Text(
                    notification.status,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                if (notification.scheduledDate != null)
                  Flexible(
                    child: Text(
                      formatDateTime(
                        notification.scheduledDate!,
                      ),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 13,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      appBar: AppBar(
        title: const Text(
          "Thông báo toàn trường",
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF18324F),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: openAddScreen,
            icon: const Icon(Icons.add),
          ),
        ],
      ),

      body: ListenableBuilder(
        listenable: controller,
        builder: (context, child) {
          if (controller.isLoading &&
              controller.notifications.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(15),

                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child:
                      DropdownButtonFormField<String>(
                        initialValue:
                        controller.selectedStatus,
                        isExpanded: true,
                        decoration:
                        const InputDecoration(
                          labelText: "Trạng thái",
                          border: OutlineInputBorder(),
                        ),
                        items: controller.statuses
                            .map((status) {
                          return DropdownMenuItem<String>(
                            value: status,
                            child: Text(
                              status,
                              overflow:
                              TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            controller
                                .changeStatus(value);
                          }
                        },
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      flex: 2,
                      child: TextField(
                        decoration:
                        const InputDecoration(
                          labelText:
                          "Tìm thông báo hoặc đối tượng",
                          prefixIcon:
                          Icon(Icons.search),
                          border:
                          OutlineInputBorder(),
                        ),
                        onChanged:
                        controller.changeSearchText,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(
                  15,
                  15,
                  15,
                  10,
                ),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Danh sách thông báo",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      "${controller.filteredNotifications.length} thông báo",
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: controller
                    .filteredNotifications.isEmpty
                    ? const Center(
                  child: Text(
                    "Không tìm thấy thông báo",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                )
                    : ListView.builder(
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  itemCount: controller
                      .filteredNotifications.length,
                  itemBuilder: (context, index) {
                    return buildNotificationCard(
                      controller
                          .filteredNotifications[
                      index],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: openAddScreen,
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}