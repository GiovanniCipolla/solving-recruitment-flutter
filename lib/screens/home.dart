import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_appbar.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_end_drawer.dart';

class Home extends StatelessWidget {
  static const String routeName = '/home-screen';

  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Solving Recruitment'),
      endDrawer: const CustomEndDrawer(),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Center(
          child: Text(
            'QUI ANDRANNO GRAFICI CON STATISCHICHE',
            style: TextStyle(
                fontSize: 50, color: Theme.of(context).colorScheme.primary),
          ),
        ),
      ),
    );
  }
}
