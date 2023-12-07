import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/common.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/dialog_utilies.dart';
import 'package:solving_recruitment_flutter/providers/candidato_provider.dart';
import 'package:solving_recruitment_flutter/providers/colloquio_provider.dart';
import 'package:solving_recruitment_flutter/providers/selezionatore_provider.dart';
import 'package:solving_recruitment_flutter/screens/colloquio_screens/colloquio_insert_screen.dart';
import 'package:solving_recruitment_flutter/widgets/colloquio_widgets/colloquio_item.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_appbar.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_button_add.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_end_drawer.dart';

class ColloquioScreen extends StatelessWidget {
  static const String routeName = '/colloquio-screen';

  const ColloquioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colloquiProvider =
        Provider.of<ColloquioProvider>(context, listen: false);
    bool activeFilter = colloquiProvider.filterActive;
    return WillPopScope(
      onWillPop: () {
        return backHome(context);
      },
      child: Scaffold(
        appBar: const CustomAppbar(title: 'Gestione Colloqui'),
        endDrawer: const CustomEndDrawer(),
        body: Column(children: [
          SizedBox(
            height: heightSize(context) * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () async {
                  await Provider.of<CandidatoProvider>(context, listen: false)
                      .getCandidati();
                  // ignore: use_build_context_synchronously
                  await Provider.of<SelezionatoreProvider>(context,
                          listen: false)
                      .getSelezionatori();
                  final filtro =
                      // ignore: use_build_context_synchronously
                      Provider.of<ColloquioProvider>(context, listen: false)
                          .colloquioFiltro;
                  openFilterModalColloquio(context, filtro);
                },
                child: Stack(
                  children: [
                    const Row(
                      children: [
                        Text('Applica filtri'),
                        Icon(
                          Icons.filter_list,
                        )
                      ],
                    ),
                    if (activeFilter)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: const Icon(
                            Icons.brightness_1,
                            color: Colors.white,
                            size: 10,
                          ),
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: heightSize(context) * 0.02,
          ),
          Expanded(
            child: FutureBuilder(
                future: activeFilter
                    ? colloquiProvider
                        .getCandidatiByFilter(colloquiProvider.colloquioFiltro)
                    :  colloquiProvider.getColloqui(),
                builder: (context, snapshot) {
                  final colloqui = colloquiProvider.colloqui;

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else if (colloqui.isEmpty) {
                    return const Center(
                        child: Text(
                      'Non ci sono colloqui',
                    ));
                  } else {
                    return SingleChildScrollView(
                      child: Column(children: [
                        ...colloqui
                            .map((item) => ColloquioItem(colloquio: item))
                            .toList(),
                      ]),
                    );
                  }
                }),
          ),
          CustomButtonAdd(
            titleShowDialog: 'Aggiungi Colloquio',
            descrizioneShowDialog: 'Sicuro di voler aggiungere un colloquio?',
            metodoShowDialog: () async {
              final SelezionatoreProvider selezionatoreProvider =
                  Provider.of<SelezionatoreProvider>(context, listen: false);
              await selezionatoreProvider.getSelezionatori();
              // ignore: use_build_context_synchronously
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const ColloquioInsertScreen();
              }));
            },
          )
        ]),
      ),
    );
  }
}
