import 'package:flutter/material.dart';
import 'package:projcetapp/Model/tree_model.dart';
import 'package:projcetapp/Services/json_service.dart';
import 'package:projcetapp/model/plot_model.dart';
import 'package:projcetapp/model/untree_model.dart';

class CardCredit_Widget extends StatefulWidget {
  final int uid;
  const CardCredit_Widget({super.key, required this.uid});

  @override
  State<CardCredit_Widget> createState() => _CardCredit_WidgetState();
}

class _CardCredit_WidgetState extends State<CardCredit_Widget> {
  JsonService jsonService = JsonService();
  late int userID;
  double totelCredit = 0;
  double totelUnTrees = 0;

  @override
  void initState() {
    super.initState();

    userID = widget.uid;
    loadUserPlots(userID);
    loadUnTrees(userID);
  }

  Future<void> loadUserPlots(int userId) async {
    List<Plot> plots = await jsonService.getPlotsByUser(userId);
    double total = 0.0;

    for (var plot in plots) {
      List<Tree> trees = await jsonService.getTreeByPlot(plot.pid);
      double plotCredit = trees.fold(0, (sum, tree) => sum + tree.credit);
      total += plotCredit;
    }

    setState(() {
      totelCredit = total;
    });
  }

  Future<void> loadUnTrees(int userId) async {
    List<Untrees> trees = await jsonService.getUnTreeByUser(userId);
    setState(() {
      totelUnTrees = trees.fold(0, (sum, untree) => sum + untree.credit);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: Offset(5, 5))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                "คาร์บอนเครดิต",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "แปลงทั้งหมด : ${totelCredit.toStringAsFixed(3)} tCO2eq"),
                )),
            Padding(
                padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "ต้นเดี่ยวทั้งหมด : ${totelUnTrees.toStringAsFixed(3)} tCO2eq"),
                )),
          ],
        ),
      ),
    );
  }
}
