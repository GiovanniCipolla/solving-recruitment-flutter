import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/common.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_appbar.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_end_drawer.dart';

class Home extends StatelessWidget {
  static const String routeName = '/home-screen';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitDialog(context),
      child: Scaffold(
        appBar: const CustomAppbar(title: 'Solving Recruitment'),
        endDrawer: const CustomEndDrawer(),
        body: Center(
          child: Container(
              height: heightSize(context) * 0.8,
              color: Theme.of(context).colorScheme.primary,
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Questa schermata sarà presto disponibile',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 40),
                  ))),
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
