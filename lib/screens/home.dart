import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/common.dart';
import 'package:solving_recruitment_flutter/models/area.dart';
import 'package:solving_recruitment_flutter/providers/area_provider.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_appbar.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_end_drawer.dart';
import 'package:solving_recruitment_flutter/widgets/stats_item_widget.dart';

class Home extends StatelessWidget {
  static const String routeName = '/home-screen';

  @override
  Widget build(BuildContext context) {
    final areaProvider = Provider.of<AreaProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () => showExitDialog(context),
      child: Scaffold(
        appBar: const CustomAppbar(title: 'Solving Recruitment'),
        endDrawer: const CustomEndDrawer(),
        body: Column(
          children: [
            FutureBuilder<StatsArea>(
              future: areaProvider.getStatsArea(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  final statsArea = snapshot.data!; 
                  return Container(
                    margin: const EdgeInsets.all(15),
                    child: StatsItemWidget(stats: statsArea));
                }
              }
            ),
            Text('DA FARE CON ANNUNCI'),
            Text('DA FARE CON TIPOLOGIA ANNUNCI'),
          ],
        ),
      ),
    );
  }

  Color getColor(int index) {
    List<Color> colors = [

      Colors.blue,
      Colors.green,
      Colors.orange,
    ];
    return colors[index % colors.length];
  }
}
