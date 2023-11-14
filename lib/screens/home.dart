import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/common.dart';
import 'package:solving_recruitment_flutter/data/data_mock.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_appbar.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_end_drawer.dart';
import 'package:fl_chart/fl_chart.dart';

class Home extends StatelessWidget {
  static const String routeName = '/home-screen';

 
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitDialog(context),
      child: Scaffold(
        appBar: const CustomAppbar(title: 'Solving Recruitment'),
        endDrawer: const CustomEndDrawer(),
        body: Container(
          margin: const EdgeInsets.all(20),
          child: Center(
            child: PieChart(
              PieChartData(
                sectionsSpace: 5,
                centerSpaceRadius: 50,
                sections: List.generate(
                  areasMock.length,
                  (index) => PieChartSectionData(
                    color: getColor(index),
                    value: areasMock[index].percentuale,
                    title: areasMock[index].denominazione,
                    radius: 100,
                    titleStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            ),
          ),
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