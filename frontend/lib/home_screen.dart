import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/manage/accept_screen.dart';
import 'package:frontend/manage/menu_screen.dart';
import 'package:frontend/manage/review_screen.dart';
import 'package:frontend/manage/store_screen.dart';
import 'package:frontend/sign/login_screen.dart';
import 'package:frontend/widgets/homeButton_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSAI 사장님'),
        elevation: 10,
        backgroundColor: Colors.green[800],
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {},
            icon: const Icon(
              Icons.account_circle,
            ),
          ),
        ],
      ),
      // drawer 메뉴(사이드바 메뉴)
      // Drawer() 위젯의 경우 기본적으로 Scaffold() 위젯 내에 존재
      drawer: Drawer(
        // 프로필 헤더 밑에 스택처럼 쌓이는 ListTile들과 하단에 고정시키는 ListTile들을 다른 위젯으로 보기 위해 Column으로 설정
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  // 위쪽에 계정(프로필, 이름, 이메일) 표시
                  UserAccountsDrawerHeader(
                    // 현재 계정 이미지
                    currentAccountPicture: const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/짱구.png'),
                      backgroundColor: Colors.white,
                    ),
                    accountName: const Text('민택기'),
                    accountEmail: const Text('tk@naver.com'),
                    decoration: BoxDecoration(
                      color: Colors.green[800],
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Align : 부모의 위젯 안에서 자식 위젯을 배치시킬 수 있는 위젯
            // 하단에 고정된 상태로 유지
            Align(
                alignment: FractionalOffset.bottomCenter, // 중앙하단 배치
                child: Column(
                  children: [
                    const Divider(), // 경계선
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('Settings'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Logout'),
                      onTap: () async {
                        await _auth.signOut();
                        // 로그인 페이지로 이동
                        if (!mounted) return;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                    ),
                  ],
                )),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              width: 330,
              height: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(217, 217, 217, 1.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: const Text(
                '리뷰는 간편하게 고객 관리는 완벽하게!!',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 32),
              child: Column(
                children: [
                  Row(
                    children: [
                      // HomeBtn인 공통 버튼 위젯을 생성
                      HomeBtn(
                        buttonText: '가게관리',
                        page: StorePage(),
                      ),
                      SizedBox(width: 10),
                      HomeBtn(
                        buttonText: '메뉴관리',
                        page: MenuPage(),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      HomeBtn(
                        buttonText: '접수관리',
                        page: AcceptPage(),
                      ),
                      SizedBox(width: 10),
                      HomeBtn(
                        buttonText: '리뷰관리',
                        page: ReviewPage(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
