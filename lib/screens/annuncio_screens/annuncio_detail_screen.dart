import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/bottom_sheet_utils.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/dialog_utilies.dart';
import 'package:solving_recruitment_flutter/models/annuncio.dart';
import 'package:solving_recruitment_flutter/models/candidato.dart';
import 'package:solving_recruitment_flutter/providers/annuncio_provider.dart';
import 'package:solving_recruitment_flutter/providers/area_provider.dart';
import 'package:solving_recruitment_flutter/providers/candidato_provider.dart';
import 'package:solving_recruitment_flutter/screens/annuncio_screens/annuncio_screen.dart';
import 'package:solving_recruitment_flutter/screens/annuncio_screens/annuncio_update_screen.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_end_drawer.dart';

class AnnuncioDetailScreen extends StatelessWidget {
  static const String routeName = '/annuncio-detail-screen';

  AnnuncioDetailScreen({super.key, required this.annuncio});

  final Annuncio annuncio;
  final dateFormatter = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Dettagli Annuncio',
        style: TextStyle(
            fontSize: 25, color: Theme.of(context).colorScheme.primary),
      )),
      endDrawer: const CustomEndDrawer(),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: heightSize(context) * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: heightSize(context) * 0.10),
            Text(
              annuncio.titolo ?? "Titolo mancante",
              style: TextStyle(
                  fontSize: heightSize(context) * 0.02,
                  color: Theme.of(context).colorScheme.primary),
            ),
            SizedBox(
              height: heightSize(context) * 0.02,
            ),
            Container(
              height: heightSize(context) * 0.2,
              width: double.infinity,
              padding: EdgeInsets.all(heightSize(context) * 0.03),
              decoration: BoxDecoration(
                  border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              )),
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Text(
                      annuncio.descrizione ?? "Descrizione mancante",
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Text(
                          'Inizio : ',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        Text(
                          annuncio.dataInizio != null
                              ? dateFormatter.format(annuncio.dataInizio!)
                              : 'Errore',
                        ),
                      ]),
                      Row(children: [
                        Text(annuncio.attivo == true ? 'Attivo' : 'Non attivo',
                            style: TextStyle(
                                color: annuncio.attivo == true
                                    ? Colors.green
                                    : Colors.red))
                      ])
                    ],
                  ),
                ],
              ),
            ),
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
                  onPressed: () {
                    showConfirmationDialog(
                      context,
                      'Modifica Annuncio',
                      'Sicuro di voler modificare questo annuncio?',
                      () async {
                        showLoadingDialog(context);
                        try {
                          await Provider.of<AreaProvider>(context,
                                  listen: false)
                              .getAreas();
                          // ignore: use_build_context_synchronously
                          await Provider.of<AnnuncioProvider>(context,
                                  listen: false)
                              .getAnnunci();
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return AnnuncioUpdateScreen(
                                  annuncio: annuncio,
                                );
                              },
                            ),
                          );
                        } catch (error) {
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Si è verificato un errore durante la modifica dell\'annuncio',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          );
                        }
                      },
                    );
                  },
                  child: const Row(
                    children: [
                      Text('Modifica Annuncio'),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.edit,
                      )
                    ],
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  onPressed: () async {
                    final result = await Provider.of<AnnuncioProvider>(context,
                            listen: false)
                        .deleteAnnuncio(annuncio.id);
                    if (result) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Annuncio eliminato',
                          ),
                        ),
                      );
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamedAndRemoveUntil(
                          context, AnnuncioScreen.routeName, (route) => false);
                    } else {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                        'Errore durante l\'eliminazione dell\'annuncio',
                      )));
                    }
                  },
                  child: const Row(
                    children: [
                      Text('Elimina annuncio'),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.delete,
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: heightSize(context) * 0.05,
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () async {
                try {
                  await Provider.of<CandidatoProvider>(context, listen: false)
                      .getCandidatiByIdAnnuncio(annuncio.id);
                  List<Candidato> candidati =
                      // ignore: use_build_context_synchronously
                      Provider.of<CandidatoProvider>(context, listen: false)
                          .candidati;
                  // ignore: use_build_context_synchronously
                  BottomSheetUtils.showListCandidati(
                    context,
                    'Candidati dell\'annuncio ${annuncio.titolo}',
                    candidati,
                  );
                } catch (error) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Si è verificato un errore durante il recupero dei candidati',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                }
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Lista Candidati'),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.touch_app,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
