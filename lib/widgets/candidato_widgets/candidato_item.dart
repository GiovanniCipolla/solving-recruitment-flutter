import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/data/data_mock.dart';
import 'package:solving_recruitment_flutter/data/size.dart';

class CandidatoItem extends StatelessWidget {
  const CandidatoItem({super.key, required this.candidato});

  final CandidatoProva candidato;

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
                  color: Theme.of(context).colorScheme.onPrimary,
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
              ],
            ),
             Divider(
              color: Theme.of(context).colorScheme.onPrimary,
              thickness: 2,
            ),
            Row(
              children: [
                Text('Stato : ', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
                Text(candidato.stato.toString(), style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
              ]
            )
          ]
        )
      ),
    );
  }
}