import 'package:carrot_flutter/src/screens/home.dart';
import 'package:carrot_flutter/src/screens/intro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/auth/register.dart';

class MyApp extends StatelessWidget {
  final bool isLogin;

  const MyApp(this.isLogin, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Carrot Market',
      theme: ThemeData(
        primaryColor: const Color(0xFFFF6f0f),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFFFF6f0f),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 18, fontFamily: 'Noto Sans'),
          bodyMedium: TextStyle(fontSize: 14, fontFamily: 'Noto Sans'),
          labelLarge: TextStyle(
            fontSize: 16,
            fontFamily: 'Noto Sans',
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xffFF7E36),
            padding: const EdgeInsets.symmetric(vertical: 22),
            textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xffFF7E36),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
          floatingLabelStyle: TextStyle(fontSize: 10),
          contentPadding: EdgeInsets.all(10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
      routes: {
        '/': (context) => const Home(),
        '/intro': (context) => const Intro(),
        '/register': (context) => const Register(),
      },
      initialRoute: isLogin ? '/' : '/intro',
      // onGenerateRoute: (route) {
      //   // '/feed/:id' 형식의 경로를 위한 라우트 설정
      //   if (route.name!.startsWith('/feed/')) {
      //     // 경로에서 id를 추출하여 변수에 저장
      //     final id = int.parse(route.name!.split('/').last);
      //     // 추출한 id에 해당하는 항목을 찾습니다.
      //     final item = feedList.firstWhere((e) => e['id'] == id);
      //     return MaterialPageRoute(
      //       builder: (context) => FeedShow(id),
      //     );
      //   }
      //   // 다른 경로에 대한 처리
      //   return MaterialPageRoute(
      //     builder: (context) => const UnknownScreen(),
      //   );
      // },
    );
  }
}
