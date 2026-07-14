import '../model/userAccount.dart';

class AccountService {
  final List<UserAccount> _accounts = [
    UserAccount(
      id: "TK001",
      fullName: "Nguyễn Văn A",
      username: "nguyenvana",
      email: "vana@fpt.edu.vn",
      phone: "0987654321",
      role: "Giáo viên",
      isActive: true,
    ),
    UserAccount(
      id: "TK002",
      fullName: "Nguyễn Thị Hoa",
      username: "nguyenthihoa",
      email: "hoa.parent@gmail.com",
      phone: "0912345678",
      role: "Phụ huynh",
      isActive: true,
    ),
    UserAccount(
      id: "TK003",
      fullName: "Trần Minh Đức",
      username: "tranduc.staff",
      email: "duc.staff@fpt.edu.vn",
      phone: "0901234567",
      role: "Cán bộ nhà trường",
      isActive: true,
    ),
    UserAccount(
      id: "TK004",
      fullName: "Phạm Văn Nam",
      username: "phamvannam",
      email: "nam.parent@gmail.com",
      phone: "0978123456",
      role: "Phụ huynh",
      isActive: false,
    ),
    UserAccount(
      id: "TK005",
      fullName: "Lê Thị Hương",
      username: "lethihuong",
      email: "huong.leader@fpt.edu.vn",
      phone: "0966123456",
      role: "Lãnh đạo nhà trường",
      isActive: true,
    ),
  ];

  Future<List<UserAccount>> getAccounts() async {
    await Future.delayed(
      const Duration(milliseconds: 400),
    );

    return List<UserAccount>.from(_accounts);
  }

  Future<void> addAccount(UserAccount account) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
    );

    final bool usernameExists = _accounts.any(
          (item) => item.username.toLowerCase() ==
          account.username.toLowerCase(),
    );

    if (usernameExists) {
      throw Exception("Tên đăng nhập đã tồn tại");
    }

    _accounts.add(account);
  }

  Future<void> updateAccount(UserAccount account) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
    );

    final int index = _accounts.indexWhere(
          (item) => item.id == account.id,
    );

    if (index < 0) {
      throw Exception("Không tìm thấy tài khoản");
    }

    final bool usernameExists = _accounts.any(
          (item) =>
      item.id != account.id &&
          item.username.toLowerCase() ==
              account.username.toLowerCase(),
    );

    if (usernameExists) {
      throw Exception("Tên đăng nhập đã tồn tại");
    }

    _accounts[index] = account;
  }

  Future<void> deleteAccount(String id) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
    );

    _accounts.removeWhere(
          (account) => account.id == id,
    );
  }

  Future<void> changeAccountStatus({
    required String id,
    required bool isActive,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 250),
    );

    final int index = _accounts.indexWhere(
          (item) => item.id == id,
    );

    if (index < 0) {
      throw Exception("Không tìm thấy tài khoản");
    }

    _accounts[index] = _accounts[index].copyWith(
      isActive: isActive,
    );
  }

  Future<void> resetPassword({
    required String accountId,
    required String newPassword,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 350),
    );

    final bool accountExists = _accounts.any(
          (item) => item.id == accountId,
    );

    if (!accountExists) {
      throw Exception("Không tìm thấy tài khoản");
    }

    // Phiên bản demo chưa lưu mật khẩu thực tế.
    // Khi gọi Java Web, mật khẩu phải được mã hóa ở backend.
  }
}