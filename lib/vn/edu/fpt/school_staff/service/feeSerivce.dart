import '../model/fee.dart';

class FeeService {
  final List<SchoolFee> _fees = [
    SchoolFee(
      id: "KT001",
      title: "Học phí học kỳ I",
      description: "Học phí chính thức của học kỳ I.",
      amount: 5000000,
      targetType: "Theo lớp",
      targetName: "12A1",
      dueDate: DateTime(2026, 9, 30),
      status: "Đang thu",
      totalStudents: 42,
      paidStudents: 35,
    ),
    SchoolFee(
      id: "KT002",
      title: "Phí đồng phục",
      description: "Khoản thu đồng phục năm học mới.",
      amount: 750000,
      targetType: "Theo khối",
      targetName: "Khối 10",
      dueDate: DateTime(2026, 8, 25),
      status: "Đã đóng",
      totalStudents: 240,
      paidStudents: 240,
    ),
    SchoolFee(
      id: "KT003",
      title: "Phí xe đưa đón tháng 9",
      description: "Phí xe đưa đón học sinh trong tháng 9.",
      amount: 600000,
      targetType: "Theo lớp",
      targetName: "11A1",
      dueDate: DateTime(2026, 9, 10),
      status: "Quá hạn",
      totalStudents: 39,
      paidStudents: 30,
    ),
  ];

  Future<List<SchoolFee>> getFees() async {
    await Future.delayed(
      const Duration(milliseconds: 400),
    );

    return List<SchoolFee>.from(_fees);
  }

  Future<void> addFee(SchoolFee fee) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
    );

    _fees.add(fee);
  }

  Future<void> updateFee(SchoolFee fee) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
    );

    final int index = _fees.indexWhere(
          (item) => item.id == fee.id,
    );

    if (index < 0) {
      throw Exception("Không tìm thấy khoản thu");
    }

    _fees[index] = fee;
  }

  Future<void> deleteFee(String id) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
    );

    _fees.removeWhere(
          (item) => item.id == id,
    );
  }

  Future<void> closeFee(String id) async {
    await Future.delayed(
      const Duration(milliseconds: 250),
    );

    final int index = _fees.indexWhere(
          (item) => item.id == id,
    );

    if (index < 0) {
      throw Exception("Không tìm thấy khoản thu");
    }

    _fees[index] = _fees[index].copyWith(
      status: "Đã đóng",
    );
  }
}