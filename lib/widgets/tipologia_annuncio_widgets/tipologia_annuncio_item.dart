import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/bottom_sheet_utils.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/dialog_utilies.dart';
import 'package:solving_recruitment_flutter/models/annuncio.dart';
import 'package:solving_recruitment_flutter/models/tipologia_annuncio.dart';
import 'package:solving_recruitment_flutter/providers/annuncio_provider.dart';
import 'package:solving_recruitment_flutter/providers/tipologia_annuncio_provider.dart';
import 'package:solving_recruitment_flutter/screens/tipologia_annuncio_screens/tipologia_annuncio.dart';
import 'package:solving_recruitment_flutter/screens/tipologia_annuncio_screens/tipologia_annuncio_update.dart';

class TipologiaAnnuncioItem extends StatelessWidget {
  const TipologiaAnnuncioItem({super.key, required this.tipologiaAnnuncio});

  final TipologiaAnnuncio tipologiaAnnuncio;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: heightSize(context) * 0.03),
      Stack(children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: widthSize(context) * 0.02),
          child: Row(
            children: [
              Icon(
                Icons.work,
                color: Theme.of(context).colorScheme.primary,
                size: 32,
              ),
              SizedBox(width: widthSize(context) * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tipologiaAnnuncio.descrizione ?? "Denominazione mancante",
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Text(
                      tipologiaAnnuncio.countAnnunci != null
                          ? tipologiaAnnuncio.countAnnunci! == 1
                              ? '${tipologiaAnnuncio.countAnnunci} annuncio con questa tipologia'
                              : '${tipologiaAnnuncio.countAnnunci} annunci con questa tipologia'
                          : 'Nessun annuncio in corso',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 5,
          child: IconButton(
            icon: Icon(Icons.settings,
                color: Theme.of(context).colorScheme.primary),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TipologiaAnnuncioUpdateScreen(
                          tipologiaAnnuncio: tipologiaAnnuncio)));
            },
          ),
        ),
      ]),
      SizedBox(height: heightSize(context) * 0.02),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () async {
                final tipologiaAnnuncioProvider =
                    Provider.of<TipologiaAnnuncioProvider>(context,
                        listen: false);
                final result = await tipologiaAnnuncioProvider
                    .deleteTipologiaAnnuncio(tipologiaAnnuncio.id!);
                if (result) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Tipologia annuncio cancellata'),
                  ));
                  // ignore: use_build_context_synchronously
                  Navigator.pushNamedAndRemoveUntil(
                    context, TipologiaAnnuncioScreen.routeName, (route) => false,
                  );
                } else {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Tipologia annuncio non cancellata'),
                  ));
                }
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              )),
          TextButton(
            onPressed: () async {
              showLoadingDialog(context);
              try {
                final annuncioProvider =
                    Provider.of<AnnuncioProvider>(context, listen: false);
                await annuncioProvider.getAnnunciWithSameIdTipolgiaAnnuncio(
                    tipologiaAnnuncio.id!);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
                List<Annuncio> annunci = annuncioProvider.annunci;
                // ignore: use_build_context_synchronously
                BottomSheetUtils.showListAnnunci(
                  context,
                  'Annunci con tipologia: ${tipologiaAnnuncio.descrizione}',
                  annunci,
                );
              } catch (error) {
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Si è verificato un errore durante il recupero degli annunci',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                );
                print('Errore durante il recupero degli annunci: $error');
              }
            },
            child: Row(
              children: [
                Text(
                  'Mostra annunci',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: heightSize(context) * 0.015,
                  ),
                ),
                Icon(
                  Icons.touch_app,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
        ],
      ),
      Divider(
        color: Theme.of(context).colorScheme.primary,
        thickness: 2,
      ),
    ]);
  }
}
