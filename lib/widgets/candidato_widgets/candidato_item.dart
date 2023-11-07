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
          children: [
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: statoCandidatoIconMap[candidato.stato]!.color,
                  size: 50,
                ),
                Column(
                  children: [
                    Text(
                      candidato.nome,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    Text(
                      candidato.cognome,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                statoCandidatoIconMap[candidato.stato]!,
              ],
            ),
             Divider(
              color: Theme.of(context).colorScheme.onPrimary,
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text(candidato.annuncio.titolo , style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
              ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text(candidato.area.denominazione , style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
              ]
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(candidato.email , style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
              ]
            )
          ]
        )
      ),
    );
  }
}