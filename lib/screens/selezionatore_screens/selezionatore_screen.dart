import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/data/data_mock.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_appbar.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_button_add.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_end_drawer.dart';
import 'package:solving_recruitment_flutter/widgets/selezionatore_widgets/selezionatore_item.dart';

class SelezionatoreScreen extends StatelessWidget {
  static const String routeName = '/selezionatore-screen';

  const SelezionatoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppbar(title: 'Gestione Selezionatori'),
        endDrawer: const CustomEndDrawer(),
        body: Column(mainAxisSize: MainAxisSize.min, children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...selezionatoriMock.map(
                    (item) => SelezionatoreItem(
                      selezionatore: item,
                    ),
                  )
                ],
              ),
            ),
          ),
          CustomButtonAdd(
              titleShowDialog: 'Aggiungi Selezionatore',
              descrizioneShowDialog:
                  'Sicuro di voler aggiungere un selezionatore ?',
              metodoShowDialog: () {}),
        ]));
  }
}
