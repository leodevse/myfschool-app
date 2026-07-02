import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int currentStudent = 0;
  final List<Map<String, String>> students = [

    {
      "name":"Nguyễn Xuân Long",
      "class":"9A",
      "id":"HE182575",
      "campus":"Hà Nội",
      "email":"long@gmail.com",
    },

    {
      "name":"Nguyễn Minh",
      "class":"7A",
      "id":"HE182576",
      "campus":"Hà Nội",
      "email":"minh@gmail.com",
    },

    {
      "name":"Nguyễn Huy",
      "class":"5A",
      "id":"HE182577",
      "campus":"Hà Nội",
      "email":"huy@gmail.com",
    },

  ];
  Widget buildStudentCard(Map<String,String> student){

    return Card(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),

      child: Padding(
        padding: const EdgeInsets.all(15),

        child: Column(

          children: [

            Text(
              "${student["name"]} - Lớp ${student["class"]}",
              style: const TextStyle(
                fontSize:20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height:15),

            ListTile(
              leading: const Icon(Icons.badge),
              title: const Text("Mã học sinh"),
              subtitle: Text(student["id"]!),
              trailing: const Icon(Icons.remove_red_eye),
            ),

            ListTile(
              leading: const Icon(Icons.email),
              title: const Text("Email"),
              subtitle: Text(student["email"]!),
              trailing: const Icon(Icons.remove_red_eye),
            ),

            ListTile(
              leading: const Icon(Icons.school),
              title: const Text("Cơ sở"),
              subtitle: Text(student["campus"]!),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildIndicator() {
    if (students.length <= 1) {
      return const SizedBox();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        students.length,
            (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
            ),
            child: Icon(
              Icons.circle,
              size: 10,
              color: currentStudent == index
                  ? Colors.blue
                  : Colors.grey,
            ),
          );
        },
      ),
    );
  }


  bool darkMode = false;
  bool notification = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Thông tin cá nhân"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),

        child: Column(
          children: [

            //---------------- PHỤ HUYNH ----------------

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),

              child: Padding(
                padding: const EdgeInsets.all(15),

                child: Column(
                  children: [

                    const Text(
                      "Nguyễn Xuân Long - Phụ huynh",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    ListTile(
                      leading: const Icon(Icons.phone),
                      title: const Text("Số điện thoại"),
                      subtitle: const Text("0987654321"),
                      trailing: const Icon(Icons.remove_red_eye),
                    ),

                    ListTile(
                      leading: const Icon(Icons.email),
                      title: const Text("Email"),
                      subtitle: const Text("long@gmail.com"),
                      trailing: const Icon(Icons.remove_red_eye),
                    ),

                    ListTile(
                      leading: const Icon(Icons.location_on),
                      title: const Text("Địa chỉ"),
                      subtitle: const Text("Mỹ Đình, Hà Nội"),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            //---------------- HỌC SINH ----------------
            // buildStudentCard(students[0])

            SizedBox(

              height: 300,

              child: PageView.builder(

                controller: PageController(
                  viewportFraction: 1,
                ),

                itemCount: students.length,

                onPageChanged: (index){

                  setState(() {

                    currentStudent = index;

                  });

                },

                itemBuilder: (context,index){

                  return buildStudentCard(
                    students[index],
                  );

                },

              ),

            ),

            const SizedBox(height: 10),
            buildIndicator(),
            const SizedBox(height: 10),


            //---------------- CÀI ĐẶT ----------------

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),

              child: Column(
                children: [

                  SwitchListTile(
                    secondary: const Icon(Icons.dark_mode),
                    title: const Text("Chế độ nền tối"),
                    value: darkMode,
                    onChanged: (value) {
                      setState(() {
                        darkMode = value;
                      });
                    },
                  ),

                  SwitchListTile(
                    secondary: const Icon(Icons.notifications),
                    title: const Text("Bật thông báo"),
                    value: notification,
                    onChanged: (value) {
                      setState(() {
                        notification = value;
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),

                onPressed: () {
                  Navigator.pop(context);
                },

                child: const Text(
                  "Đăng Xuất",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}