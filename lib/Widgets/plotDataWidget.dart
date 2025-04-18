import 'package:flutter/material.dart';
import 'package:projcetapp/Model/tree_model.dart';
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
  List<double> plotCredits = [];
  late int uid;

  @override
  void initState() {
    super.initState();
    uid = widget.uid;
    loadUserPlots(uid);
  }

  Future<void> loadUserPlots(int userId) async {
    List<Plot> plots = await jsonService.getPlotsByUser(userId);
    List<double> credits = [];
    for (var plot in plots) {
      List<Tree> trees = await jsonService.getTreeByPlot(plot.pid);
      double totalCredit = trees.fold(0, (sum, tree) => sum + tree.credit);
      credits.add(totalCredit);
    }

    setState(() {
      userPlots = plots;
      plotCredits = credits;
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
        final credit = plotCredits.isNotEmpty ? plotCredits[index] : 0.0;
        return Padding(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
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
                    padding: EdgeInsets.all(7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${index + 1} : " "${item.name}",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(
                                "คาร์บอนเครดิต : ${credit.toStringAsFixed(2)} tCO2eq"),
                            SizedBox(height: 5),
                          ],
                        ),
                        Icon(Icons.arrow_forward)
                      ],
                    )),
              ),
            ));
      },
    );
  }
}
