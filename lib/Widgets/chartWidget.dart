import 'package:flutter/material.dart';

class Chart_widget extends StatefulWidget {
  const Chart_widget({super.key});

  @override
  State<Chart_widget> createState() => _Chart_widgetState();
}

class _Chart_widgetState extends State<Chart_widget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      color: Colors.white,
    );
  }
}
