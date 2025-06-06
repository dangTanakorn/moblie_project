import 'package:flutter/material.dart';
import 'package:projcetapp/Model/group_model.dart';
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
  List<Group> groups = [];
  Group? groupname;
  late int utid;
  String? selectedValue;
  bool isLoad = true;

  @override
  void initState() {
    super.initState();

    utid = widget.utid;
    loadTree(utid);
  }

  Future<void> loadTree(int unTreeId) async {
    tree = await jsonService.getUnTreeByUtid(unTreeId);
    loadGroup();
    loadGroupBytree(tree!.id);
    setState(() {
      _nameController.text = tree?.name ?? "";
      _cirController.text = tree?.circumference.toString() ?? "";
      _heightController.text = tree?.height.toString() ?? "";
    });
  }

  Future<void> loadGroup() async {
    List<Group> group = await jsonService.getGroup();
    setState(() {
      groups = group;
      isLoad = false;
    });
  }

  Future<void> loadGroupBytree(int id) async {
    groupname = await jsonService.getGroupById(id);
    setState(() {
      selectedValue = groupname?.name;
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(
                          width: MediaQuery.of(context).size.width - 100,
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
                        padding: EdgeInsets.only(left: 10, bottom: 1, top: 1),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: 40,
                          child: DropdownButton(
                            value: selectedValue,
                            hint: Text(
                                "${selectedValue?.isNotEmpty ?? "เลือกกล่ม"}"),
                            isExpanded: true,
                            items: groups.map((groups) {
                              return DropdownMenuItem<String>(
                                  value: groups.name, child: Text(groups.name));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value;
                              });
                            },
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.all(2),
                      child: Container(
                          width: MediaQuery.of(context).size.width - 100,
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
                          width: MediaQuery.of(context).size.width - 100,
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
                      padding: EdgeInsets.all(5),
                      child: Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width - 50,
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
