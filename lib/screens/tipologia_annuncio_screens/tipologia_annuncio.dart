import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/common.dart';
import 'package:solving_recruitment_flutter/providers/tipologia_annuncio_provider.dart';
import 'package:solving_recruitment_flutter/screens/tipologia_annuncio_screens/tipologia_annuncio_insert_screen.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_appbar.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_button_add.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_end_drawer.dart';
import 'package:solving_recruitment_flutter/widgets/tipologia_annuncio_widgets/tipologia_annuncio_item.dart';

class TipologiaAnnuncioScreen extends StatelessWidget {
  static const String routeName = '/tipologia-annuncio-screen';

  const TipologiaAnnuncioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tipologiaANnunci =
        Provider.of<TipologiaAnnuncioProvider>(context).tipologiaAnnuncio;
    return WillPopScope(
      onWillPop: () async {
        return backHome(context);
      },
      child: Scaffold(
        appBar: const CustomAppbar(title: 'Gestione Tipologia Annunci'),
        endDrawer: const CustomEndDrawer(),
        body: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...tipologiaANnunci
                          .map((item) =>
                              TipologiaAnnuncioItem(tipologiaAnnuncio: item))
                          .toList(),
                    ],
                  ),
                ),
              ),
              CustomButtonAdd(
                titleShowDialog: 'Aggiungi Tipologia',
                descrizioneShowDialog:
                    'Sicuro di voler aggiungere una tipologia ?',
                metodoShowDialog: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const TipologiaAnnuncioInsertScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
