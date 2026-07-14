import 'package:flutter/material.dart';


import '../controller/feeController.dart';
import '../model/fee.dart';
import '../service/feeSerivce.dart';
import 'SchoolStaffFeeFormScreen.dart';


class StaffFeeScreen extends StatefulWidget {
  const StaffFeeScreen({super.key});

  @override
  State<StaffFeeScreen> createState() =>
      _StaffFeeScreenState();
}

class _StaffFeeScreenState extends State<StaffFeeScreen> {
  late final FeeController controller;

  @override
  void initState() {
    super.initState();

    controller = FeeController(
      service: FeeService(),
    );

    controller.loadFees();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String formatMoney(double value) {
    final String text = value.toStringAsFixed(0);
    final StringBuffer result = StringBuffer();

    int count = 0;

    for (int index = text.length - 1;
    index >= 0;
    index--) {
      result.write(text[index]);
      count++;

      if (count == 3 && index != 0) {
        result.write(".");
        count = 0;
      }
    }

    return result.toString().split("").reversed.join();
  }

  String formatDate(DateTime date) {
    final String day =
    date.day.toString().padLeft(2, "0");

    final String month =
    date.month.toString().padLeft(2, "0");

    return "$day/$month/${date.year}";
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Đang thu":
        return Colors.orange;
      case "Đã đóng":
        return Colors.green;
      case "Quá hạn":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Future<void> openAddFeeScreen() async {
    final SchoolFee? fee =
    await Navigator.push<SchoolFee>(
      context,
      MaterialPageRoute(
        builder: (context) =>
        const StaffFeeFormScreen(),
      ),
    );

    if (fee == null) {
      return;
    }

    final bool success =
    await controller.addFee(fee);

    if (!mounted) {
      return;
    }

    showMessage(
      success
          ? "Đã tạo khoản thu"
          : controller.errorMessage ??
          "Không thể tạo khoản thu",
    );
  }

  Future<void> openEditFeeScreen(
      SchoolFee fee,
      ) async {
    final SchoolFee? updated =
    await Navigator.push<SchoolFee>(
      context,
      MaterialPageRoute(
        builder: (context) =>
            StaffFeeFormScreen(fee: fee),
      ),
    );

    if (updated == null) {
      return;
    }

    final bool success =
    await controller.updateFee(updated);

    if (!mounted) {
      return;
    }

    showMessage(
      success
          ? "Đã cập nhật khoản thu"
          : controller.errorMessage ??
          "Không thể cập nhật",
    );
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void confirmCloseFee(SchoolFee fee) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Đóng khoản thu"),
          content: Text(
            "Bạn có chắc muốn đóng khoản thu "
                "\"${fee.title}\" không?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text("Hủy"),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(dialogContext);

                final bool success =
                await controller.closeFee(fee);

                if (!mounted) {
                  return;
                }

                showMessage(
                  success
                      ? "Đã đóng khoản thu"
                      : "Không thể đóng khoản thu",
                );
              },
              child: const Text("Đóng"),
            ),
          ],
        );
      },
    );
  }

  void confirmDeleteFee(SchoolFee fee) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Xóa khoản thu"),
          content: Text(
            "Bạn có chắc muốn xóa khoản thu "
                "\"${fee.title}\" không?",
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

                await controller.deleteFee(fee);

                if (!mounted) {
                  return;
                }

                showMessage("Đã xóa khoản thu");
              },
              child: const Text("Xóa"),
            ),
          ],
        );
      },
    );
  }

  Widget buildSummaryCard(
      String title,
      String value,
      IconData icon,
      Color color,
      ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withAlpha(100),
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 6),
            Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFeeCard(SchoolFee fee) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),

      child: Padding(
        padding: const EdgeInsets.all(15),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor:
                  Colors.green.shade50,
                  child: const Icon(
                    Icons.payments,
                    color: Colors.green,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        fee.title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        "${formatMoney(fee.amount)} VNĐ",
                        style: const TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == "edit") {
                      openEditFeeScreen(fee);
                    }

                    if (value == "close") {
                      confirmCloseFee(fee);
                    }

                    if (value == "delete") {
                      confirmDeleteFee(fee);
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        value: "edit",
                        child: Text("Sửa"),
                      ),
                      if (fee.status != "Đã đóng")
                        const PopupMenuItem(
                          value: "close",
                          child: Text("Đóng khoản thu"),
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

            const Divider(height: 25),

            Text(
              "Đối tượng: ${fee.targetName}",
            ),

            const SizedBox(height: 5),

            Text(
              "Hạn thanh toán: ${formatDate(fee.dueDate)}",
            ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  fee.status,
                  style: TextStyle(
                    color: getStatusColor(fee.status),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${fee.paidStudents}/${fee.totalStudents} đã thanh toán",
                ),
              ],
            ),

            const SizedBox(height: 10),

            LinearProgressIndicator(
              value: fee.totalStudents == 0
                  ? 0
                  : fee.paidStudents /
                  fee.totalStudents,
              minHeight: 8,
              borderRadius:
              BorderRadius.circular(10),
            ),

            const SizedBox(height: 7),

            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "${fee.paymentRate.toStringAsFixed(0)}%",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
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
        title: const Text("Quản lý khoản thu"),
        centerTitle: true,
        backgroundColor: const Color(0xFF18324F),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: openAddFeeScreen,
            icon: const Icon(Icons.add),
          ),
        ],
      ),

      body: ListenableBuilder(
        listenable: controller,
        builder: (context, child) {
          if (controller.isLoading &&
              controller.fees.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(15),

                child: Column(
                  children: [
                    Row(
                      children: [
                        buildSummaryCard(
                          "Dự kiến thu",
                          "${formatMoney(controller.totalExpectedAmount)}đ",
                          Icons.account_balance_wallet,
                          Colors.blue,
                        ),

                        const SizedBox(width: 10),

                        buildSummaryCard(
                          "Đã thu",
                          "${formatMoney(controller.totalCollectedAmount)}đ",
                          Icons.check_circle,
                          Colors.green,
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    Row(
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
                              border:
                              OutlineInputBorder(),
                            ),
                            items: controller.statuses
                                .map((status) {
                              return DropdownMenuItem(
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
                              "Tìm khoản thu hoặc lớp",
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
                      "Danh sách khoản thu",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${controller.filteredFees.length} khoản",
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: controller.filteredFees.isEmpty
                    ? const Center(
                  child: Text(
                    "Không tìm thấy khoản thu",
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
                  itemCount:
                  controller.filteredFees.length,
                  itemBuilder: (context, index) {
                    return buildFeeCard(
                      controller
                          .filteredFees[index],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: openAddFeeScreen,
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}