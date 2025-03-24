import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projcetapp/dialogPage/AnimatedCheckDialog.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  //ประกาศตัวแปรเพื่อมาเก็บค่า index, เก็บสถานะของการมองเห็นรหัสผ่าน, เก็บค่าจาก Textfield
  int _Index = 0;
  bool _passwordVisible1 = false;
  bool _passwordVisible2 = false;
  final TextEditingController _fristnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();
  final TextEditingController _passwordcheckController =
      TextEditingController();
  // ตัวแปร ErrorText
  String? _fristName;
  String? _lastName;
  String? _address;
  String? _phone;
  String? _username;
  String? _password;
  @override
  void dispose() {
    _fristnameController.dispose();
    _lastnameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordController2.dispose();
    _passwordcheckController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
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
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 60, bottom: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login-page');
                        },
                        icon: Icon(Icons.arrow_back)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
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
                              "สมัครสมาชิก",
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
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            IndexedStack(
                              index: _Index,
                              children: [step_one(), step_two()],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 50,
                              width: 150,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_Index == 0) {
                                    FocusScope.of(context).unfocus();
                                    Navigator.pushNamed(context, '/login-page');
                                  } else {
                                    FocusScope.of(context).unfocus();
                                    _changeWidget(0);
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      _Index == 0
                                          ? Icons.cancel
                                          : Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      _Index == 0 ? 'ยกเลิก' : 'ย้อนกลับ',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      _Index == 0 ? Colors.blue : Colors.red,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: 150,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_Index == 0) {
                                    FocusScope.of(context).unfocus();
                                    _validate();
                                  } else {
                                    showAutoCloseDialog(context);
                                    FocusScope.of(context).unfocus();
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      _Index == 0
                                          ? Icons.arrow_forward
                                          : Icons.check,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      _Index == 0 ? 'ถัดไป' : 'ยืนยัน',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      _Index == 0 ? Colors.green : Colors.blue,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }

  void _changeWidget(int index) {
    setState(() {
      _Index = index;
    });
  }

  void _validate() {
    setState(() {
      if ([
        _fristnameController,
        _lastnameController,
        _addressController,
        _phoneController,
        _usernameController,
        _passwordController,
        _passwordController2
      ].every((controller) =>
          controller.text.trim().isNotEmpty &&
          _phoneController.text.trim().length == 10 &&
          _passwordController.text.trim() ==
              _passwordController2.text.trim())) {
        // _changeWidget(1);
        _fristName = null;
        _lastName = null;
        _address = null;
        _phone = null;
        _username = null;
        _password = null;

        _changeWidget(1);
      } else {
        if (_fristnameController.text.trim().isEmpty) {
          _fristName = "กรุณากรอกชื่อ";
        } else {
          _fristName = null;
        }
        if (_lastnameController.text.trim().isEmpty) {
          _lastName = "กรุณากรอกนามสกุล";
        } else {
          _lastName = null;
        }
        if (_addressController.text.trim().isEmpty) {
          _address = "กรุณากรอกที่อยู่";
        } else {
          _address = null;
        }
        if (_phoneController.text.trim().isEmpty ||
            _phoneController.text.trim().length != 10) {
          _phone = "เบอร์โทรไม่ถูกต้อง";
        } else {
          _phone = null;
        }
        if (_usernameController.text.trim().isEmpty) {
          _username = "กรุณากรอกชื่อผู้ใช้";
        } else {
          _username = null;
        }
        if (_passwordController.text.trim().isEmpty ||
            _passwordController2.text.trim().isEmpty ||
            _passwordController.text.trim() !=
                _passwordController2.text.trim()) {
          _password = "รหัสผ่านไม่ถูกต้อง";
        } else {
          _password = null;
        }
      }
    });
  }

  Widget step_one() {
    return Container(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _fristnameController,
                  decoration: InputDecoration(
                      labelText: 'ชื่อ',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      prefixIcon: const Icon(Icons.person),
                      errorText: _fristName),
                  onChanged: (value) {
                    setState(() {
                      if (_fristnameController.text.trim().isNotEmpty) {
                        _fristName = null;
                      }
                    });
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _lastnameController,
                  decoration: InputDecoration(
                      labelText: 'นามสกุล',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      errorText: _lastName),
                  onChanged: (value) {
                    setState(() {
                      if (_lastnameController.text.trim().isNotEmpty) {
                        _lastName = null;
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: TextField(
              controller: _addressController,
              decoration: InputDecoration(
                  labelText: 'ที่อยู่',
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  prefixIcon: const Icon(Icons.home_filled),
                  errorText: _address),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              onChanged: (value) {
                setState(() {
                  if (_addressController.text.trim().isNotEmpty) {
                    _address = null;
                  }
                });
              },
            )),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: TextField(
            controller: _phoneController,
            decoration: InputDecoration(
                labelText: 'เบอร์โทร',
                filled: true,
                fillColor: Colors.white.withOpacity(0.8),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                prefixIcon: const Icon(Icons.phone_android_outlined),
                errorText: _phone // แสดงข้อความผิดพลาดที่นี่
                ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10)
            ],
            onChanged: (value) {
              setState(() {
                if (_phoneController.text.trim().isNotEmpty &&
                    _phoneController.text.trim().length == 10) {
                  _phone = null;
                }
              });
            },
          ),
        ),
        Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                  labelText: 'ชื่อผู้ใช้',
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  prefixIcon: const Icon(Icons.account_circle),
                  errorText: _username),
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'[ก-๙]'))
              ],
              onChanged: (value) {
                setState(() {
                  if (_usernameController.text.trim().isNotEmpty) {
                    _username = null;
                  }
                });
              },
            )),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: TextField(
            obscureText: !_passwordVisible1,
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'รหัสผ่าน',
              filled: true,
              fillColor: Colors.white.withOpacity(0.8),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              prefixIcon: const Icon(Icons.password_rounded),
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _passwordVisible1 = !_passwordVisible1;
                    });
                  },
                  icon: Icon(_passwordVisible1
                      ? Icons.visibility
                      : Icons.visibility_off)),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'[ก-๙]')),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: TextField(
            obscureText: !_passwordVisible2,
            controller: _passwordController2,
            decoration: InputDecoration(
                labelText: 'ยืนยันรหัสผ่าน',
                filled: true,
                fillColor: Colors.white.withOpacity(0.8),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                prefixIcon: const Icon(Icons.password_rounded),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _passwordVisible2 = !_passwordVisible2;
                      });
                    },
                    icon: Icon(_passwordVisible2
                        ? Icons.visibility
                        : Icons.visibility_off)),
                errorText: _password),
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'[ก-๙]')),
            ],
            onChanged: (value) {
              setState(() {
                if (_passwordController2.text.trim().isNotEmpty) {
                  _password = null;
                }
              });
            },
          ),
        ),
      ],
    ));
  }

  Widget step_two() {
    return Container(
        child: Column(
      children: [
        Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: TextField(
              controller: _phoneController,
              enabled: false,
              decoration: InputDecoration(
                  labelText: 'เบอร์โทร',
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  prefixIcon: const Icon(Icons.phone_android_outlined)),
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.black),
            )),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _passwordcheckController,
                  decoration: InputDecoration(
                    labelText: 'รหัสยืนยัน',
                    hintText: 'กรอกรหัส 6 หลัก',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6)
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Padding(
                  padding: EdgeInsets.only(),
                  child: SizedBox(
                    width: 80,
                    height: 50,
                    child: FilledButton(
                      onPressed: () {},
                      child: Text(
                        "รับรหัสยืนยัน",
                        style: TextStyle(fontSize: 10),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.black, width: 1),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ],
    ));
  }

  void showAutoCloseDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // ป้องกันการปิดด้วยการแตะด้านนอก
      builder: (BuildContext dialogContext) {
        Future.delayed(Duration(seconds: 5), () {
          if (Navigator.canPop(dialogContext)) {
            Navigator.pop(dialogContext); // ปิด Dialog
          }
          Navigator.pushNamed(context, '/login-page'); // ไปหน้า login
        });

        return AnimatedCheckDialog(); // ส่ง context ให้ฟังก์ชัน
      },
    );
  }
}
