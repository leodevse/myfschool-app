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

  @override
  Widget build(BuildContext context) {

    final average = calculateAverage();

    return Scaffold(

      appBar: AppBar(
        title: Text(subject.subject),
      ),

      body: Padding(

        padding: const EdgeInsets.all(15),

        child: Column(

          children: [

            Card(

              child: Padding(

                padding: const EdgeInsets.all(15),

                child: Column(

                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Text(

                      subject.subject,

                      style: const TextStyle(

                        fontSize: 24,

                        fontWeight:
                        FontWeight.bold,

                      ),

                    ),

                    const SizedBox(height: 10),

                    Text(

                      "Điểm trung bình : ${average.toStringAsFixed(2)}",

                      style: const TextStyle(
                        fontSize: 18,
                      ),

                    ),

                    const SizedBox(height: 10),

                    Text(

                      "Kết quả : ${subject.status}",

                      style: TextStyle(

                        fontSize: 18,

                        color: subject.status == "Đạt"
                            ? Colors.green
                            : Colors.red,

                      ),

                    )

                  ],

                ),

              ),

            ),

            const SizedBox(height: 20),

            Expanded(

              child: ListView.builder(

                itemCount: subject.gradeItems.length,

                itemBuilder: (context, index) {

                  GradeItem item =
                  subject.gradeItems[index];

                  return Card(

                    child: ListTile(

                      leading: CircleAvatar(

                        child: Text(

                          item.weight.toString(),

                        ),

                      ),

                      title: Text(item.name),

                      subtitle: Text(
                        item.category,
                      ),

                      trailing: Text(

                        item.score.toString(),

                        style: const TextStyle(

                          fontWeight:
                          FontWeight.bold,

                          fontSize: 18,

                        ),

                      ),

                    ),

                  );

                },

              ),

            )

          ],

        ),

      ),

    );

  }

}