import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/models/candidato.dart';
import 'package:solving_recruitment_flutter/widgets/annuncio_widgets/annuncio_detail_item.dart';
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
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
          margin: EdgeInsets.symmetric(horizontal: heightSize(context) * 0.01),
          child: Column(
            children: [
              AnnuncioDetailItem(
                  title: "Email",
                  description: candidato.email ?? "Email mancante"),
              AnnuncioDetailItem(
                title: 'Luogo di Nascita',
                description:
                    candidato.luogoDiNascita ?? "Luogo di Nascita mancante",
              ),
              AnnuncioDetailItem(
                  title: 'Data di Nascita',
                  description: candidato.dataDiNascita != null
                      ? " ${candidato.dataDiNascita!.year} - ${candidato.dataDiNascita!.month} - ${candidato.dataDiNascita!.day}"
                      : 'Data di Nascita mancante'),
              AnnuncioDetailItem(
                title: 'Residenza',
                description: candidato.residenza ?? "Residenza mancante",
              ),
              AnnuncioDetailItem(
                title: 'Recapito Telefonico',
                description: candidato.recapitoTelefonico ??
                    "Recapito Telefonico mancante",
              ),
            ],
          ),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(' Annuncio : '),
            Text(candidato.annuncio!.titolo ?? "Titolo mancante", style: TextStyle(color: Theme.of(context).colorScheme.primary),),
          ],
        ),
        SizedBox(
          height: heightSize(context) * 0.02,
        ),
        const Row(
          children: [
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
      ]),
    );
  }
}
