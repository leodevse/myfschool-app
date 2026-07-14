import 'package:flutter/material.dart';

class TeacherClassDetailScreen extends StatelessWidget {
  final String className;
  final int studentCount;

  const TeacherClassDetailScreen({
    super.key,
    required this.className,
    required this.studentCount,
  });

  Widget buildMenuItem(
      String title,
      IconData icon,
      ) {
    return Container(
      height: 95,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 38,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget buildStudentItem(String name, String group) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: Text(name),
        subtitle: Text(group),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text("Lớp $className"),
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
              "Lớp $className",
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Sĩ số: $studentCount học sinh",
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 25),

            const Text(
              "Chức năng lớp học",
              style: TextStyle(
                fontSize: 22,
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
              childAspectRatio: 1.7,
              children: [
                buildMenuItem(
                  "Danh sách học sinh",
                  Icons.people,
                ),
                buildMenuItem(
                  "Điểm",
                  Icons.school,
                ),
                buildMenuItem(
                  "Điểm danh",
                  Icons.fact_check,
                ),
                buildMenuItem(
                  "Bài tập",
                  Icons.assignment,
                ),
              ],
            ),

            const SizedBox(height: 25),

            const Text(
              "Danh sách học sinh",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            buildStudentItem("Nguyễn Xuân Long", "Tổ 1"),
            buildStudentItem("Nguyễn Minh", "Tổ 2"),
            buildStudentItem("Nguyễn Huy", "Tổ 3"),
            buildStudentItem("Trần Văn Nam", "Tổ 4"),
          ],
        ),
      ),
    );
  }
}