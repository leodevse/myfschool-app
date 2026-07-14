import 'package:flutter/foundation.dart';

import '../model/fee.dart';
import '../service/feeSerivce.dart';


class FeeController extends ChangeNotifier {
  final FeeService service;

  FeeController({
    required this.service,
  });

  bool isLoading = false;
  bool isProcessing = false;
  String? errorMessage;

  String selectedStatus = "Tất cả";
  String searchText = "";

  List<SchoolFee> fees = [];

  final List<String> statuses = [
    "Tất cả",
    "Đang thu",
    "Đã đóng",
    "Quá hạn",
  ];

  List<SchoolFee> get filteredFees {
    final String keyword = searchText.toLowerCase();

    return fees.where((fee) {
      final bool matchesStatus =
          selectedStatus == "Tất cả" ||
              fee.status == selectedStatus;

      final bool matchesSearch =
          fee.title.toLowerCase().contains(keyword) ||
              fee.targetName.toLowerCase().contains(keyword);

      return matchesStatus && matchesSearch;
    }).toList();
  }

  double get totalExpectedAmount {
    double total = 0;

    for (final fee in fees) {
      total += fee.amount * fee.totalStudents;
    }

    return total;
  }

  double get totalCollectedAmount {
    double total = 0;

    for (final fee in fees) {
      total += fee.amount * fee.paidStudents;
    }

    return total;
  }

  Future<void> loadFees() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      fees = await service.getFees();
    } catch (error) {
      errorMessage = "Không thể tải danh sách khoản thu";
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

  Future<bool> addFee(SchoolFee fee) async {
    isProcessing = true;
    errorMessage = null;
    notifyListeners();

    try {
      await service.addFee(fee);
      await loadFees();

      return true;
    } catch (error) {
      errorMessage = "Không thể thêm khoản thu";
      return false;
    } finally {
      isProcessing = false;
      notifyListeners();
    }
  }

  Future<bool> updateFee(SchoolFee fee) async {
    isProcessing = true;
    errorMessage = null;
    notifyListeners();

    try {
      await service.updateFee(fee);
      await loadFees();

      return true;
    } catch (error) {
      errorMessage = "Không thể cập nhật khoản thu";
      return false;
    } finally {
      isProcessing = false;
      notifyListeners();
    }
  }

  Future<bool> closeFee(SchoolFee fee) async {
    isProcessing = true;
    notifyListeners();

    try {
      await service.closeFee(fee.id);
      await loadFees();

      return true;
    } catch (error) {
      errorMessage = "Không thể đóng khoản thu";
      return false;
    } finally {
      isProcessing = false;
      notifyListeners();
    }
  }

  Future<void> deleteFee(SchoolFee fee) async {
    await service.deleteFee(fee.id);
    await loadFees();
  }
}