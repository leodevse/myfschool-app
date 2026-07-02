import 'package:flutter/material.dart';
import 'otpVerification.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 40),

              // Logo / Title
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  // Logo FPT 3 màu
                  Image.asset(
                    'web/icons/imgfpt.jpg',
                    width: 200,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.business, color: Colors.orange, size: 100),
                  ),
                   Text(
                    "FPT SCHOOLS",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF36F21),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 50),

              // Phone input
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.phone_android),
                  hintText: "Số điện thoại",
                  contentPadding: const EdgeInsets.all(16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Send OTP button
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
                    // TODO: call API send OTP
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const OtpScreen()),
                    );
                  },
                  child: const Text(
                    "GỬI MÃ OTP",
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
      ),
    );
  }
}