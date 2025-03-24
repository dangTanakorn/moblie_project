import 'package:flutter/material.dart';
import 'package:projcetapp/Screens/plotDataPage.dart';
import 'package:projcetapp/model/plot_model.dart';
import 'package:projcetapp/Services/json_service.dart';

class plotdata_Widget extends StatefulWidget {
  final int uid;
  const plotdata_Widget({super.key, required this.uid});

  @override
  State<plotdata_Widget> createState() => _plotdata_WidgetState();
}

class _plotdata_WidgetState extends State<plotdata_Widget> {
  final JsonService jsonService = JsonService();
  List<Plot> userPlots = [];
  late int uid;
  @override
  void initState() {
    super.initState();
    uid = widget.uid;
    loadUserPlots(uid);
  }

  Future<void> loadUserPlots(int userId) async {
    List<Plot> plots = await jsonService.getPlotsByUser(userId);
    setState(() {
      userPlots = plots;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: userPlots.length,
      itemBuilder: (context, index) {
        final item = userPlots[index];
        return Padding(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Plotdatapage(
                              pid: userPlots[index].pid,
                            )));
              },
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${item.name}",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                          "คาร์บอนเครดิต : ${item.credit.toStringAsFixed(2)} tCO2eq"),
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
