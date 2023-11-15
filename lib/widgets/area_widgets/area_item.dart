import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/models/area.dart';
import 'package:solving_recruitment_flutter/providers/annuncio_provider.dart';
import 'package:solving_recruitment_flutter/providers/candidato_provider.dart';
import 'package:solving_recruitment_flutter/screens/annuncio_screens/annuncio_screen.dart';
import 'package:solving_recruitment_flutter/screens/candidato_screens/candidato_screen.dart';

class AreaItem extends StatelessWidget {
  const AreaItem({super.key, required this.area});
  final Area area;
 

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: heightSize(context) * 0.03),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: widthSize(context) * 0.02),
          child: Row(
            children: [
              Icon(
                Icons.category,
                color: Theme.of(context).colorScheme.primary,
                size: 32,
              ),
              SizedBox(width: widthSize(context) * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      area.denominazione ?? "Denominazione mancante",
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Text(
                      area.countAnnunci != null
                          ? '${area.countAnnunci} annunci ancora in corso'
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
               final candidatoProvider =  Provider.of<CandidatoProvider>(context, listen: false);
                await candidatoProvider.getCandidatiWithSameArea(area.id!);
                // ignore: use_build_context_synchronously
                Navigator.pushNamed(context, CandidatoScreen.routeName);
              },
              child: Row(
                children: [
                  Text(
                    'Mostra candidati',
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
            TextButton(
              onPressed: () async {
                final annuncioProvider =  Provider.of<AnnuncioProvider>(context, listen: false);
                await annuncioProvider.getAnnunciByIdArea(area.id!);
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
    );
  }
}
