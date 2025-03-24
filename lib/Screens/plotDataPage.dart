import 'package:flutter/material.dart';
import 'package:projcetapp/Model/tree_model.dart';
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

  @override
  void initState() {
    super.initState();

    pid = widget.pid;

    loadTree(pid);
    loadPlot(pid);
  }

  Future<void> loadTree(int plotId) async {
    List<Tree> tree = await jsonService.getTreeByPlot(plotId);
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
                              "${plot?.name}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                          ),
                          Padding(
                              padding:
                                  EdgeInsets.only(top: 3, left: 20, bottom: 10),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "คาร์บอนเครดิต : ${plot?.credit.toStringAsFixed(2)} tCO2eq",
                                  style: TextStyle(fontSize: 16),
                                ),
                              )),
                        ],
                      ),
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
                                          MediaQuery.of(context).size.height -
                                              200,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Center(
                                              child: Text(
                                                "ไม่มีข้อมูลต้นไม้",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Container(
                                                width: 250,
                                                height: 60,
                                                child: ElevatedButton(
                                                  onPressed: () {},
                                                  child:
                                                      Text("เพิ่มข้อมูลต้นไม้"),
                                                ),
                                              ))
                                        ],
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
                                            onTap: () {},
                                            child: Card(
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${item.name}",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                        "คาร์บอนเครดิต : ${item.credit.toStringAsFixed(2)} tCO2eq"),
                                                    SizedBox(height: 5),
                                                  ],
                                                ),
                                              ),
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
