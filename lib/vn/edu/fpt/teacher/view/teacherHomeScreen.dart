import 'package:flutter/material.dart';

import '../../view/profileScreen.dart';
import 'teacherAssignmentScreen.dart';
import 'teacherGradeScreen.dart';
import 'teacherLeaveRequestScreen.dart';
import 'teacherScheduleScreen.dart';
import 'teachNotificationScreen.dart';
import 'teacherInternalNotificationScreen.dart';
import 'teacherClassScreen.dart';

class TeacherHomeScreen extends StatelessWidget {
  const TeacherHomeScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2,

        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TeacherScheduleScreen(),
                ),
              );
              break;

            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TeacherNotificationScreen(),
                ),
              );
              break;

            case 2:
              break;

            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TeacherLeaveRequestScreen(),
                ),
              );
              break;

            case 4:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
              break;
          }
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Lịch dạy",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Thông báo",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Trang chủ"),
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check),
            label: "Đơn từ",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Hồ sơ"),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                            "Nguyễn Văn A",
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

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text("Giáo viên Toán - Chủ nhiệm lớp 12A1"),
              ),

              const SizedBox(height: 30),

              const Text(
                "Các chức năng chính",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                    "Lớp học",
                    Icons.class_,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TeacherClassScreen(),
                        ),
                      );
                    },
                  ),

                  buildFeature(
                    "Giao bài tập",
                    Icons.assignment_add,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TeacherAssignmentScreen(),
                        ),
                      );
                    },
                  ),
                  buildFeature(
                    "Nhập điểm",
                    Icons.edit_note,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TeacherGradeScreen(),
                        ),
                      );
                    },
                  ),
                  buildFeature(
                    "Thời khóa biểu",
                    Icons.calendar_month,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TeacherScheduleScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 30),

              const Text(
                "Các chức năng khác",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                    "Thông báo Nội bộ",
                    Icons.notifications,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const TeacherInternalNotificationScreen(),
                        ),
                      );
                    },
                  ),
                  buildFeature("Sự kiện", Icons.event),
                  buildFeature("Báo cáo lớp", Icons.bar_chart),
                  buildFeature(
                    "Xử lý đơn từ",
                    Icons.fact_check,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const TeacherLeaveRequestScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
