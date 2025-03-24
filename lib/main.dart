import 'package:flutter/material.dart';
import 'package:projcetapp/Screens/registerPage.dart';
import 'package:projcetapp/Screens/loginPage.dart';
import 'package:projcetapp/Screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ProjectApp',
      // home: Loginpage(),
      home: homePage(),
      routes: {
        '/register-page': (context) => Registerpage(),
        '/login-page': (context) => Loginpage()
      },
    );
  }
}
