import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/models/candidato.dart';
import 'package:solving_recruitment_flutter/widgets/annuncio_widgets/annuncio_detail_item.dart';

class CandidatoDetailScreen extends StatelessWidget {
  const CandidatoDetailScreen({super.key, required this.candidato});

  final Candidato candidato;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dettagli Candidato'),
      ),
      body: Column(children: [
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
                  title: "Stato",
                  description: candidato.stato != null
                      ? statoCandidatoMap[candidato.stato] ??
                          "Valore di fallback"
                      : "Stato mancante"),
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
                title : 'Residenza',
                description: candidato.residenza ?? "Residenza mancante",
              ),
              AnnuncioDetailItem(
                title: 'Recapito Telefonico',
                description: candidato.recapitoTelefonico ?? "Recapito Telefonico mancante",
              ),
              AnnuncioDetailItem(title: 'area', description: candidato.annuncio!.area!.denominazione != null ?  candidato.annuncio!.area!.denominazione! : "Area mancante"),
            ],
          ),
        ),
      ]),
      // body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Text('Nome: ${candidato.nome} ${candidato.cognome}'),
      //       Text('Email: ${candidato.email}'),
      //       SizedBox(height: 16),
      //       Text('Dettagli aggiuntivi:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      //       SizedBox(height: 8),
      //       Text('Luogo di Nascita: ${candidato.luogoDiNascita}'),
      //       Text('Data di Nascita: ${candidato.dataDiNascita?.toLocal()}'),
      //       Text('Residenza: ${candidato.residenza}'),
      //       Text('Recapito Telefonico: ${candidato.recapitoTelefonico}'),
      //       Text('Categoria Protetta: ${candidato.categoriaProtetta ?? false ? 'Sì' : 'No'}'),
      //       Text('RAL: ${candidato.ral}'),
      //       Text('Seniority: ${candidato.seniority?.toString().split('.').last ?? 'N/A'}'),
      //       Text('Disponibilità Lavoro: ${candidato.disponibilitaLavoro?.toString().split('.').last ?? 'N/A'}'),
      //       Text('Data Primo Contatto: ${candidato.dataPrimoContatto?.toLocal()}'),
      //       Text('Percorso Academy: ${candidato.percorsoAcademy?.toString().split('.').last ?? 'N/A'}'),
      //       Text('Note: ${candidato.note ?? 'N/A'}'),
      //       SizedBox(height: 16),
      //       Text('Tecnologie Conosciute:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      //       Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: candidato.tecnologieConosciute?.map((tecnologia) => Text(tecnologia)).toList() ?? [],
      //       ),
      //       SizedBox(height: 16),
      //       Text('Soft Skills:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      //       Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: candidato.softSkills?.map((softSkill) => Text(softSkill)).toList() ?? [],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
