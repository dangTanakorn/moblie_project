import 'package:flutter/material.dart';
import 'package:projcetapp/Model/tree_model.dart';
import 'package:projcetapp/model/plot_model.dart';
import 'package:projcetapp/model/untree_model.dart';
import 'package:projcetapp/model/users_model.dart';
import 'package:projcetapp/Widgets/plotDataWidget.dart';
import 'package:projcetapp/Widgets/unTreesWidget.dart';
import 'package:projcetapp/Services/json_service.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int _index = 0;
  int _selectedIndex = 0;
  final JsonService jsonService = JsonService();
  final ScrollController _scrollController = ScrollController();
  User? user;
  Plot? plot;
  int userID = 1;
  double totelCredit = 0;
  double totelUnTrees = 0;

  void _changeIndex(int value) {
    setState(() {
      _index = value;
      _selectedIndex = value;
    });
    _scrollController.jumpTo(0);
  }

  @override
  void initState() {
    super.initState();
    loadUser(userID);
    loadUserPlots(userID);
    loadUnTrees(userID);
  }

  Future<void> loadPlot(int plotId) async {
    plot = await jsonService.getPlotByPid(plotId);
    setState(() {});
  }

  Future<void> loadUserPlots(int userId) async {
    List<Plot> plots = await jsonService.getPlotsByUser(userId);
    double total = 0.0; // ตัวแปรรวมเครดิตทั้งหมด

    for (var plot in plots) {
      List<Tree> trees = await jsonService.getTreeByPlot(plot.pid);
      double plotCredit = trees.fold(0, (sum, tree) => sum + tree.credit);
      total += plotCredit; // บวกค่าเครดิตของแต่ละ plot
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

  Future<void> loadUser(int userId) async {
    user = await jsonService.getUserById(userId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/colorbackground.png"),
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter)),
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.transparent,
                  Colors.white70,
                  Colors.white
                ])),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Container(
                          width: (MediaQuery.of(context).size.width * 0.5) - 10,
                          height: 60,
                          alignment: Alignment.bottomLeft,
                          child: Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.contain,
                          )),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 60,
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 20, bottom: 5),
                          child: Text(
                            "${user?.fristname} ${user?.lastname}",
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 18),
                          ),
                        )),
                  ],
                ),
              ),
            ),
            Padding(
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              "แปลงทั้งหมด : ${totelCredit.toStringAsFixed(2)} tCO2eq"),
                        )),
                    Padding(
                        padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              "ต้นเดี่ยวทั้งหมด : ${totelUnTrees.toStringAsFixed(2)} tCO2eq"),
                        )),
                  ],
                ),
              ),
            ),
            Container(
              height: 60,
              color: Colors.transparent,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: buildButton(0, "แปลงทั้งหมด"),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: buildButton(1, "ต้นไม้นอกแปลง"),
                  )
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        Offstage(
                          offstage: _index != 0,
                          child: plotdata_Widget(uid: userID),
                        ),
                        Offstage(
                          offstage: _index != 1,
                          child: UnTrees_Widget(uid: userID),
                        )
                      ],
                    ))),
            Container(
              height: 50,
            )
          ],
        ),
      ],
    ));
  }

  Widget buildButton(int index, String text) {
    bool isSelected = _selectedIndex == index;
    return Expanded(
      child: Container(
        color: Colors.transparent,
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5 - 10,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                _changeIndex(index);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isSelected ? Colors.blue[600] : Colors.white,
                foregroundColor: isSelected ? Colors.white : Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                text,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
