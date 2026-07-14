import 'package:flutter/material.dart';
import 'teacherAddNotificationScreen.dart';
class TeacherNotificationScreen extends StatefulWidget {
  const TeacherNotificationScreen({super.key});

  @override
  State<TeacherNotificationScreen> createState() =>
      _TeacherNotificationScreenState();
}

class _TeacherNotificationScreenState
    extends State<TeacherNotificationScreen> {

  List<Map<String,String>> notifications=[

    {

      "title":"Thông báo nghỉ học",

      "class":"12A1",

      "date":"03/07/2026",

      "status":"Đã gửi",

    },

    {

      "title":"Thông báo họp phụ huynh",

      "class":"12A2",

      "date":"02/07/2026",

      "status":"Nháp",

    },

    {

      "title":"Thông báo thi giữa kỳ",

      "class":"11A1",

      "date":"01/07/2026",

      "status":"Đã gửi",

    },

  ];

  Color getColor(String status){

    if(status=="Đã gửi"){

      return Colors.green;

    }

    return Colors.orange;

  }

  @override
  Widget build(BuildContext context){

    return Scaffold(

      backgroundColor: Colors.white,

      appBar: AppBar(

        title: const Text("Thông báo"),

        centerTitle: true,

        backgroundColor: const Color(0xff18324F),

        foregroundColor: Colors.white,

        actions: [

          IconButton(

              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TeacherAddNotificationScreen(),
                  ),
                );
              },

          ),

        ],

      ),

      body: Column(

        children: [

          Padding(

            padding: const EdgeInsets.all(15),

            child: TextField(

              decoration: InputDecoration(

                hintText: "Tìm kiếm",

                prefixIcon: const Icon(Icons.search),

                border: OutlineInputBorder(

                  borderRadius:
                  BorderRadius.circular(10),

                ),

              ),

            ),

          ),

          Expanded(

            child: ListView.builder(

              itemCount: notifications.length,

              itemBuilder: (context,index){

                var item=notifications[index];

                return Card(

                  margin: const EdgeInsets.symmetric(

                    horizontal:15,

                    vertical:6,

                  ),

                  child: ListTile(

                    leading: const Icon(
                      Icons.notifications,
                    ),

                    title: Text(item["title"]!),

                    subtitle: Text(

                        "${item["class"]}\n${item["date"]}"

                    ),

                    trailing: Text(

                      item["status"]!,

                      style: TextStyle(

                        color:getColor(

                            item["status"]!

                        ),

                        fontWeight:
                        FontWeight.bold,

                      ),

                    ),

                  ),

                );

              },

            ),

          ),

        ],

      ),

    );

  }

}