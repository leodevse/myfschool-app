import 'package:flutter/material.dart';

class ApplicationListScreen extends StatefulWidget {
  const ApplicationListScreen({super.key});

  @override
  State<ApplicationListScreen> createState() =>
      _ApplicationListScreenState();
}

class _ApplicationListScreenState
    extends State<ApplicationListScreen> {
  int currentPage = 1;
  final int pageSize = 4;

  final List<Map<String, String>> applications = const [
    {
      "title": "Đơn xin nghỉ học",
      "date": "03/07/2026",
      "status": "Chấp thuận",
      "statusType": "approved",
      "note":
      "Giáo viên đã xác nhận đơn của em, em có thể xem lại bài từ các bạn nhé",
      "content":
      "Ngày hôm nay nhà em có việc nên xin phép cô cho em nghỉ buổi hôm nay. Em sẽ học và ghi chép bài đầy đủ.\n\nEm xin chân thành cảm ơn cô",
    },
    {
      "title": "Đơn xin cấp lại thẻ",
      "date": "03/03/2026",
      "status": "Đang xử lý",
      "statusType": "processing",
      "note": "",
      "content":
      "Ngày hôm nay em bị mất thẻ. Em làm đơn này để mong muốn được cấp lại thẻ học sinh.\n\nEm xin chân thành cảm ơn cô.",
    },
    {
      "title": "Đơn xin kiểm tra bù",
      "date": "20/01/2026",
      "status": "Từ chối",
      "statusType": "rejected",
      "note":
      "Giáo viên đã xác nhận đơn của em, hiện kế hoạch thi đã hoàn tất không thể kiểm tra lại.",
      "content":
      "Ngày hôm qua em quên nên xin phép cô cho em kiểm tra lại môn toán.\n\nEm xin chân thành cảm ơn cô",
    },
    {
      "title": "Đơn xin nghỉ học",
      "date": "03/07/2026",
      "status": "Chấp thuận",
      "statusType": "approved",
      "note":
      "Giáo viên đã xác nhận đơn của em, em có thể xem lại bài từ các bạn nhé",
      "content":
      "Ngày hôm nay nhà em có việc nên xin phép cô cho em nghỉ buổi hôm nay. Em sẽ học và ghi chép bài đầy đủ.\n\nEm xin chân thành cảm ơn cô",
    },
    {
      "title": "Đơn xin cấp lại thẻ",
      "date": "03/03/2026",
      "status": "Đang xử lý",
      "statusType": "processing",
      "note": "",
      "content":
      "Ngày hôm nay em bị mất thẻ. Em làm đơn này để mong muốn được cấp lại thẻ học sinh.\n\nEm xin chân thành cảm ơn cô.",
    },
    {
      "title": "Đơn xin kiểm tra bù",
      "date": "20/01/2026",
      "status": "Từ chối",
      "statusType": "rejected",
      "note":
      "Giáo viên đã xác nhận đơn của em, hiện kế hoạch thi đã hoàn tất không thể kiểm tra lại.",
      "content":
      "Ngày hôm qua em quên nên xin phép cô cho em kiểm tra lại môn toán.\n\nEm xin chân thành cảm ơn cô",
    },


  ];
  int get totalPages {
    return (applications.length / pageSize).ceil();
  }

  List<Map<String, String>> get currentApplications {
    int start = (currentPage - 1) * pageSize;
    int end = start + pageSize;

    if (end > applications.length) {
      end = applications.length;
    }

    return applications.sublist(start, end);
  }

  Color getStatusColor(String type) {
    if (type == "approved") {
      return Colors.green;
    }

    if (type == "processing") {
      return Colors.deepOrange;
    }

    return Colors.red;
  }

  Color getStatusBackground(String type) {
    if (type == "approved") {
      return Colors.green.shade50;
    }

    if (type == "processing") {
      return Colors.orange.shade100;
    }

    return Colors.red.shade100;
  }

  Widget buildStatusBadge(String status, String type) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: getStatusBackground(type),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: getStatusColor(type),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildNoteBox(String note) {
    if (note.isEmpty) {
      return const SizedBox();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      color: Colors.blue.shade50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "Ghi chú",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              note,
              style: const TextStyle(
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildApplicationCard(Map<String, String> app) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Icon(
                    Icons.assignment_turned_in,
                    color: Colors.green,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        app["title"]!,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Create date: ${app["date"]}",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),

                buildStatusBadge(
                  app["status"]!,
                  app["statusType"]!,
                ),
              ],
            ),
          ),

          const Divider(
            height: 1,
            color: Colors.black,
          ),

          buildNoteBox(app["note"]!),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                app["content"]!,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ),
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
        title: const Text(
          "Danh sách đơn từ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF18324F),
        foregroundColor: Colors.white,
      ),

        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(15),
                itemCount: currentApplications.length,
                itemBuilder: (context, index) {
                  return buildApplicationCard(
                    currentApplications[index],
                  );
                },
              ),
            ),

            Padding(
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
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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
            ),
          ],
        ),
    );
  }
}