import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/models/candidato.dart';

class CandidatoItem extends StatelessWidget {
  const CandidatoItem({super.key, required this.candidato});

  final Candidato candidato;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.all(heightSize(context) * 0.01),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: statoCandidatoIconMap[candidato.stato]!.color,
                  size: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      candidato.nome ?? "Nome mancante",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    Text(
                      candidato.cognome ?? "Cognome mancante",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                statoCandidatoIconMap[candidato.stato] ??
                    const Text(
                      'Stato mancante',
                    ),
              ],
            ),
            Divider(
              color: Theme.of(context).colorScheme.onPrimary,
              thickness: 2,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                (candidato.annuncio!.titolo ?? "Titolo mancante").length > 20
                    ? "${(candidato.annuncio!.titolo ?? "Titolo mancante").substring(0, 20)}..."
                    : candidato.annuncio!.titolo ?? "Titolo mancante",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ]),
            SizedBox(
              height: heightSize(context) * 0.005,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                (candidato.annuncio!.area != null
                                ? candidato.annuncio!.area!.denominazione ??
                                    "Denominazione area mancante"
                                : "Area mancante")
                            .length >
                        20
                    ? "${(candidato.annuncio!.area!.denominazione ?? "Denominazione area mancante").substring(0, 20)}..."
                    : candidato.annuncio!.area!.denominazione ??
                        "Denominazione area mancante",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ]),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  candidato.email ?? "Email mancante",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
