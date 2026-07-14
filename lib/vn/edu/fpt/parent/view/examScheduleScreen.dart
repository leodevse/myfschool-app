import 'package:flutter/material.dart';

class ExamScheduleScreen extends StatefulWidget {
  const ExamScheduleScreen({super.key});

  @override
  State<ExamScheduleScreen> createState() => _ExamScheduleScreenState();
}

class _ExamScheduleScreenState extends State<ExamScheduleScreen> {
  int semester = 1;
  int currentPage = 1;
  static const int pageSize = 3;
  String selectedSchoolYear = "2026-2027";

  final List<String> schoolYears = [
    "2024-2025",
    "2025-2026",
    "2026-2027",
    "2027-2028",
  ];

  final List<Map<String, String>> exams = [
    {
      "date": "15/10/2026",
      "subject": "Toán",
      "room": "A302",
      "time": "07:00 - 08:30",
      "type": "Giữa kỳ",
      "format": "Tự luận",
    },

    {
      "date": "18/10/2026",
      "subject": "Ngữ văn",
      "room": "B203",
      "time": "07:00 - 09:00",
      "type": "Giữa kỳ",
      "format": "Tự luận",
    },

    {
      "date": "22/10/2026",
      "subject": "Tiếng Anh",
      "room": "A105",
      "time": "13:30 - 15:00",
      "type": "Giữa kỳ",
      "format": "Trắc nghiệm",
    },

    {
      "date": "18/12/2026",
      "subject": "Toán",
      "room": "A302",
      "time": "07:00 - 09:00",
      "type": "Cuối kỳ",
      "format": "Tự luận",
    },

    {
      "date": "20/12/2026",
      "subject": "Vật lý",
      "room": "B102",
      "time": "09:30 - 10:30",
      "type": "Cuối kỳ",
      "format": "Trắc nghiệm",
    },

    {
      "date": "22/12/2026",
      "subject": "Hóa học",
      "room": "C201",
      "time": "13:30 - 14:30",
      "type": "Cuối kỳ",
      "format": "Trắc nghiệm",
    },
  ];
  List<Map<String, String>> get currentExams {
    int start = (currentPage - 1) * pageSize;

    int end = start + pageSize;

    if (end > exams.length) {
      end = exams.length;
    }

    return exams.sublist(start, end);
  }

  int get totalPages {
    return (exams.length / pageSize).ceil();
  }

  Widget semesterButton(String title, bool selected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,

        child: Container(
          height: 45,

          alignment: Alignment.center,

          decoration: BoxDecoration(
            color: selected ? Colors.orange : Colors.grey.shade200,

            borderRadius: BorderRadius.circular(25),
          ),

          child: Text(
            title,

            style: TextStyle(
              color: selected ? Colors.white : Colors.black,

              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildExamCard(Map<String, String> exam) {
    return Card(
      elevation: 3,

      margin: const EdgeInsets.only(bottom: 15),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

      child: Padding(
        padding: const EdgeInsets.all(15),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Row(
                  children: [
                    const Icon(Icons.calendar_month, color: Colors.green),

                    const SizedBox(width: 10),

                    Text(
                      exam["date"]!,

                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.green.shade100,

                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Text(
                    exam["type"]!,

                    style: const TextStyle(
                      color: Colors.green,

                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const Divider(),

            Text("Môn: ${exam["subject"]}"),

            const SizedBox(height: 8),

            Text("Phòng: ${exam["room"]}"),

            const SizedBox(height: 8),

            Text("Thời gian: ${exam["time"]}"),

            const SizedBox(height: 8),

            Text("Hình thức: ${exam["format"]}"),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Lịch thi")),

      body: Padding(
        padding: const EdgeInsets.all(15),

        child: Column(
          children: [
            Row(
              children: [
                semesterButton("Học kỳ I", semester == 1, () {
                  setState(() {
                    semester = 1;
                  });
                }),

                const SizedBox(width: 10),

                semesterButton("Học kỳ II", semester == 2, () {
                  setState(() {
                    semester = 2;
                  });
                }),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Số môn thi: ${exams.length}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                DropdownMenu<String>(
                  width: 160,

                  initialSelection: selectedSchoolYear,

                  hintText: "Năm học",

                  onSelected: (value) {
                    if (value != null) {
                      setState(() {
                        selectedSchoolYear = value;
                      });
                    }
                  },

                  dropdownMenuEntries: schoolYears
                      .map(
                        (year) => DropdownMenuEntry(value: year, label: year),
                      )
                      .toList(),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Expanded(
              child: ListView.builder(
                itemCount: currentExams.length,

                itemBuilder: (context, index) {
                  return buildExamCard(currentExams[index]);
                },
              ),
            ),
            const SizedBox(height: 15),

            Row(
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
                    fontSize: 18,
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
          ],
        ),
      ),
    );
  }
}
