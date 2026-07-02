import 'package:flutter/material.dart';
import 'profileScreen.dart';
import 'scheduleScreen.dart';
import 'examScheduleScreen.dart';
import 'markReportScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentStudent = 0;
  final List<Map<String, String>> students = [
    {"name": "Nguyễn Xuân Long", "class": "9A"},
    {"name": "Nguyễn Minh", "class": "7A"},
    {"name": "Nguyễn Huy", "class": "5A"},
  ];
  Widget buildStudentCard(String name, String className) {
    return Center(
      child: Container(
        width: 250,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text("$name - Lớp $className", textAlign: TextAlign.center),
      ),
    );
  }

  Widget buildIndicator() {
    if (students.length <= 1) {
      return const SizedBox();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(students.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Icon(
            Icons.circle,
            size: 10,
            color: currentStudent == index ? Colors.blue : Colors.grey,
          ),
        );
      }),
    );
  }

  Widget buildStudentSection() {
    return SizedBox(
      height: 60,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.8),

        // Thêm ở đây
        onPageChanged: (index) {
          setState(() {
            currentStudent = index;
          });
        },

        itemCount: students.length,

        itemBuilder: (context, index) {
          return buildStudentCard(
            students[index]["name"]!,
            students[index]["class"]!,
          );
        },
      ),
    );
  }

  Widget buildFeature(String title, IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 95,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40),

            const SizedBox(height: 8),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNewsItem() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(border: Border.all()),
      child: const Icon(Icons.image, size: 40),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Trò chuyện"),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Thông báo",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Trang chủ"),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Hoạt động",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.contacts), label: "Danh bạ"),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                // HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    const Text(
                      "FPT Schools",
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Row(
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Xin Chào,", style: TextStyle(fontSize: 14)),

                            Text(
                              "Long",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(width: 10),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfileScreen(),
                              ),
                            );
                          },

                          child: CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.grey.shade200,
                            child: const Icon(
                              Icons.person_outline,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                buildStudentSection(),

                const SizedBox(height: 8),

                buildIndicator(),

                const SizedBox(height: 30),

                //=========================
                // CÁC CHỨC NĂNG
                //=========================
                const Text(
                  "Các chức năng chính",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 15),

                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),

                  crossAxisCount: 2,

                  crossAxisSpacing: 15,

                  mainAxisSpacing: 15,

                  childAspectRatio: 1.7,
                  children: [
                    buildFeature(
                      "Lịch học",
                      Icons.calendar_month,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ScheduleScreen(),
                          ),
                        );
                      },
                    ),
                    buildFeature(
                      "Lịch thi",
                      Icons.event_note,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ExamScheduleScreen(),
                          ),
                        );
                      },
                    ),

                    buildFeature("Nhiệm vụ, bài tập", Icons.assignment),
                    buildFeature(
                      "Điểm học kỳ",
                      Icons.school,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MarkReportScreen(),
                          ),
                        );
                      },
                    ),

                  ],
                ),

                const SizedBox(height: 30),

                const Text(
                  "Các chức năng khác",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 15),

                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),

                  crossAxisCount: 2,

                  crossAxisSpacing: 15,

                  mainAxisSpacing: 15,

                  childAspectRatio: 1.7,
                  children: [
                    buildFeature("Sự kiện", Icons.event),

                    buildFeature("Danh sách đơn từ", Icons.description),

                    buildFeature("Báo cáo điểm danh", Icons.fact_check),

                    buildFeature("Câu lạc bộ", Icons.groups),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
