import 'package:flutter/material.dart';
import 'resetPassword.dart';
class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

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
              "Nhập mã OTP",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF36F21),
              ),
            ),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                4,
                    (index) => SizedBox(
                  width: 50,
                  child: TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: const InputDecoration(counterText: ""),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            TextButton(
              onPressed: () {},
              child: const Text(
                "Gửi lại mã",
                style: TextStyle(color: Color(0xFFF36F21)),
              ),
            ),

            const SizedBox(height: 25),

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
                    MaterialPageRoute(builder: (context) => const ResetPasswordScreen()),
                  );

                },
                child: const Text(
                    "XÁC NHẬN",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 18)
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