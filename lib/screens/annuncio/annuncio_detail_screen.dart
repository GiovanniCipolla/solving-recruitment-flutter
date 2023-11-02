import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:solving_recruitment_flutter/data/drawer_items.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/models/annuncio.dart';
import 'package:solving_recruitment_flutter/screens/home.dart';

class AnnuncioDetailScreen extends StatelessWidget {
  static const String routeName = '/annuncio-detail-screen';

  AnnuncioDetailScreen({super.key, required this.annuncio});
  // BISOGNA FARE IL METODO EAGER PER PRENDERE TUTTI I CANDIDATI

  final Annuncio annuncio;

  final dateFormatter = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(annuncio.titolo),
        leading: IconButton(
          icon: Image.asset("assets/images/logoNavbarCoge.png"),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, Home.routeName, (route) => false);
          },
        ),
      ),
      endDrawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.background,
        child: ListView(
          children: drawerItems.map((item) {
            if (item.containsKey('divider')) {
              return Divider(
                thickness: item['thickness'] ?? 1.0,
              );
            } else {
              return ListTile(
                leading: item['icon'] == Icons.logout
                    ? Icon(item['icon'], color: Colors.red)
                    : Icon(item['icon']),
                title: Text(item['title']),
                onTap: () {
                  item['onTap'](context);
                },
                tileColor: item['color'],
              );
            }
          }).toList(),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: heightSize(context) * 0.10,
          ),
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
                          children: [
                            Row(children: [
                              Text(
                                'Inizio Annuncio :',
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
                            Row(children: [
                              Text(
                                'Fine Annuncio :',
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
                    padding:  EdgeInsets.all(heightSize(context) * 0.01),
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
                // Aggiungi l'azione da eseguire quando il pulsante "Applica filtri" viene premuto.
              },
              child: const Text('Modifica Annuncio'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () {
                // Aggiungi l'azione da eseguire quando il pulsante "Ordina per" viene premuto.
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
