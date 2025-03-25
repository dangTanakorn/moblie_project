import 'package:flutter/material.dart';
import 'package:projcetapp/Widgets/SwipWidget.dart';
import 'package:projcetapp/model/plot_model.dart';
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
  final JsonService jsonService = JsonService();
  final ScrollController _scrollController = ScrollController();
  User? user;
  Plot? plot;
  int userID = 1;

  void _changeIndex(int value) {
    setState(() {
      _index = value;
    });
    _scrollController.jumpTo(0);
  }

  @override
  void initState() {
    super.initState();
    loadUser(userID);
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
              padding: EdgeInsets.only(top: 0),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.transparent,
                  Colors.white70,
                  Colors.white
                ])),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 30),
                      child: Container(
                          width: (MediaQuery.of(context).size.width * 0.5) - 10,
                          height: 60,
                          alignment: Alignment.bottomLeft,
                          child: Image.asset(
                            'assets/images/logo.png',
                          )),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 60,
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Text(
                            "${user?.fristname} ${user?.lastname}",
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 14),
                          ),
                        )),
                  ],
                ),
              ),
            ),
            Swip_Widget(uid: userID),
            Row(
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
    bool isSelected = _index == index;
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
