import 'package:flutter/material.dart';

class TeacherScheduleScreen extends StatefulWidget {
  const TeacherScheduleScreen({super.key});

  @override
  State<TeacherScheduleScreen> createState() =>
      _TeacherScheduleScreenState();
}

class _TeacherScheduleScreenState extends State<TeacherScheduleScreen> {
  int currentDay = 0;

  final List<String> weekDays = [
    "T2",
    "T3",
    "T4",
    "T5",
    "T6",
    "T7",
    "CN",
  ];

  final List<Map<String, String>> lessons = [
    {
      "day": "T2",
      "slot": "1",
      "time": "07:00 - 07:45",
      "class": "12A1",
      "subject": "Toán",
      "room": "A301",
    },
    {
      "day": "T2",
      "slot": "2",
      "time": "07:55 - 08:40",
      "class": "12A2",
      "subject": "Toán",
      "room": "A302",
    },
    {
      "day": "T3",
      "slot": "3",
      "time": "09:00 - 09:45",
      "class": "11A1",
      "subject": "Toán",
      "room": "B201",
    },
    {
      "day": "T4",
      "slot": "4",
      "time": "10:00 - 10:45",
      "class": "10A3",
      "subject": "Toán",
      "room": "C101",
    },
  ];

  List<Map<String, String>> get currentLessons {
    String selectedDay = weekDays[currentDay];

    return lessons.where((lesson) {
      return lesson["day"] == selectedDay;
    }).toList();
  }

  List<String> getCurrentWeekDates() {
    DateTime today = DateTime.now();

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

  String getCurrentWeekRange() {
    DateTime today = DateTime.now();

    DateTime monday = today.subtract(
      Duration(days: today.weekday - 1),
    );

    DateTime sunday = monday.add(
      const Duration(days: 6),
    );

    return "${monday.day}/${monday.month}/${monday.year}"
        " - "
        "${sunday.day}/${sunday.month}/${sunday.year}";
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
          Text(
            weekDays[index],
            style: const TextStyle(
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 8),

          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: selected ? Colors.blue : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey,
              ),
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
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tiết ${lesson["slot"]} - ${lesson["time"]}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Divider(),

            Text(
              "Môn: ${lesson["subject"]}",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 8),

            Text("Lớp: ${lesson["class"]}"),

            const SizedBox(height: 8),

            Text("Phòng: ${lesson["room"]}"),
          ],
        ),
      ),
    );
  }

  Widget buildEmptySchedule() {
    return const Center(
      child: Text(
        "Không có lịch dạy trong ngày này",
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("Thời khóa biểu"),
        centerTitle: true,
        backgroundColor: const Color(0xFF18324F),
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(15),

        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_back_ios),
                ),

                Text(
                  getCurrentWeekRange(),
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                weekDays.length,
                    (index) {
                  return buildDayItem(index);
                },
              ),
            ),

            const SizedBox(height: 25),

            Expanded(
              child: currentLessons.isEmpty
                  ? buildEmptySchedule()
                  : ListView.builder(
                itemCount: currentLessons.length,
                itemBuilder: (context, index) {
                  return buildLessonCard(
                    currentLessons[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}