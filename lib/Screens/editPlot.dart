import 'package:flutter/material.dart';
import 'package:projcetapp/Screens/home.dart';
import 'package:projcetapp/Screens/plotDataPage.dart';
import 'package:projcetapp/Services/json_service.dart';
import 'package:projcetapp/model/plot_model.dart';

class EditPlot extends StatefulWidget {
  final int pid;
  const EditPlot({super.key, required this.pid});

  @override
  State<EditPlot> createState() => _EditPlotState();
}

class _EditPlotState extends State<EditPlot> {
  JsonService jsonService = JsonService();
  final TextEditingController _nameController = TextEditingController();

  Plot? plot;
  late int pid;

  @override
  void initState() {
    super.initState();
    pid = widget.pid;
    loadPlot(pid);
  }

  Future<void> loadPlot(int plotID) async {
    plot = await jsonService.getPlotByPid(plotID);
    setState(() {
      _nameController.text = plot?.name ?? "";
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
                      padding: EdgeInsets.all(10),
                      child: Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            width: 4,
                            color: Colors.black,
                          ))),
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: _nameController,
                            decoration: InputDecoration(labelText: "ชื่อแปลง"),
                            style: TextStyle(fontSize: 28),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        height: 400,
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: FilledButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Plotdatapage(pid: pid)));
                              },
                              child: Text(
                                "ยกเลิกการแก้ไข",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Container(
                            height: 50,
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
                                    fontSize: 18, color: Colors.black),
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
