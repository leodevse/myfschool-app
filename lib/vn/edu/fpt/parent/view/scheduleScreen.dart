import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  //==============================
  // Học kỳ đang chọn
  // 0 = Học kỳ I
  // 1 = Học kỳ II
  //==============================
  int currentSemester = 0;

  //==============================
  // Ngày đang chọn
  // 0 = Thứ 2
  // 1 = Thứ 3
  // ...
  //==============================
  int currentDay = 0;

  //==============================
  // Danh sách học kỳ
  //==============================
  final List<String> semesters = ["Học kỳ I", "Học kỳ II"];

  //==============================
  // Các ngày trong tuần
  //==============================
  final List<String> weekDays = ["T2", "T3", "T4", "T5", "T6", "T7", "CN"];

  //==============================
  // Ngày trong tháng
  //==============================
  String getCurrentWeekRange() {

    DateTime today = DateTime.now();

    // Lấy ngày Thứ 2 của tuần hiện tại
    DateTime monday = today.subtract(
      Duration(days: today.weekday - 1),
    );

    // Lấy ngày Chủ nhật
    DateTime sunday = monday.add(
      const Duration(days: 6),
    );

    return "${monday.day}/${monday.month}/${monday.year}"
        " - "
        "${sunday.day}/${sunday.month}/${sunday.year}";
  }

  List<String> getCurrentWeekDates() {
    DateTime today = DateTime.now();

    // Thứ 2 của tuần hiện tại
    DateTime monday = today.subtract(
      Duration(days: today.weekday - 1),
    );

    List<String> dates = [];

    for (int i = 0; i < 7; i++) {
      DateTime day = monday.add(Duration(days: i));
      dates.add(day.day.toString());
    }

    return dates;
  }

  //==============================
  // Dữ liệu mẫu
  //==============================
  final List<Map<String, String>> lessons = [
    {
      "slot": "1",
      "time": "07:00 - 07:45",
      "subject": "Toán",
      "teacher": "Nguyễn Văn A",
      "room": "A301",
    },

    {
      "slot": "2",
      "time": "08:00 - 08:45",
      "subject": "Ngữ văn",
      "teacher": "Trần Thị B",
      "room": "B203",
    },

    {
      "slot": "3",
      "time": "09:00 - 09:45",
      "subject": "Tiếng Anh",
      "teacher": "Lê Văn C",
      "room": "A205",
    },

    {
      "slot": "4",
      "time": "10:00 - 10:45",
      "subject": "Vật lý",
      "teacher": "Phạm Văn D",
      "room": "B101",
    },

    {
      "slot": "5",
      "time": "11:00 - 11:45",
      "subject": "Hóa học",
      "teacher": "Nguyễn Văn E",
      "room": "A103",
    },

    {
      "slot": "6",
      "time": "14:00 - 15:30",
      "subject": "Sinh học",
      "teacher": "Lê Thị F",
      "room": "B201",
    },

    {
      "slot": "7",
      "time": "15:40 - 17:10",
      "subject": "Lịch sử",
      "teacher": "Trần Văn G",
      "room": "A202",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.blue,

        foregroundColor: Colors.white,

        centerTitle: true,

        title: const Text(
          "LỊCH HỌC",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(15),

        child: Column(
          children: [
            //----------------------------
            // Chọn học kỳ
            //----------------------------
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: currentSemester == 0
                          ? Colors.orange
                          : Colors.white,

                      foregroundColor: currentSemester == 0
                          ? Colors.white
                          : Colors.black,
                    ),

                    onPressed: () {
                      setState(() {
                        currentSemester = 0;
                      });
                    },

                    child: const Text("Học kỳ I"),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: currentSemester == 1
                          ? Colors.orange
                          : Colors.white,

                      foregroundColor: currentSemester == 1
                          ? Colors.white
                          : Colors.black,
                    ),

                    onPressed: () {
                      setState(() {
                        currentSemester = 1;
                      });
                    },

                    child: const Text("Học kỳ II"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            //----------------------------
            // Tuần hiện tại
            //----------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                IconButton(
                  onPressed: () {},

                  icon: const Icon(Icons.arrow_back_ios),
                ),

                Text(
                  getCurrentWeekRange(),

                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                IconButton(
                  onPressed: () {},

                  icon: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),

            const SizedBox(height: 15),

            //-------------------------------------
            // Thứ trong tuần
            //-------------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: List.generate(weekDays.length, (index) {
                return buildDayItem(index);
              }),
            ),

            const SizedBox(height: 25),
            Expanded(

              child: ListView.builder(

                itemCount: lessons.length,

                itemBuilder: (context, index) {

                  return buildLessonCard(

                    lessons[index],

                  );

                },

              ),

            ),
          ],
        ),
      ),
    );
  }

  Widget buildDayItem(int index) {
    bool selected = currentDay == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentDay = index;
        });
      },

      child: Column(
        children: [
          Text(weekDays[index], style: const TextStyle(fontSize: 16)),

          const SizedBox(height: 8),

          Container(
            width: 42,
            height: 42,

            decoration: BoxDecoration(
              color: selected ? Colors.blue : Colors.white,

              shape: BoxShape.circle,

              border: Border.all(color: Colors.grey),
            ),

            child: Center(
              child: Text(
                getCurrentWeekDates()[index],
                style: TextStyle(
                  color: selected ? Colors.white : Colors.black,

                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLessonCard(Map<String, String> lesson) {

    return Card(

      elevation: 3,

      margin: const EdgeInsets.only(bottom: 15),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),

      child: Padding(

        padding: const EdgeInsets.all(15),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              "Tiết ${lesson["slot"]}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              lesson["time"]!,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),

            const Divider(),

            Row(
              children: [

                const Icon(Icons.book),

                const SizedBox(width: 10),

                Text(
                  lesson["subject"]!,
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [

                const Icon(Icons.person),

                const SizedBox(width: 10),

                Text(
                  lesson["teacher"]!,
                ),

              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [

                const Icon(Icons.meeting_room),

                const SizedBox(width: 10),

                Text(
                  lesson["room"]!,
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}
