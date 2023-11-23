import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/bottom_sheet_utils.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/dialog_utilies.dart';
import 'package:solving_recruitment_flutter/models/annuncio.dart';
import 'package:solving_recruitment_flutter/models/area.dart';
import 'package:solving_recruitment_flutter/models/candidato.dart';
import 'package:solving_recruitment_flutter/providers/annuncio_provider.dart';
import 'package:solving_recruitment_flutter/providers/candidato_provider.dart';

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
                showLoadingDialog(context);
               final candidatoProvider =  Provider.of<CandidatoProvider>(context, listen: false);
                await candidatoProvider.getCandidatiWithSameArea(area.id!);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
                List<Candidato> candidati =  candidatoProvider.candidati;
                // ignore: use_build_context_synchronously
                BottomSheetUtils.showListCandidati(context, 'Candidati di ${area.denominazione}' ,candidati);
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
                    Icons.touch_app,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () async {
                showLoadingDialog(context);
                final annuncioProvider =  Provider.of<AnnuncioProvider>(context, listen: false);
                await annuncioProvider.getAnnunciByIdArea(area.id!);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
                List<Annuncio> annunci =  annuncioProvider.annunci;
                // ignore: use_build_context_synchronously
                BottomSheetUtils.showListAnnunci(context, 'Annunci di ${area.denominazione}' ,annunci);
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
      ],
    );
  }
}
