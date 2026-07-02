import 'package:flutter/material.dart';
import 'login.dart';
class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 60),

            const Text(
              "Đặt lại mật khẩu",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF36F21),
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Mật khẩu mới",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Xác nhận mật khẩu mới",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 30,),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF36F21),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );

                },
                child: const Text("HOÀN TẤT",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 18),
                ),
              ),
            ),
            const Spacer(),

            Text(
              "Phiên bản 1.0.0\n© ${DateTime.now().year} FPT Schools",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}