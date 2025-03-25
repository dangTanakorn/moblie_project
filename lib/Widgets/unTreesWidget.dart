import 'package:flutter/material.dart';
import 'package:projcetapp/Screens/unTreesData.dart';
import 'package:projcetapp/model/untree_model.dart';
import 'package:projcetapp/Services/json_service.dart';

class UnTrees_Widget extends StatefulWidget {
  final int uid;
  const UnTrees_Widget({super.key, required this.uid});

  @override
  State<UnTrees_Widget> createState() => _UnTrees_WidggetState();
}

class _UnTrees_WidggetState extends State<UnTrees_Widget> {
  final JsonService jsonService = JsonService();
  List<Untrees> userTrees = [];
  late int uid;

  @override
  void initState() {
    super.initState();
    uid = widget.uid;
    loadUserTrees(uid);
  }

  Future<void> loadUserTrees(int userId) async {
    List<Untrees> tree = await jsonService.getUnTreeByUser(userId);
    setState(() {
      userTrees = tree;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: userTrees.length,
      itemBuilder: (context, index) {
        final item = userTrees[index];
        return Padding(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            UnTreeData(utid: userTrees[index].utid)));
              },
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${index + 1} : " "${item.name}",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                          "คาร์บอนเครดิต : ${item.credit.toStringAsFixed(3)} tCO2eq"),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
