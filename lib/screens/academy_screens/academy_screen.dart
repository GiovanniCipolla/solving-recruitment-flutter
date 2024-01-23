import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/common.dart';
import 'package:solving_recruitment_flutter/data/data_acadey.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/providers/academy.provider.dart';
import 'package:solving_recruitment_flutter/screens/home.dart';
import 'package:solving_recruitment_flutter/widgets/academy_widgets/academy_item_add_widget.dart';
import 'package:solving_recruitment_flutter/widgets/academy_widgets/academy_item_container_widgets.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_end_drawer.dart';

class AcademyScreen extends StatelessWidget {
  static const String routeName = '/academy-screen';

  const AcademyScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final academyProvider = Provider.of<AcademyProvider>(context, listen: false);
    final academy = academyProvider.academies;
    return WillPopScope(
      onWillPop: () async {
        return backHome(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
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
            // SizedBox(
            //   height: heightSize(context) * 0.04,
            // ),
            //  AcademyItemContainerWidgets(academy: academy[0]),
            // SizedBox(
            //   height: heightSize(context) * 0.015,
            // ),
            SizedBox(
              height: heightSize(context) * 0.21,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: academy.length,
                itemBuilder: (context, index) {
                  return AcademyItemContainerWidgets(
                    academy: academy[index],
                  );
                },
              ),
            ),
            const Icon(Icons.swipe, color: Colors.red),

            // Row(
            //   children: [
            //     Text('Academy recenti', style: TextStyle(color: Colors.red, fontSize: 12)),
            //     Icon( Icons.swipe, color: Colors.red, size: 15,),
            //   ],
            // ),

            SizedBox(
              height: heightSize(context) * 0.05,
            ),
            AcademyItemAdd(),
            const Spacer(),
            TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {},
                child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Tutte le Academy'),
                      Icon(Icons.chevron_right)
                    ])),
            SizedBox(
              height: heightSize(context) * 0.05,
            )
          ],
        ),
      ),
    );
  }
}
