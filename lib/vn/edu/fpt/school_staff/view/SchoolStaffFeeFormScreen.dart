import 'package:flutter/material.dart';

import '../model/fee.dart';

class StaffFeeFormScreen extends StatefulWidget {
  final SchoolFee? fee;

  const StaffFeeFormScreen({
    super.key,
    this.fee,
  });

  @override
  State<StaffFeeFormScreen> createState() =>
      _StaffFeeFormScreenState();
}

class _StaffFeeFormScreenState
    extends State<StaffFeeFormScreen> {
  final TextEditingController titleController =
  TextEditingController();

  final TextEditingController descriptionController =
  TextEditingController();

  final TextEditingController amountController =
  TextEditingController();

  final TextEditingController totalStudentsController =
  TextEditingController();

  String selectedTargetType = "Theo lớp";
  String selectedTargetName = "12A1";
  String selectedStatus = "Đang thu";

  DateTime selectedDueDate = DateTime.now().add(
    const Duration(days: 30),
  );

  final List<String> targetTypes = [
    "Toàn trường",
    "Theo khối",
    "Theo lớp",
  ];

  final List<String> statuses = [
    "Đang thu",
    "Đã đóng",
    "Quá hạn",
  ];

  final List<String> classes = [
    "10A1",
    "10A2",
    "11A1",
    "11A2",
    "12A1",
    "12A2",
  ];

  final List<String> grades = [
    "Khối 10",
    "Khối 11",
    "Khối 12",
  ];

  bool get isEditing => widget.fee != null;

  List<String> get targetNames {
    if (selectedTargetType == "Toàn trường") {
      return ["Toàn trường"];
    }

    if (selectedTargetType == "Theo khối") {
      return grades;
    }

    return classes;
  }

  @override
  void initState() {
    super.initState();

    if (widget.fee != null) {
      final SchoolFee fee = widget.fee!;

      titleController.text = fee.title;
      descriptionController.text = fee.description;
      amountController.text = fee.amount.toStringAsFixed(0);
      totalStudentsController.text =
          fee.totalStudents.toString();

      selectedTargetType = fee.targetType;
      selectedTargetName = fee.targetName;
      selectedStatus = fee.status;
      selectedDueDate = fee.dueDate;
    }
  }

  String formatDate(DateTime date) {
    final String day =
    date.day.toString().padLeft(2, "0");

    final String month =
    date.month.toString().padLeft(2, "0");

    return "$day/$month/${date.year}";
  }

  Future<void> selectDueDate() async {
    final DateTime? result = await showDatePicker(
      context: context,
      initialDate: selectedDueDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2040),
    );

    if (result != null) {
      setState(() {
        selectedDueDate = result;
      });
    }
  }

  void saveFee() {
    final String title = titleController.text.trim();
    final String description =
    descriptionController.text.trim();

    final double? amount = double.tryParse(
      amountController.text.trim(),
    );

    final int? totalStudents = int.tryParse(
      totalStudentsController.text.trim(),
    );

    if (title.isEmpty ||
        description.isEmpty ||
        amount == null ||
        totalStudents == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Vui lòng nhập đầy đủ thông tin hợp lệ",
          ),
        ),
      );
      return;
    }

    if (amount <= 0 || totalStudents <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Số tiền và số học sinh phải lớn hơn 0",
          ),
        ),
      );
      return;
    }

    final SchoolFee result = SchoolFee(
      id: widget.fee?.id ??
          "KT${DateTime.now().millisecondsSinceEpoch}",
      title: title,
      description: description,
      amount: amount,
      targetType: selectedTargetType,
      targetName: selectedTargetName,
      dueDate: selectedDueDate,
      status: selectedStatus,
      totalStudents: totalStudents,
      paidStudents: widget.fee?.paidStudents ?? 0,
    );

    Navigator.pop(context, result);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    amountController.dispose();
    totalStudentsController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text(
          isEditing
              ? "Sửa khoản thu"
              : "Thêm khoản thu",
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
                labelText: "Tên khoản thu *",
                prefixIcon: Icon(Icons.payments),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: "Mô tả *",
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Số tiền *",
                prefixIcon: Icon(Icons.attach_money),
                suffixText: "VNĐ",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              initialValue: selectedTargetType,
              decoration: const InputDecoration(
                labelText: "Đối tượng áp dụng",
                prefixIcon: Icon(Icons.groups),
                border: OutlineInputBorder(),
              ),
              items: targetTypes.map((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedTargetType = value;
                    selectedTargetName =
                        targetNames.first;
                  });
                }
              },
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              key: ValueKey(selectedTargetType),
              initialValue: selectedTargetName,
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: "Phạm vi áp dụng",
                prefixIcon: Icon(Icons.school),
                border: OutlineInputBorder(),
              ),
              items: targetNames.map((name) {
                return DropdownMenuItem<String>(
                  value: name,
                  child: Text(name),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedTargetName = value;
                  });
                }
              },
            ),

            const SizedBox(height: 15),

            TextField(
              controller: totalStudentsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Số học sinh áp dụng *",
                prefixIcon: Icon(Icons.people),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            InkWell(
              onTap: selectDueDate,
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: "Hạn thanh toán",
                  prefixIcon:
                  Icon(Icons.calendar_month),
                  suffixIcon:
                  Icon(Icons.arrow_drop_down),
                  border: OutlineInputBorder(),
                ),
                child: Text(
                  formatDate(selectedDueDate),
                ),
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              initialValue: selectedStatus,
              decoration: const InputDecoration(
                labelText: "Trạng thái",
                prefixIcon: Icon(Icons.info),
                border: OutlineInputBorder(),
              ),
              items: statuses.map((status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedStatus = value;
                  });
                }
              },
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: saveFee,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.save),
                label: Text(
                  isEditing
                      ? "Lưu thay đổi"
                      : "Tạo khoản thu",
                  style: const TextStyle(fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}