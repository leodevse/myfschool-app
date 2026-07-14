import 'package:flutter/material.dart';

import '../model/userAccount.dart';

class StaffAccountFormScreen extends StatefulWidget {
  final UserAccount? account;

  const StaffAccountFormScreen({
    super.key,
    this.account,
  });

  @override
  State<StaffAccountFormScreen> createState() =>
      _StaffAccountFormScreenState();
}

class _StaffAccountFormScreenState
    extends State<StaffAccountFormScreen> {
  final TextEditingController fullNameController =
  TextEditingController();

  final TextEditingController usernameController =
  TextEditingController();

  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController phoneController =
  TextEditingController();

  String selectedRole = "Phụ huynh";
  bool isActive = true;

  final List<String> roles = [
    "Phụ huynh",
    "Giáo viên",
    "Cán bộ nhà trường",
    "Lãnh đạo nhà trường",
  ];

  bool get isEditing => widget.account != null;

  @override
  void initState() {
    super.initState();

    if (widget.account != null) {
      final UserAccount account = widget.account!;

      fullNameController.text = account.fullName;
      usernameController.text = account.username;
      emailController.text = account.email;
      phoneController.text = account.phone;

      selectedRole = account.role;
      isActive = account.isActive;
    }
  }

  void saveAccount() {
    final String fullName =
    fullNameController.text.trim();

    final String username =
    usernameController.text.trim();

    final String email = emailController.text.trim();

    final String phone = phoneController.text.trim();

    if (fullName.isEmpty ||
        username.isEmpty ||
        email.isEmpty ||
        phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Vui lòng nhập đầy đủ thông tin",
          ),
        ),
      );
      return;
    }

    if (!email.contains("@")) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email không hợp lệ"),
        ),
      );
      return;
    }

    if (phone.length < 9) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Số điện thoại không hợp lệ",
          ),
        ),
      );
      return;
    }

    final UserAccount result = UserAccount(
      id: widget.account?.id ??
          "TK${DateTime.now().millisecondsSinceEpoch}",
      fullName: fullName,
      username: username,
      email: email,
      phone: phone,
      role: selectedRole,
      isActive: isActive,
    );

    Navigator.pop(context, result);
  }

  @override
  void dispose() {
    fullNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text(
          isEditing
              ? "Sửa tài khoản"
              : "Thêm tài khoản",
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
              controller: fullNameController,
              decoration: const InputDecoration(
                labelText: "Họ và tên *",
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: "Tên đăng nhập *",
                prefixIcon: Icon(Icons.account_circle),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email *",
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Số điện thoại *",
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              initialValue: selectedRole,
              decoration: const InputDecoration(
                labelText: "Vai trò",
                prefixIcon:
                Icon(Icons.admin_panel_settings),
                border: OutlineInputBorder(),
              ),
              items: roles.map((role) {
                return DropdownMenuItem<String>(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedRole = value;
                  });
                }
              },
            ),

            const SizedBox(height: 10),

            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(
                "Trạng thái tài khoản",
              ),
              subtitle: Text(
                isActive
                    ? "Tài khoản đang hoạt động"
                    : "Tài khoản đang bị khóa",
              ),
              value: isActive,
              onChanged: (value) {
                setState(() {
                  isActive = value;
                });
              },
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: saveAccount,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.save),
                label: Text(
                  isEditing
                      ? "Lưu thay đổi"
                      : "Thêm tài khoản",
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}