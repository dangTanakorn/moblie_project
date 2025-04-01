import 'package:flutter/material.dart';
import 'package:projcetapp/Screens/editUnTree.dart';
import 'package:projcetapp/Screens/home.dart';
import 'package:projcetapp/Services/json_service.dart';
import 'package:projcetapp/model/untree_model.dart';

class UnTreeData extends StatefulWidget {
  final int utid;
  const UnTreeData({super.key, required this.utid});

  @override
  State<UnTreeData> createState() => _UnTreeDataState();
}

class _UnTreeDataState extends State<UnTreeData> {
  final JsonService jsonService = JsonService();
  Untrees? tree;
  late int utid;

  @override
  void initState() {
    super.initState();

    utid = widget.utid;
    loadTree(utid);
  }

  Future<void> loadTree(int unTreeId) async {
    tree = await jsonService.getUnTreeByUtid(unTreeId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          centerTitle: true,
          title: Text("ข้อมูลต้นไม้"),
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
              height: MediaQuery.of(context).size.height - 50,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/colorbackground.png"),
                      fit: BoxFit.cover,
                      alignment: Alignment.bottomCenter)),
            ),
            SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(0.5)),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        width: 100,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          width: 4,
                          color: Colors.black,
                        ))),
                        child: Text(
                          "${tree?.name}",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 150,
                              height: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                width: 2,
                                color: Colors.black,
                              ))),
                              child: Text(
                                "เส้นผ่านศูนย์กลาง : ${tree?.circumference} เซนติเมตร",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                width: 2,
                                color: Colors.black,
                              ))),
                              child: Text(
                                "ความสูง : ${tree?.height} เมตร",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        )),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      child: Container(
                        width: 100,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          width: 4,
                          color: Colors.black,
                        ))),
                        child: Text(
                          "อายุ : ${tree?.age} ปี",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 30,
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          width: 4,
                          color: Colors.black,
                        ))),
                        child: Text(
                          "คาร์บอนเครดิต : ${tree?.credit}  tCO2eq",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width - 100,
                        color: Colors.amber,
                        alignment: Alignment.center,
                        child: Text(
                          "Map",
                          style: TextStyle(fontSize: 36),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: FilledButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditUnTree(utid: utid)));
                          },
                          child: Text(
                            "แก้ไขข้อมูล",
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side:
                                    BorderSide(color: Colors.black, width: 2)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
          ],
        ));
  }
}
