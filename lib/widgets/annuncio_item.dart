import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/models/annuncio.dart';
import 'package:intl/intl.dart';
import 'package:solving_recruitment_flutter/screens/annuncio/annuncio_detail_screen.dart';

class AnnuncioItem extends StatelessWidget {
  const AnnuncioItem({super.key, required this.annuncio});
  final Annuncio annuncio;

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('yyyy-MM-dd');
    final formattedDataFine = dateFormatter.format(annuncio.dataFine);

    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AnnuncioDetailScreen(annuncio: annuncio);
        }));
      },
      child: Container(
        margin: EdgeInsets.all(heightSize(context) * 0.0130),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Column(
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
                    annuncio.titolo,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
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
                  annuncio.area.denominazione,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
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
                  annuncio.tipologia.descrizione,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
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
                formattedDataFine,
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
