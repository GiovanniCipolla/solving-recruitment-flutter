import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/bottom_sheet_utils.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/models/annuncio.dart';
import 'package:solving_recruitment_flutter/models/candidato.dart';
import 'package:solving_recruitment_flutter/providers/candidato_provider.dart';
import 'package:solving_recruitment_flutter/screens/annuncio_screens/annuncio_update_screen.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_appbar.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_end_drawer.dart';

class AnnuncioDetailScreen extends StatelessWidget {
  static const String routeName = '/annuncio-detail-screen';

  AnnuncioDetailScreen({super.key, required this.annuncio});

  final Annuncio annuncio;
  final dateFormatter = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: annuncio.titolo!),
      endDrawer: const CustomEndDrawer(),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: heightSize(context) * 0.01),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                      Text(dateFormatter.format(annuncio.dataInizio!)),
                    ]),
                    Row(children: [
                      Text(
                        'Fine : ',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      Text(dateFormatter.format(annuncio.dataFine!)),
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
                onPressed: () {
                  showConfirmationDialog(
                    context,
                    'Conferma eliminazione',
                    'Sicuro di voler eliminare questo annuncio, non potrà più essere usato!',
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
                  await Provider.of<CandidatoProvider>(context, listen: false).getCandidatiByIdAnnuncio(annuncio.id);
                  List<Candidato> candidati = Provider.of<CandidatoProvider>(context, listen: false).candidati;
                    BottomSheetUtils.showListCandidati(context, candidati);
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
        ]),
      ),
      // body: Column(
      //   children: [
      //     SizedBox(height: heightSize(context) * 0.10),
      //     TextButton(
      //       onPressed: () => Navigator.pop(context),
      //       child: Row(
      //         children: [
      //           Icon(Icons.arrow_back),
      //           Text('Torna agli annunci'),
      //         ],
      //       ),
      //     ),
      //     Container(
      //       margin: EdgeInsets.symmetric(horizontal: heightSize(context) * 0.01),
      //       color: Theme.of(context).colorScheme.primary,
      //       child: Column(
      //         children: [
      //           SizedBox(height: heightSize(context) * 0.020),
      //           Text(
      //             annuncio.titolo!,
      //             style: TextStyle(
      //               color: Theme.of(context).colorScheme.onPrimary,
      //               fontSize: heightSize(context) * 0.02,
      //             ),
      //           ),
      //           Divider(
      //             color: Theme.of(context).colorScheme.onPrimary,
      //             thickness: 0.5,
      //           ),
      //           SingleChildScrollView(
      //             child: Text(
      //               annuncio.descrizione!,
      //               style: TextStyle(
      //                 color: Theme.of(context).colorScheme.onPrimary,
      //                 fontSize: heightSize(context) * 0.017,
      //               ),
      //             ),
      //           ),
      //           Divider(
      //             color: Theme.of(context).colorScheme.onPrimary,
      //             thickness: 0.5,
      //           ),
      //           SizedBox(height: heightSize(context) * 0.020),
      //           Column(
      //             children: [
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Padding(
      //                     padding: EdgeInsets.all(heightSize(context) * 0.01),
      //                     child: Column(
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         Row(
      //                           mainAxisAlignment: MainAxisAlignment.start,
      //                           children: [
      //                             Text(
      //                               'Inizio Annuncio : ',
      //                               style: TextStyle(
      //                                 color: Theme.of(context).colorScheme.onPrimary,
      //                               ),
      //                             ),
      //                             Text(
      //                               dateFormatter.format(annuncio.dataInizio!),
      //                               style: TextStyle(
      //                                 color: Theme.of(context).colorScheme.onPrimary,
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                         SizedBox(height: heightSize(context) * 0.01),
      //                         Row(
      //                           mainAxisAlignment: MainAxisAlignment.start,
      //                           children: [
      //                             Text(
      //                               'Fine Annuncio : ',
      //                               style: TextStyle(
      //                                 color: Theme.of(context).colorScheme.onPrimary,
      //                               ),
      //                             ),
      //                             Text(
      //                               dateFormatter.format(annuncio.dataFine!),
      //                               style: TextStyle(
      //                                 color: Theme.of(context).colorScheme.onPrimary,
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                   Padding(
      //                     padding: EdgeInsets.all(heightSize(context) * 0.01),
      //                     child: Column(
      //                       crossAxisAlignment: CrossAxisAlignment.end,
      //                       children: [
      //                         Row(
      //                           children: [
      //                             Text(
      //                               'Area : ',
      //                               style: TextStyle(
      //                                 color: Theme.of(context).colorScheme.onPrimary,
      //                               ),
      //                             ),
      //                             Text(
      //                               annuncio.area!.denominazione!,
      //                               style: TextStyle(
      //                                 color: Theme.of(context).colorScheme.onPrimary,
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                         SizedBox(height: heightSize(context) * 0.01),
      //                         Row(
      //                           children: [
      //                             Text(
      //                               'Tipologia : ',
      //                               style: TextStyle(
      //                                 color: Theme.of(context).colorScheme.onPrimary,
      //                               ),
      //                             ),
      //                             Text(
      //                               annuncio.tipologia!.descrizione!,
      //                               style: TextStyle(
      //                                 color: Theme.of(context).colorScheme.onPrimary,
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //               Divider(
      //                 color: Theme.of(context).colorScheme.onPrimary,
      //                 thickness: 1.5,
      //               ),
      //               SizedBox(height: heightSize(context) * 0.01),
      //               ElevatedButton(
      //                 onPressed: () {},
      //                 child: Row(
      //                   children: [
      //                     Text(
      //                       'Mostra candidati di questo annuncio',
      //                       style: TextStyle(
      //                         color: Theme.of(context).colorScheme.onPrimary,
      //                       ),
      //                     ),
      //                     Icon(
      //                       Icons.chevron_right,
      //                       color: Theme.of(context).colorScheme.onPrimary,
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               SizedBox(height: heightSize(context) * 0.02),
      //             ],
      //           ),
      //         ],
      //       ),
      //     ),
      //     SizedBox(height: heightSize(context) * 0.02),
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       children: [
      //         TextButton(
      //           style: TextButton.styleFrom(
      //             backgroundColor: Theme.of(context).colorScheme.primary,
      //             foregroundColor: Theme.of(context).colorScheme.onPrimary,
      //           ),
      //           onPressed: () {
      //             showConfirmationDialog(
      //               context,
      //               'Modifica Annuncio',
      //               'Sicuro di voler modificare questo annuncio?',
      //                   () {
      //                 Navigator.push(
      //                   context,
      //                   MaterialPageRoute(
      //                     builder: (context) {
      //                       return AnnuncioUpdate(
      //                         annuncio: annuncio,
      //                       );
      //                     },
      //                   ),
      //                 );
      //               },
      //             );
      //           },
      //           child: const Text('Modifica Annuncio'),
      //         ),
      //         TextButton(
      //           style: TextButton.styleFrom(
      //             backgroundColor: Colors.red,
      //             foregroundColor: Theme.of(context).colorScheme.onPrimary,
      //           ),
      //           onPressed: () {
      //             showConfirmationDialog(
      //               context,
      //               'Conferma eliminazione',
      //               'Sicuro di voler eliminare questo annuncio, non potrà più essere usato!',
      //                   () {
      //                 Navigator.push(
      //                   context,
      //                   MaterialPageRoute(
      //                     builder: (context) {
      //                       return AnnuncioUpdate(
      //                         annuncio: annuncio,
      //                       );
      //                     },
      //                   ),
      //                 );
      //               },
      //             );
      //           },
      //           child: const Text('Elimina annuncio'),
      //         ),
      //       ],
      //     ),
      //     SizedBox(height: heightSize(context) * 0.05),
      //     TextButton(
      //       style: TextButton.styleFrom(
      //         backgroundColor: Theme.of(context).colorScheme.primary,
      //         foregroundColor: Theme.of(context).colorScheme.onPrimary,
      //       ),
      //       onPressed: () {
      //         // Add action to be executed when the "Ordina per" button is pressed.
      //       },
      //       child: const Text('Lista Candidati'),
      //     ),
      //   ],
      // ),
    );
  }
}
