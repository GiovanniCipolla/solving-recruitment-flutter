import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/providers/colloquio_provider.dart';
import 'package:solving_recruitment_flutter/widgets/colloquio_widgets/colloquio_item.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_appbar.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_button_add.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_end_drawer.dart';

class ColloquioScreen extends StatelessWidget {
  static const String routeName = '/colloquio-screen';

  const ColloquioScreen({super.key});

  @override
  Widget build(BuildContext context) { 
    final colloqui = Provider.of<ColloquioProvider>(context).colloqui;
    return Scaffold(
        appBar: const CustomAppbar(title: 'Gestione Colloqui'),
        endDrawer: const CustomEndDrawer(),
        body: Column(children: [
          SizedBox(
            height: heightSize(context) * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceEvenly, // Allinea i pulsanti orizzontalmente
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () {
                  // Aggiungi l'azione da eseguire quando il pulsante "Applica filtri" viene premuto.
                },
                child: const Row(
                  children: [
                    Text('Cerca per'),
                    Icon(
                      Icons.filter_list,
                    )
                  ],
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () {
                  // Aggiungi l'azione da eseguire quando il pulsante "Ordina per" viene premuto.
                },
                child: const Row(
                  children: [
                    Text('Ordina per'),
                    Icon(
                      Icons.sort,
                    )
                  ],
                ),
              ),
            ],
          ),
          Divider(
            color: Theme.of(context).colorScheme.primary,
            thickness: 1.5,
          ),
           Expanded(
              child: SingleChildScrollView(
            child: Column(children: [
              ...colloqui
                  .map((item) => ColloquioItem(colloquio: item))
                  .toList(),
            ]),
          )),
          CustomButtonAdd(
            titleShowDialog: 'Aggiungi Colloquio',
            descrizioneShowDialog: 'Sicuro di voler aggiungere un colloquio?',
            metodoShowDialog: () {},
          )
        ]),
      );}
}
