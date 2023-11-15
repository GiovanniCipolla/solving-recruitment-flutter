import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/models/tipologia_annuncio.dart';
import 'package:solving_recruitment_flutter/providers/annuncio_provider.dart';
import 'package:solving_recruitment_flutter/screens/annuncio_screens/annuncio_screen.dart';

class TipologiaAnnuncioItem extends StatelessWidget {
  const TipologiaAnnuncioItem({super.key, required this.tipologiaAnnuncio});

  final TipologiaAnnuncio tipologiaAnnuncio;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: heightSize(context) * 0.03),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: widthSize(context) * 0.02),
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
                        tipologiaAnnuncio.descrizione ??
                            "Denominazione mancante",
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
          SizedBox(height: heightSize(context) * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () async {
                  final annuncioProvider =
                      Provider.of<AnnuncioProvider>(context, listen: false);
                  await annuncioProvider.getAnnunciWithSameIdTipolgiaAnnuncio(
                      tipologiaAnnuncio.id!);
                  // ignore: use_build_context_synchronously
                  Navigator.pushNamed(context, AnnuncioScreen.routeName);
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
                      Icons.chevron_right,
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
        ],
      ),
    );
  }
}
