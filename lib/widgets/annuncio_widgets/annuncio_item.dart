import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/models/annuncio.dart';
import 'package:intl/intl.dart';
import 'package:solving_recruitment_flutter/providers/annuncio_provider.dart';
import 'package:solving_recruitment_flutter/screens/annuncio_screens/annuncio_detail_screen.dart';

class AnnuncioItem extends StatelessWidget {
  const AnnuncioItem({super.key, required this.annuncio});
  final Annuncio annuncio;

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('yyyy-MM-dd');

    final dynamic? formattedDataInizio;

    if (annuncio.dataInizio != null) {
      formattedDataInizio = dateFormatter.format(annuncio.dataInizio!);
    } else {
      formattedDataInizio = null;
    }

    return InkWell(
      onTap: () async {
        Annuncio annuncioDetail =
            await Provider.of<AnnuncioProvider>(context, listen: false)
                .getAnnuncio(annuncio.id);
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return AnnuncioDetailScreen(annuncio: annuncioDetail);
          }),
        );
      },
      child: Container(
        margin: EdgeInsets.all(heightSize(context) * 0.01),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Theme.of(context).colorScheme.onPrimary,
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Text(
                    annuncio.titolo!.length > 18
                        ? '${annuncio.titolo!.substring(0, 18)}...'
                        : annuncio.titolo!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    overflow: TextOverflow
                        .ellipsis, // Aggiungi ellissi se il testo è troppo lungo
                    maxLines: 1, // Limita il testo a 1 riga
                  ),
                ],
              ),
            ),
            Divider(
              color: Theme.of(context).colorScheme.onPrimary,
              thickness: 1.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Area: ',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                Text(
                  annuncio.descrizioneArea == null
                      ? 'Errore'
                      : annuncio.descrizioneArea!.length > 20
                          ? '${annuncio.descrizioneArea!.substring(0, 8)}...'
                          : annuncio.descrizioneArea!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  overflow: TextOverflow
                      .ellipsis, // Aggiungi ellissi se il testo è troppo lungo
                  maxLines: 1, // Limita il testo a 1 riga
                ),
              ],
            ),
            const Divider(
              color: Colors.white,
              thickness: 0.2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tipologia: ',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                Text(
                  annuncio.descrizioneTipologia == null
                      ? 'Errore'
                      : annuncio.descrizioneTipologia!.length > 12
                          ? '${annuncio.descrizioneTipologia!.substring(0, 8)}...'
                          : annuncio.descrizioneTipologia!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  overflow: TextOverflow
                      .ellipsis, // Aggiungi ellissi se il testo è troppo lungo
                  maxLines: 1, // Limita il testo a 1 riga
                ),
              ],
            ),
            const Divider(
              color: Colors.white,
              thickness: 0.2,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                'Fine',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              Text(
                formattedDataInizio ?? 'Data mancante',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              )
            ])
          ],
        ),
      ),
    );
  }
}
