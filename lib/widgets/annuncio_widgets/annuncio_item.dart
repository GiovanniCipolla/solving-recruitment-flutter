import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/models/annuncio.dart';
import 'package:intl/intl.dart';

class AnnuncioItem extends StatelessWidget {
  const AnnuncioItem({super.key, required this.annuncio});
  final Annuncio annuncio;

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('yyyy-MM-dd');

    final dynamic? formattedDataFine;       
    
    if (annuncio.dataFine != null) {
      formattedDataFine = dateFormatter.format(annuncio.dataFine!);
    } else {
      formattedDataFine = null;
    }


    return InkWell(
      onTap: () {
       
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
                    annuncio.titolo!.length > 20
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
                  annuncio.area!.denominazione!.length > 20
                      ? '${annuncio.area!.denominazione!.substring(0, 18)}...'
                      : annuncio.area!.denominazione!,
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
                  annuncio.tipologia!.descrizione!.length > 20
                      ? '${annuncio.tipologia!.descrizione!.substring(0, 10)}...'
                      : annuncio.tipologia!.descrizione!,
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
                formattedDataFine ?? 'Data mancante',
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
