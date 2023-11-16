import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/models/candidato.dart';
import 'package:solving_recruitment_flutter/providers/candidato_provider.dart';
import 'package:solving_recruitment_flutter/screens/candidato_screens/candidato_detail_screen.dart';

class CandidatoItem extends StatelessWidget {
  const CandidatoItem({super.key, required this.candidato});

  final Candidato candidato;
  static const String variabileNulla = 'Errore';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Candidato candidatoDetail = await  Provider.of<CandidatoProvider>(context, listen: false).getCandidato(candidato.id);
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CandidatoDetailScreen(candidato: candidatoDetail);
            },
          ),
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
                      variabileNulla,
                    ),
              ],
            ),
            Divider(
              color: Theme.of(context).colorScheme.onPrimary,
              thickness: 2,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                (
                    candidato.titoloAnnuncio ?? variabileNulla).length > 20
                    ? "${(candidato.titoloAnnuncio ?? variabileNulla).substring(0, 20)}..."
                    : candidato.titoloAnnuncio ?? variabileNulla,
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ]),
            SizedBox(
              height: heightSize(context) * 0.005,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                (candidato.denominazioneArea != null
                                ? candidato.denominazioneArea ??
                                    variabileNulla
                                : variabileNulla)
                            .length >
                        20
                    ? "${(candidato.denominazioneArea?? "Denominazione area mancante").substring(0, 20)}..."
                    : candidato.denominazioneArea ??
                        variabileNulla,
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ]),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  candidato.email ?? variabileNulla,
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
