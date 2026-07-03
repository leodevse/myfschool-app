import 'package:flutter/material.dart';
import '../../model/grade.dart';
import 'markDetailScreen.dart';

class MarkReportScreen extends StatefulWidget {
  const MarkReportScreen({super.key});

  @override
  State<MarkReportScreen> createState() =>
      _MarkReportScreenState();
}

class _MarkReportScreenState
    extends State<MarkReportScreen> {

  //----------------------------------------------------
  // Học kỳ
  //----------------------------------------------------

  int semester = 1;

  //----------------------------------------------------
  // Năm học
  //----------------------------------------------------

  String selectedSchoolYear = "2026-2027";

  final List<String> schoolYears = [

    "2024-2025",

    "2025-2026",

    "2026-2027",

    "2027-2028",

  ];

  //----------------------------------------------------
  // Dữ liệu mẫu
  //----------------------------------------------------

  final List<SubjectGrade> subjects = [

    SubjectGrade(

      subject: "Toán",

      average: 8.6,

      status: "Đạt",

      gradeItems: [

        GradeItem(
          category: "Điểm miệng",
          name: "Miệng 1",
          weight: 1,
          score: 8,
        ),

        GradeItem(
          category: "Điểm miệng",
          name: "Miệng 2",
          weight: 1,
          score: 9,
        ),

        GradeItem(
          category: "Điểm miệng",
          name: "Miệng 3",
          weight: 1,
          score: 8,
        ),

        GradeItem(
          category: "15 phút",
          name: "15 phút 1",
          weight: 1,
          score: 9,
        ),

        GradeItem(
          category: "15 phút",
          name: "15 phút 2",
          weight: 1,
          score: 8,
        ),

        GradeItem(
          category: "15 phút",
          name: "15 phút 3",
          weight: 1,
          score: 9,
        ),

        GradeItem(
          category: "1 tiết",
          name: "1 tiết 1",
          weight: 2,
          score: 8,
        ),

        GradeItem(
          category: "1 tiết",
          name: "1 tiết 2",
          weight: 2,
          score: 9,
        ),

        GradeItem(
          category: "Giữa kỳ",
          name: "Giữa kỳ",
          weight: 2,
          score: 8,
        ),

        GradeItem(
          category: "Cuối kỳ",
          name: "Cuối kỳ",
          weight: 3,
          score: 9,
        ),

      ],

    ),

  ];

  //----------------------------------------------------

  Color getColor(double avg) {

    if (avg >= 8) {
      return Colors.green;
    }

    if (avg >= 6.5) {
      return Colors.orange;
    }

    return Colors.red;
  }

  //----------------------------------------------------

  Widget semesterButton(

      String text,

      bool selected,

      VoidCallback onTap,

      ) {

    return Expanded(

      child: GestureDetector(

        onTap: onTap,

        child: Container(

          height: 45,

          alignment: Alignment.center,

          decoration: BoxDecoration(

            color: selected
                ? Colors.orange
                : Colors.grey.shade200,

            borderRadius:
            BorderRadius.circular(25),

          ),

          child: Text(

            text,

            style: TextStyle(

              fontWeight: FontWeight.bold,

              color: selected
                  ? Colors.white
                  : Colors.black,

            ),
          ),
        ),
      ),
    );
  }

  //----------------------------------------------------

  Widget buildSubjectCard(
      SubjectGrade grade,
      ) {

    return Card(

      elevation: 3,

      margin: const EdgeInsets.only(
        bottom: 15,
      ),

      child: ListTile(

        leading: CircleAvatar(

          backgroundColor:
          getColor(grade.average),

          child: const Icon(

            Icons.school,

            color: Colors.white,

          ),
        ),

        title: Text(

          grade.subject,

          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),

        ),

        subtitle: Text(

          "Điểm TB : ${grade.average}",

        ),

        trailing: Column(

          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            Text(

              grade.status,

              style: TextStyle(

                color:
                getColor(grade.average),

                fontWeight:
                FontWeight.bold,

              ),

            ),

            const Icon(
              Icons.arrow_forward_ios,
              size: 15,
            )

          ],
        ),

        onTap: () {

          Navigator.push(

            context,

            MaterialPageRoute(

              builder: (context)=>

                  MarkDetailScreen(

                    subject: grade,

                  ),

            ),

          );

        },

      ),

    );

  }

  //----------------------------------------------------

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text("Bảng điểm"),

      ),

      body: Padding(

        padding: const EdgeInsets.all(15),

        child: Column(

          children: [

            //--------------------------------

            Row(

              children: [

                semesterButton(

                  "Học kỳ I",

                  semester==1,

                      (){

                    setState(() {

                      semester=1;

                    });

                  },

                ),

                const SizedBox(width:10),

                semesterButton(

                  "Học kỳ II",

                  semester==2,

                      (){

                    setState(() {

                      semester=2;

                    });

                  },

                ),

              ],

            ),

            const SizedBox(height:20),

            //--------------------------------

            Row(

              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,

              children: [

                Text(

                  "Số môn: ${subjects.length}",

                  style: const TextStyle(

                    fontSize: 18,

                    fontWeight:
                    FontWeight.bold,

                  ),

                ),

                DropdownMenu<String>(

                  width: 160,

                  initialSelection:
                  selectedSchoolYear,

                  onSelected: (value){

                    if(value!=null){

                      setState(() {

                        selectedSchoolYear=value;

                      });

                    }

                  },

                  dropdownMenuEntries:

                  schoolYears

                      .map(

                        (e)=>

                        DropdownMenuEntry(

                          value:e,

                          label:e,

                        ),

                  )

                      .toList(),

                )

              ],

            ),

            const SizedBox(height:20),

            //--------------------------------

            Expanded(

              child: ListView.builder(

                itemCount: subjects.length,

                itemBuilder: (context,index){

                  return buildSubjectCard(

                    subjects[index],

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