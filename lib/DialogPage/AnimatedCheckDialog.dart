import 'package:flutter/material.dart';
import 'dart:async';

class AnimatedCheckDialog extends StatefulWidget {
  @override
  _AnimatedCheckDialogState createState() => _AnimatedCheckDialogState();
}

class _AnimatedCheckDialogState extends State<AnimatedCheckDialog> {
  double _opacity = 0.0; // เริ่มต้นโปร่งใส

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0; // ทำให้ไอคอนค่อย ๆ ปรากฏ
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "สมัครเสร็จสิ้น",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          AnimatedOpacity(
            duration: Duration(seconds: 1),
            opacity: _opacity,
            child: Icon(Icons.check_circle,
                color: Colors.green, size: 80), // ไอคอน ✅
          ),
          SizedBox(height: 10),
          Text(
            "กำลังเปลี่ยนหน้า...",
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
