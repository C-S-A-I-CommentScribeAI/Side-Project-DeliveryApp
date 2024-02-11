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
  final TextEditingController _emailController =
      TextEditingController(); // 입력된 값 가져올 때 사용하는 클래스 선언
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _smsCodeController = TextEditingController();

  String _errorMessage = '';
  bool _codeSent = false;
  late String _verificationId;
  late bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible =
        false; // 비밀번호를 보이는 passwordVisible를 false로 설정(비밀번호가 보이게 설정)
  }

  Future<void> _register() async {
    try {
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
                        // 이름을 입력하는 텍스트필드
                        SizedBox(
                          height: 45,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '이름을 입력하세요',
                            ),
                            keyboardType: TextInputType.name, // 입력 키보드 유형 지정
                            textAlignVertical: TextAlignVertical
                                .bottom, // hintText를 bottom으로 위치 설정
                          ),
                        ),
                        const SizedBox(height: 10),

                        // 이메일을 입력하는 텍스트필드
                        SizedBox(
                          height: 45,
                          child: TextFormField(
                            controller: _emailController, // 입력한 이메일을 가져옴
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '이메일을 입력하세요',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            textAlignVertical: TextAlignVertical.bottom,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // 비밀번호를 입력하는 텍스트필드
                        SizedBox(
                          height: 45,
                          child: TextFormField(
                            controller: _passwordController, // 입력한 비밀번호를 가져옴
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: '비밀번호를 입력하세요',
                              counterText: '',
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
                              ),
                            ),
                            maxLength: 15, // 비밀번호 길이 제한
                            keyboardType: TextInputType.text,
                            textAlignVertical: TextAlignVertical.bottom,
                            onTap: () {
                              if (_passwordController.text.length < 6) {
                                // 현재 화면에 스낵바를 표시하는 메서드
                                // 비밀번호를 6자 이상 작성하면 스낵바가 사라짐(일정 시간 지나도 사라짐)
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('6자 이상 입력하세요'),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 10),

                        // 비밀번호 재확인을 입력하는 텍스트필드
                        SizedBox(
                          height: 45,
                          child: TextFormField(
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: '비밀번호를 다시 입력하세요',
                              counterText: '',
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
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            textAlignVertical: TextAlignVertical.bottom,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // 전화번호를 입력하는 텍스트필드
                        SizedBox(height: 45, child: phoneNumberInput()),
                        const SizedBox(height: 20),

                        // 코드가 보내지면 빈 공간, 아직 보내지기 전이면 제출 버튼 표시
                        _codeSent ? const SizedBox.shrink() : submitButton(),

                        // 코드가 성공적으로 보내지면 인증 코드 입력하는 텍스트필드 표시
                        // 성공적으로 보내지지 않으면 빈 공간
                        _codeSent
                            ? SizedBox(
                                height: 45,
                                width: 200,
                                child: smsCodeInput(),
                              )
                            : const SizedBox.shrink(),
                        const SizedBox(height: 10),

                        // 코드가 성공적으로 보내지면 인증 성공 버튼 표시
                        // 성공적으로 보내지지 않으면 빈 공간
                        _codeSent
                            ? verifyButton(context)
                            : const SizedBox.shrink(),
                        const SizedBox(height: 40),

                        // 회원가입 버튼
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

  // 전화번호를 입력하는 텍스트필드
  TextFormField phoneNumberInput() {
    return TextFormField(
      controller: _phoneController,
      autofocus: true, // 페이지가 로드될 때 이 입력 필드에 자동으로 포커스가 설정
      validator: (val) {
        // 입력값이 비어있는지 여부를 확인
        if (val!.isEmpty) {
          // 전화번호가 적혀있지 않다면 메세지 출력
          return 'The Input is Empty';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: '전화번호를 입력하세요',
      ),
      textAlignVertical: TextAlignVertical.bottom,
    );
  }

  // 인증 코드 입력하는 텍스트필드
  TextFormField smsCodeInput() {
    return TextFormField(
      controller: _smsCodeController,
      autofocus: true,
      validator: (val) {
        if (val!.isEmpty) {
          return '전화번호를 입력하지 않았습니다.';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'sms 코드를 입력하세요',
        hintStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.bottom,
    );
  }

  // 해당 번호로 SMS 코드를 전송하는 버튼
  ElevatedButton submitButton() {
    return ElevatedButton(
      onPressed: () async {
        // 입력된 전화번호의 유효성을 검사
        if (_key.currentState!.validate()) {
          final FirebaseAuth auth = FirebaseAuth.instance;
          // FirebaseAuth를 사용하여 전화번호 확인을 위한 SMS 코드를 전송
          await auth.verifyPhoneNumber(
            phoneNumber: _phoneController.text,
            // 번호가 자동으로 확인되는 경우 실행되는 콜백 함수
            verificationCompleted: (PhoneAuthCredential credential) async {
              // android 전용
              await auth
                  .signInWithCredential(credential)
                  .then((_) => Navigator.pushNamed(context, "/"));
            },
            verificationFailed: (FirebaseAuthException e) {
              if (e.code == 'invalid-phone-number') {
                print("제공한 전화번호는 잘못된 번호입니다.");
              }
            },
            codeSent: (String verificationId, forceResendingToken) async {
              String smsCode = _smsCodeController
                  .text; // SMS 코드가 성공적으로 보내지면 입력한 코드를 smsCode에 저장
              // 성공적으로 보내지면 인증 ID 저장
              setState(() {
                _codeSent = true;
                _verificationId = verificationId;
              });
            },
            // 코드가 자동으로 검색되는 시간이 초과된 경우 아래에 메세지 출력
            codeAutoRetrievalTimeout: (verificationId) {
              print("handling code auto retrieval timeout");
            },
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: const Text(
          'SMS code 전송',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  // 입력한 SMS 코드를 확인하여 휴대폰 번호의 인증을 완료하는 버튼
  ElevatedButton verifyButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final FirebaseAuth auth =
            FirebaseAuth.instance; // FirebaseAuth의 인스턴스를 가져옴

        // PhoneAuthCredential 객체를 생성하여 전화번호의 인증을 위한 자격 증명을 제공
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            // _verificationId에 저장된 인증 ID와 _smsCodeController에 입력된 SMS 코드를 사용
            verificationId: _verificationId,
            smsCode: _smsCodeController.text);

        // 휴대폰 인증 성공 여부를 확인하기 위해 try-catch 문을 사용
        try {
          // 휴대폰 인증을 수행합니다.
          // FirebaseAuth를 사용하여 자격 증명을 통해 사용자를 인증하고 로그인
          await auth.signInWithCredential(credential);

          if (!mounted) return;
          // 인증이 성공하면 다이얼로그를 표시하여 사용자에게 인증 성공 메시지를 표시
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('인증 성공'),
                content: const Text('휴대폰 인증이 성공적으로 완료되었습니다.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('확인'),
                  ),
                ],
              );
            },
          );
        } catch (e) {
          // 인증 실패 시 에러 메시지를 출력
          print("Phone authentication failed: $e");
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: const Text(
          "Verify",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
