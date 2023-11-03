import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/models/annuncio.dart';
import 'package:solving_recruitment_flutter/screens/annuncio_screens/annuncio_update_screen.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_appbar.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_end_drawer.dart';

class AnnuncioDetailScreen extends StatelessWidget {
  static const String routeName = '/annuncio-detail-screen';

  AnnuncioDetailScreen({super.key, required this.annuncio});
  // BISOGNA FARE IL METODO EAGER PER PRENDERE TUTTI I CANDIDATI

  final Annuncio annuncio;

  final dateFormatter = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: annuncio.titolo),
      endDrawer: const CustomEndDrawer(),
      body: Column(
        children: [
          SizedBox(
            height: heightSize(context) * 0.10,
          ),
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Row(
                children: [
                  Icon(Icons.arrow_back),
                  Text('Torna agli annunci'),
                ],
              )),
          Container(
            margin:
                EdgeInsets.symmetric(horizontal: heightSize(context) * 0.01),
            color: Theme.of(context).colorScheme.primary,
            child: Column(children: [
              SizedBox(
                height: heightSize(context) * 0.020,
              ),
              Text(
                annuncio.titolo,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: heightSize(context) * 0.02),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(heightSize(context) * 0.01),
                  height: heightSize(context) * 0.14,
                  margin: EdgeInsets.all(heightSize(context) * 0.01),
                  color: Theme.of(context).colorScheme.onPrimary,
                  child: Text(
                    annuncio.descrizione,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: heightSize(context) * 0.017),
                  ),
                ),
              ),
              SizedBox(
                height: heightSize(context) * 0.020,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(heightSize(context) * 0.01),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Inizio Annuncio : ',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                                  ),
                                  Text(
                                    dateFormatter.format(annuncio.dataInizio),
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                                  ),
                                ]),
                            SizedBox(
                              height: heightSize(context) * 0.01,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Fine Annuncio : ',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                                  ),
                                  Text(
                                    dateFormatter.format(annuncio.dataFine),
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                                  ),
                                ]),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(heightSize(context) * 0.01),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Area : ',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                                  ),
                                  Text(
                                    annuncio.area.denominazione,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: heightSize(context) * 0.01,
                              ),
                              Row(children: [
                                Text(
                                  'Tipologia : ',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                                ),
                                Text(
                                  annuncio.tipologia.descrizione,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                                ),
                              ])
                            ]),
                      )
                    ],
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.onPrimary,
                    thickness: 1.5,
                  ),
                  SizedBox(
                    height: heightSize(context) * 0.01,
                  ),
                  Padding(
                    padding: EdgeInsets.all(heightSize(context) * 0.01),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Candidati all\'annuncio :',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary),
                          ),
                          Text(
                            annuncio.candidati == null
                                ? '0'
                                : annuncio.candidati!.length.toString(),
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary),
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: heightSize(context) * 0.02,
                  ),
                ],
              ),
            ]),
          ),
          SizedBox(
            height: heightSize(context) * 0.02,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return AnnuncioUpdate(
                            annuncio: annuncio,
                          );
                        },
                      ),
                    );
                  },
                );
              },
              child: const Text('Modifica Annuncio'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () {
                showConfirmationDialog(
                  context,
                  'Conferma eliminazione',
                  'Sicuro di voler eliminare questo annuncio, non potrò più essere usato!',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return AnnuncioUpdate(
                            annuncio: annuncio,
                          );
                        },
                      ),
                    );
                  },
                );
              },
              child: const Text('Elimina annuncio'),
            ),
          ]),
          SizedBox(
            height: heightSize(context) * 0.05,
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () {
              // Aggiungi l'azione da eseguire quando il pulsante "Ordina per" viene premuto.
            },
            child: const Text('Lista Candidati'),
          ),
        ],
      ),
    );
  }
}
