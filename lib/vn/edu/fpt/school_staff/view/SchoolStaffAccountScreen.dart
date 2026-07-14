import 'package:flutter/material.dart';

import '../controller/accountController.dart';
import '../model/userAccount.dart';
import '../service/accountService.dart';
import 'SchoolStaffAccountFormScreen.dart';

class StaffAccountScreen extends StatefulWidget {
  const StaffAccountScreen({super.key});

  @override
  State<StaffAccountScreen> createState() =>
      _StaffAccountScreenState();
}

class _StaffAccountScreenState
    extends State<StaffAccountScreen> {
  late final AccountController controller;

  @override
  void initState() {
    super.initState();

    controller = AccountController(
      service: AccountService(),
    );

    controller.loadAccounts();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> openAddAccountScreen() async {
    final UserAccount? account =
    await Navigator.push<UserAccount>(
      context,
      MaterialPageRoute(
        builder: (context) =>
        const StaffAccountFormScreen(),
      ),
    );

    if (account == null) {
      return;
    }

    final bool success =
    await controller.addAccount(account);

    if (!mounted) {
      return;
    }

    showResultMessage(
      success
          ? "Đã thêm tài khoản"
          : controller.errorMessage ??
          "Không thể thêm tài khoản",
    );
  }

  Future<void> openEditAccountScreen(
      UserAccount account,
      ) async {
    final UserAccount? updated =
    await Navigator.push<UserAccount>(
      context,
      MaterialPageRoute(
        builder: (context) =>
            StaffAccountFormScreen(
              account: account,
            ),
      ),
    );

    if (updated == null) {
      return;
    }

    final bool success =
    await controller.updateAccount(updated);

    if (!mounted) {
      return;
    }

    showResultMessage(
      success
          ? "Đã cập nhật tài khoản"
          : controller.errorMessage ??
          "Không thể cập nhật",
    );
  }

  void showResultMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void confirmChangeStatus(UserAccount account) {
    final String action =
    account.isActive ? "khóa" : "mở khóa";

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            account.isActive
                ? "Khóa tài khoản"
                : "Mở khóa tài khoản",
          ),
          content: Text(
            "Bạn có chắc muốn $action tài khoản "
                "${account.username} không?",
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
                await controller
                    .changeAccountStatus(account);

                if (!mounted) {
                  return;
                }

                showResultMessage(
                  success
                      ? "Đã $action tài khoản"
                      : controller.errorMessage ??
                      "Không thể cập nhật",
                );
              },
              child: Text(
                account.isActive ? "Khóa" : "Mở khóa",
              ),
            ),
          ],
        );
      },
    );
  }

  void openResetPasswordDialog(
      UserAccount account,
      ) {
    final TextEditingController passwordController =
    TextEditingController();

    bool obscurePassword = true;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text("Đặt lại mật khẩu"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tài khoản: ${account.username}",
                  ),

                  const SizedBox(height: 15),

                  TextField(
                    controller: passwordController,
                    obscureText: obscurePassword,
                    decoration: InputDecoration(
                      labelText: "Mật khẩu mới",
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setDialogState(() {
                            obscurePassword =
                            !obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                ],
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
                    final String password =
                    passwordController.text.trim();

                    if (password.length < 6) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Mật khẩu phải có ít nhất 6 ký tự",
                          ),
                        ),
                      );
                      return;
                    }

                    Navigator.pop(dialogContext);

                    final bool success =
                    await controller.resetPassword(
                      accountId: account.id,
                      newPassword: password,
                    );

                    if (!mounted) {
                      return;
                    }

                    showResultMessage(
                      success
                          ? "Đã đặt lại mật khẩu"
                          : controller.errorMessage ??
                          "Không thể đặt lại mật khẩu",
                    );
                  },
                  child: const Text("Xác nhận"),
                ),
              ],
            );
          },
        );
      },
    ).then((_) {
      passwordController.dispose();
    });
  }

  void confirmDelete(UserAccount account) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Xóa tài khoản"),
          content: Text(
            "Bạn có chắc muốn xóa tài khoản "
                "${account.username} không?",
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

                await controller.deleteAccount(account);

                if (!mounted) {
                  return;
                }

                showResultMessage(
                  "Đã xóa tài khoản",
                );
              },
              child: const Text("Xóa"),
            ),
          ],
        );
      },
    );
  }

  void openAccountDetail(UserAccount account) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (bottomSheetContext) {
        return SafeArea(
          child: Padding(
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
                  account.fullName,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Divider(),

                buildDetailRow(
                  "Mã tài khoản",
                  account.id,
                ),

                buildDetailRow(
                  "Tên đăng nhập",
                  account.username,
                ),

                buildDetailRow(
                  "Email",
                  account.email,
                ),

                buildDetailRow(
                  "Điện thoại",
                  account.phone,
                ),

                buildDetailRow(
                  "Vai trò",
                  account.role,
                ),

                buildDetailRow(
                  "Trạng thái",
                  account.isActive
                      ? "Đang hoạt động"
                      : "Đã khóa",
                ),

                const SizedBox(height: 10),
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
        vertical: 7,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 125,
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

  Color getRoleColor(String role) {
    switch (role) {
      case "Phụ huynh":
        return Colors.blue;
      case "Giáo viên":
        return Colors.green;
      case "Cán bộ nhà trường":
        return Colors.deepOrange;
      case "Lãnh đạo nhà trường":
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  Widget buildAccountCard(UserAccount account) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),

      child: Padding(
        padding: const EdgeInsets.all(12),

        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor:
              getRoleColor(account.role).withAlpha(35),
              child: Icon(
                Icons.person,
                color: getRoleColor(account.role),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    account.fullName,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "Tên đăng nhập: ${account.username}",
                  ),

                  const SizedBox(height: 4),

                  Text(
                    account.role,
                    style: TextStyle(
                      color: getRoleColor(account.role),
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    account.isActive
                        ? "Đang hoạt động"
                        : "Đã khóa",
                    style: TextStyle(
                      color: account.isActive
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case "view":
                    openAccountDetail(account);
                    break;
                  case "edit":
                    openEditAccountScreen(account);
                    break;
                  case "status":
                    confirmChangeStatus(account);
                    break;
                  case "reset":
                    openResetPasswordDialog(account);
                    break;
                  case "delete":
                    confirmDelete(account);
                    break;
                }
              },
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: "view",
                    child: Text("Xem chi tiết"),
                  ),
                  const PopupMenuItem(
                    value: "edit",
                    child: Text("Sửa tài khoản"),
                  ),
                  PopupMenuItem(
                    value: "status",
                    child: Text(
                      account.isActive
                          ? "Khóa tài khoản"
                          : "Mở khóa tài khoản",
                    ),
                  ),
                  const PopupMenuItem(
                    value: "reset",
                    child: Text("Đặt lại mật khẩu"),
                  ),
                  const PopupMenuItem(
                    value: "delete",
                    child: Text(
                      "Xóa tài khoản",
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      appBar: AppBar(
        title: const Text("Quản lý tài khoản"),
        centerTitle: true,
        backgroundColor: const Color(0xFF18324F),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: openAddAccountScreen,
            icon: const Icon(Icons.add),
          ),
        ],
      ),

      body: ListenableBuilder(
        listenable: controller,
        builder: (context, child) {
          if (controller.isLoading &&
              controller.accounts.isEmpty) {
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
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            initialValue: controller.selectedRole,
                            isExpanded: true,//cho dung maximum size
                            decoration: const InputDecoration(
                              labelText: "Vai trò",
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 16,
                              ),
                            ),

                            items: controller.roles.map((role) {
                              return DropdownMenuItem<String>(
                                value: role,
                                child: Text(
                                  role,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }).toList(),

                            onChanged: (value) {
                              if (value != null) {
                                controller.changeRole(value);
                              }
                            },
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: DropdownButtonFormField<String>(
                            initialValue: controller.selectedStatus,

                            isExpanded: true,

                            decoration: const InputDecoration(
                              labelText: "Trạng thái",
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 16,
                              ),
                            ),

                            items: controller.statuses.map((status) {
                              return DropdownMenuItem<String>(
                                value: status,
                                child: Text(
                                  status,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }).toList(),

                            onChanged: (value) {
                              if (value != null) {
                                controller.changeStatus(value);
                              }
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    TextField(
                      decoration: const InputDecoration(
                        labelText:
                        "Tìm tên, tài khoản hoặc email",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                      onChanged:
                      controller.changeSearchText,
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
                      "Danh sách tài khoản",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${controller.filteredAccounts.length} tài khoản",
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: controller.filteredAccounts.isEmpty
                    ? const Center(
                  child: Text(
                    "Không tìm thấy tài khoản",
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
                      .filteredAccounts.length,
                  itemBuilder: (context, index) {
                    return buildAccountCard(
                      controller.filteredAccounts[
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
        onPressed: openAddAccountScreen,
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}