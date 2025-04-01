import 'package:flutter/material.dart';
import 'package:projcetapp/Screens/home.dart';
import 'package:projcetapp/Screens/unTreesData.dart';
import 'package:projcetapp/Services/json_service.dart';
import 'package:projcetapp/model/untree_model.dart';

class EditUnTree extends StatefulWidget {
  final int utid;
  const EditUnTree({super.key, required this.utid});

  @override
  State<EditUnTree> createState() => _EditUnTreeState();
}

class _EditUnTreeState extends State<EditUnTree> {
  final JsonService jsonService = JsonService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cirController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

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
    setState(() {
      _nameController.text = tree?.name ?? "";
      _cirController.text = tree?.circumference.toString() ?? "";
      _heightController.text = tree?.height.toString() ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          centerTitle: true,
          title: Text("แก้ไขข้อมูล"),
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
                      padding: EdgeInsets.all(5),
                      child: Container(
                          width: 150,
                          height: 60,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            width: 4,
                            color: Colors.black,
                          ))),
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: _nameController,
                            decoration:
                                InputDecoration(labelText: "ชื่อต้นไม้"),
                            style: TextStyle(fontSize: 28),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.all(2),
                      child: Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            width: 2,
                            color: Colors.black,
                          ))),
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: _cirController,
                            decoration: InputDecoration(
                                labelText: "เส้นผ่านศุนย์กลาง (เซนติเมตร)"),
                            style: TextStyle(fontSize: 16),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.all(2),
                      child: Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            width: 2,
                            color: Colors.black,
                          ))),
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: _heightController,
                            decoration:
                                InputDecoration(labelText: "ส่วนสูง (เมตร)"),
                            style: TextStyle(fontSize: 16),
                          )),
                    ),
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
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(top: 10, bottom: 10, left: 10),
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.4,
                            alignment: Alignment.center,
                            child: FilledButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UnTreeData(utid: utid)));
                              },
                              child: Text(
                                "ยกเลิกการแก้ไข",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                        color: Colors.black, width: 2)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 10, bottom: 10, right: 10),
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.4,
                            alignment: Alignment.center,
                            child: FilledButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => homePage()),
                                    (Route<dynamic> rount) => false);
                              },
                              child: Text(
                                "บันทึกข้อมูล",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                        color: Colors.black, width: 2)),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )),
          ],
        ));
  }
}
