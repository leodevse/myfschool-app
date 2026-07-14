import 'package:flutter/material.dart';
import 'teacherClassDetailScreen.dart';

class TeacherClassScreen extends StatelessWidget {
  const TeacherClassScreen({super.key});

  final List<Map<String, dynamic>> classes = const [
    {
      "className": "12A1",
      "studentCount": 42,
    },
    {
      "className": "12A2",
      "studentCount": 40,
    },
    {
      "className": "11A5",
      "studentCount": 39,
    },
  ];

  Widget buildClassCard(
      BuildContext context,
      Map<String, dynamic> item,
      ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.class_),
        ),
        title: Text(
          item["className"],
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "${item["studentCount"]} học sinh",
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TeacherClassDetailScreen(
                className: item["className"],
                studentCount: item["studentCount"],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("Lớp học"),
        centerTitle: true,
        backgroundColor: const Color(0xFF18324F),
        foregroundColor: Colors.white,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: classes.length,
        itemBuilder: (context, index) {
          return buildClassCard(
            context,
            classes[index],
          );
        },
      ),
    );
  }
}