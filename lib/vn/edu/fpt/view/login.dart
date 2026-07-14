import 'package:flutter/material.dart';
import 'forgotPassword.dart';
import 'roleScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header với logo FPT
            Container(
              height: 300,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Image.asset(
                    'web/icons/imgfpt.jpg',
                    width: 200,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => 
                        const Icon(Icons.business, color: Colors.orange, size: 100),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'FPT SCHOOLS',
                    style: TextStyle(
                      color: Color(0xFFF26F21),
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  // Ô nhập Số điện thoại
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone_android, color: Color(0xFF2196F3)),
                      hintText: 'Số điện thoại',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Ô nhập Mật khẩu
                  TextField(
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF2196F3)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: Colors.deepOrange,
                        ),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                      hintText: 'Mật khẩu',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // 2. Lệnh chuyển màn hình đơn giản nhất
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                        );
                      },
                      child: const Text(
                        'Quên mật khẩu?',
                        style: TextStyle(color: Color(0xFFF16822)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Nút Đăng nhập & FaceID
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // 3. Lệnh chuyển màn hình đơn giản nhất
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const RoleScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF16822),
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'ĐĂNG NHẬP',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                      ),
                      // const SizedBox(width: 0),//defaul 30 with faceId
                      // Nút FaceID
                      // IconButton(
                      //   onPressed: () {},
                      //   iconSize: 45,
                      //   padding: EdgeInsets.zero,
                      //   constraints: const BoxConstraints(),
                      //   icon: Image.asset(
                      //     'web/icons/img.png',
                      //     width: 45,
                      //     height: 45,
                      //     errorBuilder: (context, error, stackTrace) =>
                      //         const Icon(Icons.face, size: 45, color: Color(0xFFF16822)),
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 330),
                  const Text(
                    'Phiên bản 1.0.0',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '© ${DateTime.now().year} FPT Schools',
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
