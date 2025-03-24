import 'package:flutter/material.dart';
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
    print(utid);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("ข้อมูลต้นไม้"),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          color: Colors.amber,
        ),
      ),
    );
  }
}
