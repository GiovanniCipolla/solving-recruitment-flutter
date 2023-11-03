import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/data/data_mock.dart';
import 'package:solving_recruitment_flutter/widgets/area_widgets/area_item.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_appbar.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_button_add.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_end_drawer.dart';

class AreaScreen extends StatelessWidget {
  static const String routeName = '/area-screen';

  const AreaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Gestione Aree'),
      endDrawer: const CustomEndDrawer(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...areasMock.map((item) => AreaItem(area: item)).toList()
                ],
              ),
            ),
          ),
          CustomButtonAdd(
              titleShowDialog: 'Aggiungi Area',
              descrizioneShowDialog: 'Sicuro di voler aggiungere un\' area ?',
              metodoShowDialog: () {}),
        ],
      ),
    );
  }
}
