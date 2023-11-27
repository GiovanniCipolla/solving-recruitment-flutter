import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/common.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/providers/candidato_provider.dart';
import 'package:solving_recruitment_flutter/screens/candidato_screens/candidato_insert_screen.dart';
import 'package:solving_recruitment_flutter/widgets/candidato_widgets/candidato_item.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_appbar.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_button_add.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_end_drawer.dart';

class CandidatoScreen extends StatelessWidget {
  static const String routeName = '/candidato-screen';

  const CandidatoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final candidatoProvider = Provider.of<CandidatoProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        return backHome(context);
      },
      child: Scaffold(
        appBar: const CustomAppbar(
          title: 'Gestione Candidati',
        ),
        endDrawer: const CustomEndDrawer(),
        body: Column(
          children: [
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
                  onPressed: () async {
                    // final String filter = await showDialog(
                    //   context: context,
                    //   builder: (BuildContext context) {
                    //     return FiltriDialog(
                    //       onSearch: (filter) {
                    //         // Non è necessario chiamare il metodo del provider qui
                    //         // Rimuovi la chiamata a getCandidatisearchAndPagination(filter);
                    //         Navigator.pop(context,
                    //             filter); // Chiudi il dialogo e restituisci il filtro
                    //       },
                    //     );
                    //   },
                    // );

                    // // ignore: use_build_context_synchronously
                    // await Provider.of<CandidatoProvider>(context, listen: false)
                    //     .getCandidatisearchAndPagination(filter);
                    showAlertDialog(context);
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
                    // showDialog(
                    //   context: context,
                    //   builder: (BuildContext context) {
                    //     return OrdinamentoDialog(
                    //       onSelected: (value) {
                    //         // Gestisci l'opzione di ordinamento selezionata
                    //       },
                    //       context: context, // Passa il context
                    //     );
                    //   },
                    // );
                    showAlertDialog(context);
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
            SizedBox(
              height: heightSize(context) * 0.02,
            ),
            Expanded(
                child: FutureBuilder(
                    future: candidatoProvider.getCandidati(),
                    builder: (context, snapshot) {
                      final candidati = candidatoProvider.candidati;
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else if (candidati.isEmpty) {
                        return const Center(
                            child: Text(
                          'Non ci sono candidati',
                        ));
                      } else {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: candidati.length,
                          shrinkWrap: true,
                          physics:
                              const ClampingScrollPhysics(), // Questa opzione impedisce il rollio eccessivo
                          itemBuilder: (context, index) {
                            return CandidatoItem(candidato: candidati[index]);
                          },
                        );
                      }
                    })),
            CustomButtonAdd(
                titleShowDialog: 'Aggiungi candidato',
                descrizioneShowDialog:
                    'Sicuro di voler aggiungere un candidato?',
                metodoShowDialog: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CandidatoInsertScreen(),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
