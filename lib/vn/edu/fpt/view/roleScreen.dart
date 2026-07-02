import 'package:flutter/material.dart';
import 'package:myfschoolse1913/vn/edu/fpt/view/homePage.dart';

class RoleScreen extends StatelessWidget {
  const RoleScreen({super.key});

  Widget buildRoleCard({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Colors.black12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(
              icon,
              color: color,
              size: 30,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),

          const Spacer(),

          Container(
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [

              const SizedBox(height: 30),

              const Text(
                'FPT Schools',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              const Text(
                'Chào mừng bạn đến với FPT Schools',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),

              const Text(
                'Xin mời lựa chọn vai trò',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 50),

              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      // 3. Lệnh chuyển màn hình đơn giản nhất
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                      );
                    },
                    child: buildRoleCard(
                    icon: Icons.person,
                    title: 'Lãnh đạo\nNhà trường',
                    color: Colors.orange,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // 3. Lệnh chuyển màn hình đơn giản nhất
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                      );
                    },
                    child: buildRoleCard(
                      icon: Icons.badge,
                      title: 'Cán bộ\nNhà trường',
                      color: Colors.red,
                    ),
                  )
                ],
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      // 3. Lệnh chuyển màn hình đơn giản nhất
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                      );
                    },
                    child: buildRoleCard(
                    icon: Icons.school,
                    title: 'Giáo viên\nNhà trường',
                    color: Colors.blue,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      // 3. Lệnh chuyển màn hình đơn giản nhất
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                      );
                    },

                    child: buildRoleCard(
                      icon: Icons.groups,
                      title: 'Phụ huynh\nHọc sinh',
                      color: Colors.green,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}