import 'package:flutter/material.dart';
import 'package:myfschoolse1913/vn/edu/fpt/school_staff/view/SchoolStaffClassScreen.dart';
import 'package:myfschoolse1913/vn/edu/fpt/school_staff/view/SchoolStaffStudentScreen.dart';
import 'package:myfschoolse1913/vn/edu/fpt/school_staff/view/SchoolStaffTeacherScreen.dart';
import 'package:myfschoolse1913/vn/edu/fpt/school_staff/view/SchoolStaffTimetableScreen.dart';
import 'package:myfschoolse1913/vn/edu/fpt/school_staff/view/SchoolStaffAccountScreen.dart';

import 'SchoolStaffFeeScreen.dart';
import 'SchoolStaffNotiScreen.dart';
import 'SchoolStaffTeachingAssignmentScreen.dart';
import 'SchoolStaffYearScreen.dart';

class StaffHomeScreen extends StatelessWidget {
  const StaffHomeScreen({super.key});

  // Tạo một ô chức năng trên trang chủ
  Widget buildFeature(
      BuildContext context,
      String title,
      IconData icon, {
        Widget? screen,
      }) {
    return GestureDetector(
      onTap: () {
        // Nếu chức năng đã có màn hình thì mở màn hình đó
        if (screen != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => screen,
            ),
          );
        } else {
          // Nếu chưa có màn hình thì hiển thị thông báo
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Chức năng $title đang được phát triển",
              ),
            ),
          );
        }
      },

      child: Container(
        height: 105,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey.shade400,
          ),
          borderRadius: BorderRadius.circular(15),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: const Color(0xFF18324F),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Hàm chuyển màn hình dùng cho BottomNavigationBar
  void openScreen(
      BuildContext context,
      Widget screen,
      ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // Thanh điều hướng dưới dành cho cán bộ
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2,

        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,

        onTap: (index) {
          switch (index) {
            case 0:
              openScreen(
                context,
                const TemporaryScreen(
                  title: "Quản lý",
                ),
              );
              break;

            case 1:
              openScreen(
                context,
                const TemporaryScreen(
                  title: "Thông báo toàn trường",
                ),
              );
              break;

            case 2:
            // Đang ở trang chủ nên không chuyển
              break;

            case 3:
              openScreen(
                context,
                const TemporaryScreen(
                  title: "Báo cáo thống kê",
                ),
              );
              break;

            case 4:
              openScreen(
                context,
                const TemporaryScreen(
                  title: "Hồ sơ cán bộ",
                ),
              );
              break;
          }
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_accounts),
            label: "Quản lý",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.campaign),
            label: "Thông báo",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Trang chủ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Báo cáo",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Hồ sơ",
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //===============================
              // HEADER
              //===============================

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      "FPT Schools",
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Xin chào,",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "Nguyễn Thị A",
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
                          openScreen(
                            context,
                            const TemporaryScreen(
                              title: "Hồ sơ cán bộ",
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

              // Thông tin vai trò
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  border: Border.all(
                    color: Colors.deepOrange,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.admin_panel_settings,
                      color: Colors.deepOrange,
                    ),

                    SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        "Cán bộ đào tạo - Quản trị vận hành hệ thống",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              //===============================
              // QUẢN LÝ DANH MỤC
              //===============================

              const Text(
                "Quản lý danh mục",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),

                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.55,

                children: [
                  buildFeature(
                    context,
                    "Quản lý học sinh",
                    Icons.school,
                    screen: const SchoolStaffStudentScreen(),
                  ),

                  buildFeature(
                    context,
                    "Quản lý giáo viên",
                    Icons.person_pin,
                    screen: const StaffTeacherScreen(),
                  ),

                  buildFeature(
                    context,
                    "Quản lý lớp học",
                    Icons.class_,
                    screen: StaffClassScreen(),
                  ),

                  buildFeature(
                    context,
                    "Phân công giảng dạy",
                    Icons.assignment_ind,
                    screen: const StaffTeachingAssignmentScreen(),
                  ),

                  buildFeature(
                    context,
                    "Năm học và học kỳ",
                    Icons.calendar_month,
                    screen: const StaffSchoolYearScreen(),
                  ),

                  buildFeature(
                    context,
                    "Thời khóa biểu",
                    Icons.schedule,
                    screen: const StaffTimetableScreen(),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              //===============================
              // QUẢN LÝ VẬN HÀNH
              //===============================

              const Text(
                "Quản lý vận hành",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),

                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.55,

                children: [
                  buildFeature(
                    context,
                    "Quản lý tài khoản",
                    Icons.manage_accounts,
                    screen: const StaffAccountScreen(),
                  ),

                  buildFeature(
                    context,
                    "Quản lý khoản thu",
                    Icons.payments,
                    screen: const StaffFeeScreen(),
                  ),

                  buildFeature(
                    context,
                    "Thông báo toàn trường",
                    Icons.campaign,
                    screen: const StaffSchoolNotificationScreen(),
                  ),

                  buildFeature(
                    context,
                    "Báo cáo thống kê",
                    Icons.bar_chart,
                  ),

                  buildFeature(
                    context,
                    "Quản lý đơn từ",
                    Icons.fact_check,
                  ),

                  buildFeature(
                    context,
                    "Cấu hình hệ thống",
                    Icons.settings,
                  ),
                ],
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}

// Màn hình tạm dùng cho chức năng chưa được xây dựng
class TemporaryScreen extends StatelessWidget {
  final String title;

  const TemporaryScreen({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: const Color(0xFF18324F),
        foregroundColor: Colors.white,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.construction,
              size: 70,
              color: Colors.deepOrange,
            ),

            const SizedBox(height: 20),

            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Chức năng đang được phát triển",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}