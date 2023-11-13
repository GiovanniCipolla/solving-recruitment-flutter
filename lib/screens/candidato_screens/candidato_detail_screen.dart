import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/bottom_sheet_utils.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/models/candidato.dart';
import 'package:solving_recruitment_flutter/widgets/candidato_widgets/candidato_detail_card_item.dart';
import 'package:solving_recruitment_flutter/widgets/candidato_widgets/candidato_detail_colloqui_item.dart';

class CandidatoDetailScreen extends StatelessWidget {
  const CandidatoDetailScreen({super.key, required this.candidato});

  final Candidato candidato;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dettagli Candidato'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                size: 150,
                color: Theme.of(context).colorScheme.primary,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  candidato.nome ?? "Nome mancante",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: heightSize(context) * 0.03),
                ),
                Text(
                  candidato.cognome ?? "Cognome mancante",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: heightSize(context) * 0.03),
                ),
              ])
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 5,
                ),
                const Text('Area : '),
                Text(
                  candidato.annuncio!.area!.denominazione ?? "Area mancante",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('Stato : '),
              Text(
                candidato.stato != null
                    ? statoCandidatoMap[candidato.stato] ?? "Valore di fallback"
                    : "Stato mancante",
                style: TextStyle(
                    color: statoCandidatoIconMap[candidato.stato]!.color),
              ),
              const SizedBox(
                width: 5,
              ),
            ])
          ]),
          Divider(
            color: Theme.of(context).colorScheme.primary,
            thickness: 4,
          ),
          Container(
            margin:
                EdgeInsets.symmetric(horizontal: heightSize(context) * 0.01),
            child: Column(
              children: [
                CandidatoDetailCardItem(
                  title: 'Scheda anagrafica',
                  onPressed: () {
                   BottomSheetUtils.showSchedaAnagrafica(context,candidato);
                  },
                ),
                SizedBox(
                  height: heightSize(context) * 0.01,
                ),
                CandidatoDetailCardItem(
                  title: 'Competenze tecniche & Soft skills',
                  onPressed: () {
                    BottomSheetUtils.showCompetenze(context,candidato);
                  },
                ),
                 SizedBox(
                  height: heightSize(context) * 0.01,
                ),
                CandidatoDetailCardItem(
                  title: 'Informazioni lavorative',
                  onPressed: () {
                    BottomSheetUtils.showInformazioniLavorative(context,candidato);
                  },
                ),
                 SizedBox(
                  height: heightSize(context) * 0.01,
                ),
                CandidatoDetailCardItem(
                  title: 'Recensioni',
                  onPressed: () {
                    BottomSheetUtils.showRecensiamo(context, candidato);
                  },
                ),
              ],
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Colloqui',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary, fontSize: 20),
              ),
            ],
          ),
          Divider(
            color: Theme.of(context).colorScheme.primary,
            thickness: 2,
          ),
          const Row(children: [
            Expanded(
                child: CandidatoDetailColloquiItem(
                    title: 'Conoscitivo',
                    color: Colors.teal,
                    icon: Icon(
                      Icons.person,
                    ))),
            Expanded(
                child: CandidatoDetailColloquiItem(
                    title: 'Tecnico',
                    color: Colors.orange,
                    icon: Icon(
                      Icons.settings,
                    ))),
            Expanded(
                child: CandidatoDetailColloquiItem(
                    title: 'Finale',
                    color: Colors.green,
                    icon: Icon(
                      Icons.business_center,
                    ))),
          ]),
          Divider(
            color: Theme.of(context).colorScheme.primary,
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () {},
                child: const Row(
                  children: [
                    Text('Modifica Candidato'),
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
                onPressed: () {},
                child: const Row(
                  children: [
                    Text('Elimina candidato'),
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
          )
        ],
      ),
    );
  }
}
