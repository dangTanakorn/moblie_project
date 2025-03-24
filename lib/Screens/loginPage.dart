import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  bool _passwordVisible = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/forest.jpg"),
                      fit: BoxFit.none,
                      alignment: Alignment.bottomCenter)),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(color: Colors.transparent),
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 40, // ขนาดตัวอักษรหลัก
                            fontWeight: FontWeight.bold,
                            color: Colors.black, // สีของข้อความหลัก
                            shadows: [
                              Shadow(
                                offset: Offset(4, 4), // เงาเลื่อนขวา 4px ลง 4px
                                blurRadius: 20, // ความเบลอของเงา
                                color: Colors.black38, // สีของเงา
                              ),
                            ],
                          ),
                          children: [
                            TextSpan(
                                text: "ต้น",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800)),
                            TextSpan(
                              text: "O", // ตัวเลข 2
                              style: TextStyle(
                                fontSize: 50,
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.w900,
                              ),
                            ), // ข้อความปกติ
                            TextSpan(
                              text: "2", // ตัวเลข 2
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.green,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.7,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(1),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(top: 30),
                                child: ShaderMask(
                                  shaderCallback: (Rect bounds) {
                                    return LinearGradient(
                                            colors: [
                                          Colors.blue,
                                          Colors.purpleAccent
                                        ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight)
                                        .createShader(bounds);
                                  },
                                  child: Text(
                                    "เข้าสู่ระบบ",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                              offset: Offset(1, 0),
                                              blurRadius: 3,
                                              color: Colors.black)
                                        ]),
                                  ),
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 20),
                                child: TextField(
                                  controller: _usernameController,
                                  decoration: InputDecoration(
                                      labelText: 'ชื่อผู้ใช้',
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.8),
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      prefixIcon:
                                          const Icon(Icons.account_circle)),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(
                                        RegExp(r'[ก-๙]'))
                                  ],
                                )),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 20, right: 20, top: 20),
                              child: TextField(
                                obscureText: !_passwordVisible,
                                controller: _passwordController,
                                decoration: InputDecoration(
                                    labelText: 'รหัสผ่าน',
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.8),
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    prefixIcon:
                                        const Icon(Icons.password_rounded),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _passwordVisible =
                                                !_passwordVisible;
                                          });
                                        },
                                        icon: Icon(_passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off))),
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'[ก-๙]')),
                                ],
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 30),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  child: FilledButton(
                                    onPressed: () {},
                                    child: Text(
                                      "เข้าสู่ระบบ",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: BorderSide(
                                              color: Colors.black, width: 1)),
                                    ),
                                  ),
                                )),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 20, right: 20, top: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: Colors.grey,
                                      thickness: 1,
                                      endIndent: 10,
                                    ),
                                  ),
                                  Text(
                                    "หรือ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: Colors.grey,
                                      thickness: 1,
                                      indent: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 20, bottom: 10),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  child: FilledButton(
                                    onPressed: () {
                                      RegisterClick();
                                    },
                                    child: Text(
                                      "สมัครสมาชิก",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: BorderSide(
                                              color: Colors.black, width: 2)),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ],
        ));
  }

  void LoginClick() {}

  void RegisterClick() {
    Navigator.pushNamed(context, '/register-page');
  }
}
