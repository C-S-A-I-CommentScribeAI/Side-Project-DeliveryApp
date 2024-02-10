import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/sign/login_screen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _key = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorMessage = '';

  @override
  Future<void> _register() async {
    try {
      // Perform registration logic here
      // For example:
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Registration failed. Please try again.';
      });
      print("Error during registration: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
        elevation: 10,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Column(
              children: [
                const Text(
                  'CSAI 사장님',
                  style: TextStyle(fontSize: 40),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: _key,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 45,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '이름을 입력하세요',
                            ),
                            keyboardType: TextInputType.name, // 키보드 나타나게 설정
                            textAlignVertical: TextAlignVertical
                                .bottom, // hintText를 bottom으로 위치 설정
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 45,
                          child: TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '이메일을 입력하세요',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            textAlignVertical: TextAlignVertical.bottom,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 67,
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '비밀번호를 입력하세요',
                            ),
                            maxLength: 15, // 비밀번호 길이 제한 15로 설정
                            keyboardType: TextInputType.text,
                            textAlignVertical: TextAlignVertical.bottom,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 67,
                          child: TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '비밀번호를 다시 입력하세요',
                            ),
                            maxLength: 15,
                            keyboardType: TextInputType.text,
                            textAlignVertical: TextAlignVertical.bottom,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 45,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '전화번호를 입력하세요',
                            ),
                            keyboardType: TextInputType.name, // 키보드 나타나게 설정
                            textAlignVertical: TextAlignVertical
                                .bottom, // hintText를 bottom으로 위치 설정
                          ),
                        ),
                        const SizedBox(height: 40),
                        SizedBox(
                          width: 350,
                          child: ButtonTheme(
                            child: ElevatedButton(
                              onPressed: _register,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: const Text(
                                '회원가입',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
