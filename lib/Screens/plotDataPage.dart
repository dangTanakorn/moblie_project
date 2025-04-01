import 'package:flutter/material.dart';
import 'package:projcetapp/Model/tree_model.dart';
import 'package:projcetapp/Screens/editPlot.dart';
import 'package:projcetapp/Screens/home.dart';
import 'package:projcetapp/Screens/treeData.dart';
import 'package:projcetapp/model/plot_model.dart';
import 'package:projcetapp/Services/json_service.dart';

class Plotdatapage extends StatefulWidget {
  final pid;
  const Plotdatapage({super.key, required this.pid});

  @override
  State<Plotdatapage> createState() => _PlotdatapageState();
}

class _PlotdatapageState extends State<Plotdatapage> {
  final JsonService jsonService = JsonService();
  final ScrollController _scrollController = ScrollController();
  List<Tree> trees = [];
  Plot? plot;
  late int pid;
  double totalCredit = 0;

  @override
  void initState() {
    super.initState();

    pid = widget.pid;

    loadTree(pid);
    loadPlot(pid);
  }

  Future<void> loadTree(int plotId) async {
    List<Tree> tree = await jsonService.getTreeByPlot(plotId);
    totalCredit = tree.fold(0, (sum, tree1) => sum + tree1.credit);
    setState(() {
      trees = tree;
    });
  }

  Future<void> loadPlot(int plotId) async {
    plot = await jsonService.getPlotByPid(plotId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("ข้อมูลแปลง"),
          leading: IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => homePage()),
                    (Route<dynamic> rount) => false);
              },
              icon: Icon(Icons.arrow_back)),
        ),
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
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
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
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditPlot(pid: pid)));
                                  },
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${plot?.name}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24),
                                        ),
                                      )),
                                      Icon(Icons.settings)
                                    ],
                                  ))),
                          Padding(
                              padding:
                                  EdgeInsets.only(top: 3, left: 20, bottom: 10),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "คาร์บอนเครดิต : ${totalCredit.toStringAsFixed(3)} tCO2eq",
                                  style: TextStyle(fontSize: 14),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Container(
                      width: 250,
                      height: 60,
                      child: ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("เพิ่มข้อมูลต้นไม้ "),
                              Icon(Icons.add)
                            ],
                          )),
                    ),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            children: [
                              trees.isEmpty
                                  ? Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      alignment: Alignment.topCenter,
                                      child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Center(
                                          child: Text(
                                            "ไม่มีข้อมูลต้นไม้",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: trees.length,
                                      itemBuilder: (context, index) {
                                        final item = trees[index];
                                        return Padding(
                                          padding: EdgeInsets.all(10),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          TreesData(
                                                              tid: trees[index]
                                                                  .tid)));
                                            },
                                            child: Card(
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                  padding: EdgeInsets.all(15),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "${index + 1} : "
                                                            "${item.name}",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(height: 10),
                                                          Text(
                                                              "คาร์บอนเครดิต : ${item.credit.toStringAsFixed(3)} tCO2eq"),
                                                          SizedBox(height: 5),
                                                        ],
                                                      ),
                                                      Icon(Icons.arrow_forward)
                                                    ],
                                                  )),
                                            ),
                                          ),
                                        );
                                      },
                                    )
                            ],
                          ))),
                ],
              ),
            )
          ],
        ));
  }
}
