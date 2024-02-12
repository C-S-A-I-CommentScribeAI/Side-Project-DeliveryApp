import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:frontend/home_screen.dart';
import 'package:frontend/sign/resister_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorMessage = '';
  late bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = false;
  }

  Future<void> _login() async {
    try {
      // signInWithEmailAndPassword 메서드는 로그인에 성공하면 UserCredential 객체를 반환
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // 위젯이 마운트되지 않으면 async뒤에 context를 썼을 때 그 안에 아무런 값도 들어있지 않을 수 있어서 붙여준다.
      if (!mounted) return;
      // 로그인 성공 시 홈 페이지로 이동
      // pushReplacement 메서드는 현재 화면을 새로운 화면으로 대체
      // 새로운 화면을 스택에 푸시하면서 동시에 이전 화면을 스택에서 제거한다. 따라서 사용자가 이전 화면으로 돌아갈 수 없게 된다.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (e) {
      setState(() {
        _errorMessage = '이메일 또는 비밀번호가 올바르지 않습니다.';
      });
      print("Error during login: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인'),
        elevation: 10,
        backgroundColor: Colors.green[800],
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: GestureDetector(
        // email, password 입력하는 텍스트필드 부분을 제외한 화면을 탭하면 키보드 사라지게 구현
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        // 이메일과 비밀번호 텍스트필드를 클릭하면, 키보드가 열리게 되는데 이 경우에 화면의 가려지는 부분이 overflow 방지
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: Column(
              children: [
                const Center(
                  child: Text(
                    'CSAI 사장님',
                    style: TextStyle(fontSize: 40),
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 45,
                          child: TextField(
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
                          height: 45,
                          child: TextField(
                            controller: _passwordController,
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: '비밀번호를 입력하세요',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ), // 박스 안에 내용을 적을려고 할 때
                            ),
                            keyboardType: TextInputType.text,
                            textAlignVertical: TextAlignVertical.bottom,
                          ),
                        ),
                        if (_errorMessage.isNotEmpty)
                          Text(
                            _errorMessage,
                            style: const TextStyle(color: Colors.red),
                          ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 350,
                          child: ButtonTheme(
                            child: ElevatedButton(
                              onPressed: _login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[800],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: const Text(
                                '로그인',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // push :  이전 화면은 여전히 스택에 남아 있다. 따라서 사용자가 이전 화면으로 돌아갈 수 있다.
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterPage(),
                              ),
                            );
                          },
                          child: const Text('CSAI 사장님 앱이 처음이신가요?'),
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
