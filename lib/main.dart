import 'package:flutter/material.dart';
import 'vn/edu/fpt/view/login.dart';
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