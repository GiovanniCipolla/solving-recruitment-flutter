import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/common.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/providers/selezionatore_provider.dart';
import 'package:solving_recruitment_flutter/screens/selezionatore_screens/selezionatore_insert_screen.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_appbar.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_button_add.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_end_drawer.dart';
import 'package:solving_recruitment_flutter/widgets/selezionatore_widgets/selezionatore_item.dart';

class SelezionatoreScreen extends StatelessWidget {
  static const String routeName = '/selezionatore-screen';

  const SelezionatoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selezionatori =
        Provider.of<SelezionatoreProvider>(context).selezionatori;

    return WillPopScope(
      onWillPop: () async {
        return backHome(context);
      },
      child: Scaffold(
        appBar: const CustomAppbar(title: 'Gestione Selezionatori'),
        endDrawer: const CustomEndDrawer(),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: heightSize(context) * 0.02),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...selezionatori.map(
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
                  metodoShowDialog: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const SelezionatoreInsertScreen();
                    }));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
