import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/common.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/providers/tipologia_annuncio_provider.dart';
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
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...tipologiaANnunci
                        .map((item) =>
                            TipologiaAnnuncioItem(tipologiaAnnuncio: item))
                        .toList(),
                    SizedBox(
                      height: heightSize(context) * 0.15,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            'Vai alla gestione academy',
                            style: TextStyle(color: Colors.red),
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: widthSize(context) * 0.02,
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 2.0,
                      color: Colors.red,
                    )
                  ],
                ),
              ),
            ),
            CustomButtonAdd(
                titleShowDialog: 'Aggiungi Tipologia',
                descrizioneShowDialog:
                    'Sicuro di voler aggiungere una tipologia ?',
                metodoShowDialog: () {}),
          ],
        ),
      ),
    );
  }
}
