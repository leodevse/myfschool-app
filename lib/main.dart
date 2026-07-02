import 'package:flutter/material.dart';
import 'vn/edu/fpt/view/login.dart';
import 'vn/edu/fpt/view/forgotPassword.dart';
import 'vn/edu/fpt/view/otpVerification.dart';
import 'vn/edu/fpt/view/resetPassword.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Ẩn chữ debug
      title: 'FPT SCHOOLS clone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const LoginScreen(), // Đặt LoginScreen làm màn hình chính

    );
  }
}