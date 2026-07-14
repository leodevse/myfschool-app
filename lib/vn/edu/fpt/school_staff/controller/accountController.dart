import 'package:flutter/foundation.dart';

import '../model/userAccount.dart';
import '../service/accountService.dart';

class AccountController extends ChangeNotifier {
  final AccountService service;

  AccountController({
    required this.service,
  });

  bool isLoading = false;
  bool isProcessing = false;
  String? errorMessage;

  String selectedRole = "Tất cả";
  String selectedStatus = "Tất cả";
  String searchText = "";

  List<UserAccount> accounts = [];

  final List<String> roles = [
    "Tất cả",
    "Phụ huynh",
    "Giáo viên",
    "Cán bộ nhà trường",
    "Lãnh đạo nhà trường",
  ];

  final List<String> statuses = [
    "Tất cả",
    "Đang hoạt động",
    "Đã khóa",
  ];

  List<UserAccount> get filteredAccounts {
    final String keyword = searchText.toLowerCase();

    return accounts.where((account) {
      final bool matchesRole = selectedRole == "Tất cả" ||
          account.role == selectedRole;

      final bool matchesStatus = selectedStatus == "Tất cả" ||
          (selectedStatus == "Đang hoạt động" &&
              account.isActive) ||
          (selectedStatus == "Đã khóa" &&
              !account.isActive);

      final bool matchesSearch =
          account.fullName.toLowerCase().contains(keyword) ||
              account.username.toLowerCase().contains(keyword) ||
              account.email.toLowerCase().contains(keyword);

      return matchesRole &&
          matchesStatus &&
          matchesSearch;
    }).toList();
  }

  Future<void> loadAccounts() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      accounts = await service.getAccounts();
    } catch (error) {
      errorMessage = "Không thể tải danh sách tài khoản";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void changeRole(String value) {
    selectedRole = value;
    notifyListeners();
  }

  void changeStatus(String value) {
    selectedStatus = value;
    notifyListeners();
  }

  void changeSearchText(String value) {
    searchText = value.trim();
    notifyListeners();
  }

  Future<bool> addAccount(UserAccount account) async {
    isProcessing = true;
    errorMessage = null;
    notifyListeners();

    try {
      await service.addAccount(account);
      await loadAccounts();
      return true;
    } catch (error) {
      errorMessage = error.toString().replaceFirst(
        "Exception: ",
        "",
      );
      return false;
    } finally {
      isProcessing = false;
      notifyListeners();
    }
  }

  Future<bool> updateAccount(
      UserAccount account,
      ) async {
    isProcessing = true;
    errorMessage = null;
    notifyListeners();

    try {
      await service.updateAccount(account);
      await loadAccounts();
      return true;
    } catch (error) {
      errorMessage = error.toString().replaceFirst(
        "Exception: ",
        "",
      );
      return false;
    } finally {
      isProcessing = false;
      notifyListeners();
    }
  }

  Future<bool> changeAccountStatus(
      UserAccount account,
      ) async {
    isProcessing = true;
    errorMessage = null;
    notifyListeners();

    try {
      await service.changeAccountStatus(
        id: account.id,
        isActive: !account.isActive,
      );

      await loadAccounts();
      return true;
    } catch (error) {
      errorMessage = "Không thể cập nhật trạng thái";
      return false;
    } finally {
      isProcessing = false;
      notifyListeners();
    }
  }

  Future<bool> resetPassword({
    required String accountId,
    required String newPassword,
  }) async {
    isProcessing = true;
    errorMessage = null;
    notifyListeners();

    try {
      await service.resetPassword(
        accountId: accountId,
        newPassword: newPassword,
      );

      return true;
    } catch (error) {
      errorMessage = "Không thể đặt lại mật khẩu";
      return false;
    } finally {
      isProcessing = false;
      notifyListeners();
    }
  }

  Future<void> deleteAccount(
      UserAccount account,
      ) async {
    await service.deleteAccount(account.id);
    await loadAccounts();
  }
}