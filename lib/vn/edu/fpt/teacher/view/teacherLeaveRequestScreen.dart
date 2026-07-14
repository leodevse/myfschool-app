import 'package:flutter/material.dart';

class TeacherLeaveRequestScreen extends StatefulWidget {
  const TeacherLeaveRequestScreen({super.key});

  @override
  State<TeacherLeaveRequestScreen> createState() =>
      _TeacherLeaveRequestScreenState();
}

class _TeacherLeaveRequestScreenState extends State<TeacherLeaveRequestScreen> {
  int currentPage = 1;
  static const int pageSize = 3;

  final List<Map<String, String>> requests = [
    {
      "studentName": "Nguyễn Xuân Long",
      "class": "12A1",
      "type": "Đơn xin nghỉ học",
      "date": "03/07/2026",
      "reason": "Gia đình có việc nên em xin phép nghỉ học một buổi.",
      "status": "Chờ xử lý",
    },
    {
      "studentName": "Nguyễn Minh",
      "class": "12A1",
      "type": "Đơn xin kiểm tra bù",
      "date": "04/07/2026",
      "reason": "Em bị ốm nên chưa thể làm bài kiểm tra đúng lịch.",
      "status": "Chờ xử lý",
    },
    {
      "studentName": "Nguyễn Huy",
      "class": "11A2",
      "type": "Đơn xin cấp lại thẻ",
      "date": "05/07/2026",
      "reason": "Em bị mất thẻ học sinh và muốn xin cấp lại.",
      "status": "Chờ xử lý",
    },
    {
      "studentName": "Trần Hoàng Anh",
      "class": "12A1",
      "type": "Đơn xin nghỉ học",
      "date": "06/07/2026",
      "reason": "Em cần đi khám sức khỏe theo lịch hẹn của bệnh viện.",
      "status": "Chấp thuận",
    },
    {
      "studentName": "Lê Minh Khang",
      "class": "10A3",
      "type": "Đơn xin kiểm tra bù",
      "date": "07/07/2026",
      "reason": "Em tham gia giải thể thao của trường nên xin kiểm tra bù.",
      "status": "Từ chối",
    },
    {
      "studentName": "Phạm Gia Hân",
      "class": "11A2",
      "type": "Đơn xin nghỉ học",
      "date": "08/07/2026",
      "reason": "Gia đình em có việc đột xuất nên xin phép nghỉ học.",
      "status": "Chờ xử lý",
    },
  ];

  int get totalPages {
    final total = (requests.length / pageSize).ceil();
    return total == 0 ? 1 : total;
  }

  List<MapEntry<int, Map<String, String>>> get currentRequests {
    final start = (currentPage - 1) * pageSize;
    var end = start + pageSize;

    if (end > requests.length) {
      end = requests.length;
    }

    return List.generate(
      end - start,
      (index) => MapEntry(start + index, requests[start + index]),
    );
  }

  Color getStatusColor(String status) {
    if (status == "Chấp thuận") {
      return Colors.green;
    }

    if (status == "Từ chối") {
      return Colors.red;
    }

    return Colors.orange;
  }

  void updateStatus(int index, String status) {
    setState(() {
      requests[index]["status"] = status;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Đã cập nhật trạng thái: $status")));
  }

  Future<void> openDetail(int index) async {
    final newStatus = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) =>
            TeacherLeaveRequestDetailScreen(request: requests[index]),
      ),
    );

    if (newStatus != null && newStatus != requests[index]["status"]) {
      updateStatus(index, newStatus);
    }
  }

  Widget buildRequestCard(int index, Map<String, String> request) {
    final isPending = request["status"] == "Chờ xử lý";

    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              request["type"]!,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text("Học sinh: ${request["studentName"]}"),
            Text("Lớp: ${request["class"]}"),
            Text("Ngày gửi: ${request["date"]}"),
            const SizedBox(height: 10),
            Text(
              "Lý do:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            Text(
              request["reason"]!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Text(
              request["status"]!,
              style: TextStyle(
                color: getStatusColor(request["status"]!),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OutlinedButton(
                  onPressed: () => openDetail(index),
                  child: const Text("Xem chi tiết"),
                ),
                ElevatedButton(
                  onPressed: isPending
                      ? () => updateStatus(index, "Từ chối")
                      : null,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text(
                    "Từ chối",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: isPending
                      ? () => updateStatus(index, "Chấp thuận")
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                    "Duyệt",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPagination() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: currentPage > 1
                ? () {
                    setState(() {
                      currentPage--;
                    });
                  }
                : null,
            child: const Text("Trước"),
          ),
          const SizedBox(width: 20),
          Text(
            "$currentPage / $totalPages",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: currentPage < totalPages
                ? () {
                    setState(() {
                      currentPage++;
                    });
                  }
                : null,
            child: const Text("Sau"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Xử lý đơn từ"),
        centerTitle: true,
        backgroundColor: const Color(0xFF18324F),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: currentRequests.length,
              itemBuilder: (context, index) {
                final entry = currentRequests[index];
                return buildRequestCard(entry.key, entry.value);
              },
            ),
          ),
          buildPagination(),
        ],
      ),
    );
  }
}

class TeacherLeaveRequestDetailScreen extends StatelessWidget {
  final Map<String, String> request;

  const TeacherLeaveRequestDetailScreen({super.key, required this.request});

  Color getStatusColor(String status) {
    if (status == "Chấp thuận") {
      return Colors.green;
    }

    if (status == "Từ chối") {
      return Colors.red;
    }

    return Colors.orange;
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPending = request["status"] == "Chờ xử lý";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Chi tiết đơn từ"),
        centerTitle: true,
        backgroundColor: const Color(0xFF18324F),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              request["type"]!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: getStatusColor(request["status"]!).withOpacity(0.12),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                request["status"]!,
                style: TextStyle(
                  color: getStatusColor(request["status"]!),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            buildInfoRow("Học sinh", request["studentName"]!),
            buildInfoRow("Lớp", request["class"]!),
            buildInfoRow("Ngày gửi", request["date"]!),
            buildInfoRow("Lý do", request["reason"]!),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: isPending
                        ? () => Navigator.pop(context, "Từ chối")
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size.fromHeight(48),
                    ),
                    child: const Text(
                      "Từ chối",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: isPending
                        ? () => Navigator.pop(context, "Chấp thuận")
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size.fromHeight(48),
                    ),
                    child: const Text(
                      "Duyệt",
                      style: TextStyle(color: Colors.white),
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
