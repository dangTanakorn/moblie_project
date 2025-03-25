import 'package:flutter/material.dart';
import 'package:projcetapp/Widgets/cardCreditWidget.dart';
import 'package:projcetapp/Widgets/chartWidget.dart';

class Swip_Widget extends StatefulWidget {
  final int uid;
  const Swip_Widget({super.key, required this.uid});

  @override
  State<Swip_Widget> createState() => _Swip_WidgetState();
}

class _Swip_WidgetState extends State<Swip_Widget> {
  late int userId;
  int index = 0;
  @override
  void initState() {
    super.initState();

    userId = widget.uid;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> HeadingWidget = [
      CardCredit_Widget(uid: userId),
      Chart_widget()
    ];

    void onSwipe(bool isLeft) {
      setState(() {
        if (isLeft) {
          index = (index + 1) % HeadingWidget.length;
        } else {
          index = (index - 1) % HeadingWidget.length;
        }
      });
    }

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! < 0) {
          onSwipe(true);
        } else if (details.primaryVelocity! > 0) {
          onSwipe(false);
        }
      },
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: HeadingWidget[index],
      ),
    );
  }
}
