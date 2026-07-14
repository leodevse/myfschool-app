import 'package:flutter/material.dart';
import '../model/grade.dart';

class MarkDetailScreen extends StatelessWidget {
  final SubjectGrade subject;

  const MarkDetailScreen({
    super.key,
    required this.subject,
  });

  double calculateAverage() {
    double total = 0;
    int weight = 0;

    for (var item in subject.gradeItems) {
      total += item.score * item.weight;
      weight += item.weight;
    }

    return total / weight;
  }

  String formatScore(double score) {
    if (score == score.toInt()) {
      return score.toInt().toString();
    }
    return score.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    final average = calculateAverage();

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("Điểm Chi tiết"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),

        child: Column(
          children: [

            // THÔNG TIN MÔN
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(12),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    subject.subject,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Divider(color: Colors.black),

                  Row(
                    children: [

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          subject.status,
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(width: 15),

                      const Text(
                        "Lớp: 12a3",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [

                      const Text(
                        "Trung bình: ",
                        style: TextStyle(fontSize: 16),
                      ),

                      Text(
                        formatScore(average),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // BẢNG ĐIỂM
            Table(
              border: TableBorder.all(color: Colors.black),
              columnWidths: const {
                0: FlexColumnWidth(1.4),
                1: FlexColumnWidth(1.4),
                2: FlexColumnWidth(0.9),
                3: FlexColumnWidth(1.1),
              },

              children: [

                buildHeaderRow(),

                buildScoreRow(
                  "Tham gia",
                  "Kiểm tra\nmiệng",
                  "3.3%",
                  "10   10   10",
                ),
                buildTotalRow("Tổng", "10%", "10"),

                buildScoreRow(
                  "Kiểm tra nhỏ",
                  "Kiểm tra 15\nphút",
                  "3.3%",
                  "10   10   10",
                ),
                buildTotalRow("Tổng", "10%", "10"),

                buildScoreRow(
                  "Kiểm tra vừa",
                  "Kiểm tra 45\nphút",
                  "10%",
                  "10   10",
                ),
                buildTotalRow("Tổng", "20%", "10"),

                buildScoreRow(
                  "Kiểm tra giữa\nkỳ",
                  "Kiểm tra giữa\nkỳ",
                  "30%",
                  "10",
                ),
                buildTotalRow("Tổng", "30%", "10"),

                buildScoreRow(
                  "Kiểm tra cuối\nkỳ",
                  "Kiểm tra cuối\nkỳ",
                  "30%",
                  "10",
                ),
                buildTotalRow("Tổng", "30%", "10"),

                buildFinalRow(
                  "Tổng điểm",
                  "Trung bình",
                  "",
                  formatScore(average),
                ),

                buildFinalRow(
                  "",
                  "Trạng thái",
                  "",
                  subject.status,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TableRow buildHeaderRow() {
    return const TableRow(
      decoration: BoxDecoration(
        color: Color(0xFFE0E0E0),
      ),
      children: [
        tableCell("Hạng mục", bold: true),
        tableCell("Hạng mục", bold: true),
        tableCell("Trọng\nsố", bold: true),
        tableCell("Điểm", bold: true),
      ],
    );
  }

  TableRow buildScoreRow(
      String category,
      String item,
      String weight,
      String score,
      ) {
    return TableRow(
      children: [
        tableCell(category),
        tableCell(item),
        tableCell(weight),
        tableCell(score),
      ],
    );
  }

  TableRow buildTotalRow(
      String item,
      String weight,
      String score,
      ) {
    return TableRow(
      decoration: const BoxDecoration(
        color: Color(0xFFEAEAEA),
      ),
      children: [
        const tableCell(""),
        tableCell(item),
        tableCell(weight),
        tableCell(score),
      ],
    );
  }

  TableRow buildFinalRow(
      String category,
      String item,
      String weight,
      String score,
      ) {
    return TableRow(
      decoration: const BoxDecoration(
        color: Color(0xFFF2F2F2),
      ),
      children: [
        tableCell(category),
        tableCell(item),
        tableCell(weight),
        tableCell(score),
      ],
    );
  }
}

class tableCell extends StatelessWidget {
  final String text;
  final bool bold;

  const tableCell(
      this.text, {
        super.key,
        this.bold = false,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 13,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}