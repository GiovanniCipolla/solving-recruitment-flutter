import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/common.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/screens/home.dart';
import 'package:solving_recruitment_flutter/widgets/academy_widgets/academy_item_container_widgets.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_end_drawer.dart';

class AcademyScreen extends StatelessWidget {
  static const String routeName = '/academy-screen';

  const AcademyScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return backHome(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Gestione Academy',
            style: TextStyle(color: Colors.red),
          ),
          leading: IconButton(
            icon: const Icon(Icons.home_filled, color: Colors.red),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, Home.routeName, (route) => false);
            },
          ),
        ),
        endDrawer: const CustomEndDrawer(),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: heightSize(context) * 0.04,
            ),
            AcademyItemContainerWidgets(title: 'Academy in corso'),
          ],
        ),
      ),
    );
  }
}
