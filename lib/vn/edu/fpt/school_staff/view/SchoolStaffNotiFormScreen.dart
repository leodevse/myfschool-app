import 'package:flutter/material.dart';

import '../model/schoolNotification.dart';


class StaffSchoolNotificationFormScreen
    extends StatefulWidget {
  final SchoolNotification? notification;

  const StaffSchoolNotificationFormScreen({
    super.key,
    this.notification,
  });

  @override
  State<StaffSchoolNotificationFormScreen>
  createState() =>
      _StaffSchoolNotificationFormScreenState();
}

class _StaffSchoolNotificationFormScreenState
    extends State<StaffSchoolNotificationFormScreen> {
  final TextEditingController titleController =
  TextEditingController();

  final TextEditingController contentController =
  TextEditingController();

  String selectedReceiverType = "Toàn trường";
  String selectedReceiverName = "";
  String selectedStatus = "Nháp";

  DateTime? scheduledDate;

  final List<String> receiverTypes = [
    "Toàn trường",
    "Toàn giáo viên",
    "Toàn phụ huynh",
    "Theo khối",
    "Theo lớp",
  ];

  final List<String> grades = [
    "Khối 10",
    "Khối 11",
    "Khối 12",
  ];

  final List<String> classes = [
    "10A1",
    "10A2",
    "11A1",
    "11A2",
    "12A1",
    "12A2",
  ];

  bool get isEditing =>
      widget.notification != null;

  bool get requiresReceiverName {
    return selectedReceiverType == "Theo khối" ||
        selectedReceiverType == "Theo lớp";
  }

  List<String> get receiverNames {
    if (selectedReceiverType == "Theo khối") {
      return grades;
    }

    if (selectedReceiverType == "Theo lớp") {
      return classes;
    }

    return [];
  }

  @override
  void initState() {
    super.initState();

    if (widget.notification != null) {
      final SchoolNotification notification =
      widget.notification!;

      titleController.text = notification.title;
      contentController.text = notification.content;

      selectedReceiverType =
          notification.receiverType;

      selectedReceiverName =
          notification.receiverName;

      selectedStatus = notification.status;

      scheduledDate = notification.scheduledDate;
    }
  }

  String formatDateTime(DateTime value) {
    final String day =
    value.day.toString().padLeft(2, "0");

    final String month =
    value.month.toString().padLeft(2, "0");

    final String hour =
    value.hour.toString().padLeft(2, "0");

    final String minute =
    value.minute.toString().padLeft(2, "0");

    return "$day/$month/${value.year} "
        "$hour:$minute";
  }

  Future<void> selectScheduleDate() async {
    final DateTime now = DateTime.now();

    final DateTime initialDate =
        scheduledDate ?? now;

    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: initialDate.isBefore(now)
          ? now
          : initialDate,
      firstDate: DateTime(
        now.year,
        now.month,
        now.day,
      ),
      lastDate: DateTime(2040),
    );

    if (date == null || !mounted) {
      return;
    }

    final TimeOfDay? time =
    await showTimePicker(
      context: context,
      initialTime: scheduledDate == null
          ? TimeOfDay.now()
          : TimeOfDay.fromDateTime(
        scheduledDate!,
      ),
    );

    if (time == null) {
      return;
    }

    setState(() {
      scheduledDate = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );

      selectedStatus = "Đã lên lịch";
    });
  }

  SchoolNotification? createNotification(
      String status,
      ) {
    final String title =
    titleController.text.trim();

    final String content =
    contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Vui lòng nhập tiêu đề và nội dung",
          ),
        ),
      );

      return null;
    }

    if (requiresReceiverName &&
        selectedReceiverName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Vui lòng chọn khối hoặc lớp nhận thông báo",
          ),
        ),
      );

      return null;
    }

    if (status == "Đã lên lịch" &&
        scheduledDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Vui lòng chọn thời gian gửi",
          ),
        ),
      );

      return null;
    }

    return SchoolNotification(
      id: widget.notification?.id ??
          "TB${DateTime.now().millisecondsSinceEpoch}",
      title: title,
      content: content,
      receiverType: selectedReceiverType,
      receiverName:
      requiresReceiverName
          ? selectedReceiverName
          : "",
      status: status,
      createdDate:
      widget.notification?.createdDate ??
          DateTime.now(),
      scheduledDate: status == "Đã lên lịch"
          ? scheduledDate
          : null,
    );
  }

  void saveNotification(String status) {
    final SchoolNotification? result =
    createNotification(status);

    if (result == null) {
      return;
    }

    Navigator.pop(context, result);
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text(
          isEditing
              ? "Sửa thông báo"
              : "Thêm thông báo",
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF18324F),
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),

        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Tiêu đề *",
                prefixIcon: Icon(Icons.title),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              initialValue: selectedReceiverType,
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: "Đối tượng nhận",
                prefixIcon: Icon(Icons.groups),
                border: OutlineInputBorder(),
              ),
              items: receiverTypes.map((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                if (value == null) {
                  return;
                }

                setState(() {
                  selectedReceiverType = value;

                  if (requiresReceiverName) {
                    selectedReceiverName =
                        receiverNames.first;
                  } else {
                    selectedReceiverName = "";
                  }
                });
              },
            ),

            if (requiresReceiverName) ...[
              const SizedBox(height: 15),

              DropdownButtonFormField<String>(
                key: ValueKey(
                  selectedReceiverType,
                ),
                initialValue:
                selectedReceiverName.isEmpty
                    ? receiverNames.first
                    : selectedReceiverName,
                isExpanded: true,
                decoration: InputDecoration(
                  labelText:
                  selectedReceiverType == "Theo khối"
                      ? "Chọn khối"
                      : "Chọn lớp",
                  prefixIcon:
                  const Icon(Icons.school),
                  border:
                  const OutlineInputBorder(),
                ),
                items: receiverNames.map((name) {
                  return DropdownMenuItem<String>(
                    value: name,
                    child: Text(name),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedReceiverName = value;
                    });
                  }
                },
              ),
            ],

            const SizedBox(height: 15),

            TextField(
              controller: contentController,
              maxLines: 8,
              decoration: const InputDecoration(
                labelText: "Nội dung thông báo *",
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            InkWell(
              onTap: selectScheduleDate,
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: "Lên lịch gửi",
                  prefixIcon:
                  Icon(Icons.schedule),
                  suffixIcon:
                  Icon(Icons.arrow_drop_down),
                  border: OutlineInputBorder(),
                ),
                child: Text(
                  scheduledDate == null
                      ? "Chưa chọn thời gian"
                      : formatDateTime(
                    scheduledDate!,
                  ),
                ),
              ),
            ),

            if (scheduledDate != null)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      scheduledDate = null;
                      selectedStatus = "Nháp";
                    });
                  },
                  icon: const Icon(Icons.clear),
                  label: const Text(
                    "Bỏ lịch gửi",
                  ),
                ),
              ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      saveNotification("Nháp");
                    },
                    icon: const Icon(Icons.save),
                    label: const Text("Lưu nháp"),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (scheduledDate != null) {
                        saveNotification(
                          "Đã lên lịch",
                        );
                      } else {
                        saveNotification("Đã gửi");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      Colors.deepOrange,
                      foregroundColor: Colors.white,
                    ),
                    icon: Icon(
                      scheduledDate == null
                          ? Icons.send
                          : Icons.schedule_send,
                    ),
                    label: Text(
                      scheduledDate == null
                          ? "Gửi ngay"
                          : "Lên lịch",
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
}