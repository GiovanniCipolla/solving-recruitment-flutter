import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/bottom_sheet_utils.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/dialog_utilies.dart';
import 'package:solving_recruitment_flutter/models/candidato.dart';
import 'package:solving_recruitment_flutter/providers/annuncio_provider.dart';
import 'package:solving_recruitment_flutter/providers/area_provider.dart';
import 'package:solving_recruitment_flutter/providers/candidato_provider.dart';
import 'package:solving_recruitment_flutter/screens/candidato_screens/candidato_update_screen.dart';
import 'package:solving_recruitment_flutter/widgets/candidato_widgets/candidato_detail_card_item.dart';
import 'package:solving_recruitment_flutter/widgets/candidato_widgets/candidato_detail_colloqui_item.dart';

class CandidatoDetailScreen extends StatelessWidget {
  const CandidatoDetailScreen({super.key, required this.candidato});

  final Candidato candidato;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Dettagli Candidato', style: TextStyle(fontSize: 25, color: Theme.of(context).colorScheme.primary)),
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
                  candidato.annuncio != null && candidato.annuncio!.area != null ? 
                  candidato.annuncio!.area!.denominazione ?? "Area mancante " : "Area mancante ",
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
                    BottomSheetUtils.showSchedaAnagrafica(context, candidato);
                  },
                ),
                SizedBox(
                  height: heightSize(context) * 0.01,
                ),
                CandidatoDetailCardItem(
                  title: 'Competenze tecniche & Soft skills',
                  onPressed: () {
                    BottomSheetUtils.showCompetenze(context, candidato);
                  },
                ),
                SizedBox(
                  height: heightSize(context) * 0.01,
                ),
                CandidatoDetailCardItem(
                  title: 'Informazioni lavorative',
                  onPressed: () {
                    BottomSheetUtils.showInformazioniLavorative(
                        context, candidato);
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
          Row(children: [
            Expanded(
              child: CandidatoDetailColloquiItem(
                title: 'Conoscitivo',
                color: Colors.teal,
                icon: const Icon(
                  Icons.person,
                ),
                candidatoId: candidato.id!,
                tipologia: 'CONOSCITIVO',
              ),
            ),
            Expanded(
                child: CandidatoDetailColloquiItem(
              title: 'Tecnico',
              color: Colors.orange,
              icon: const Icon(
                Icons.settings,
              ),
              candidatoId: candidato.id!,
              tipologia: 'TECNICO',
            )),
            Expanded(
                child: CandidatoDetailColloquiItem(
              title: 'Finale',
              color: Colors.green,
              icon: const Icon(
                Icons.business_center,
              ),
              candidatoId: candidato.id!,
              tipologia: 'FINALE',
            ))
          ]),
          SizedBox(
            height: heightSize(context) * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () async {
                showLoadingDialog(context);
try {
  final CandidatoProvider candidatoProvider = Provider.of<CandidatoProvider>(context, listen: false);
  Candidato candidaoToEdit = await candidatoProvider.getCandidato(candidato.id!);
  // ignore: use_build_context_synchronously
  await Provider.of<AreaProvider>(context, listen: false).getAreas();
  // ignore: use_build_context_synchronously
  await Provider.of<AnnuncioProvider>(context, listen: false).getAnnunci();
  // ignore: use_build_context_synchronously
  Navigator.pop(context);
  // ignore: use_build_context_synchronously
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CandidatoUpdateScreen(candidato: candidaoToEdit),
    ),
  );
} catch (error) {
  // ignore: use_build_context_synchronously
  Navigator.pop(context);
  // ignore: use_build_context_synchronously
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text(
        'Si è verificato un errore durante il caricamento',
        style: TextStyle(color: Colors.red),
      ),
    ),
  );
  print('Errore durante il caricamento: $error');
}
                },
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
                onPressed: () async {
                  final result = await Provider.of<CandidatoProvider>(context,
                          listen: false)
                      .deleteCandidato(candidato.id!);
                  if (result) {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Candidato eliminato',
                        ),
                      ),
                    );
                  } else {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Errore durante l\'eliminazione del candidato',
                        ),
                      ),
                    );
                  }
                },
                child: const Row(children: [
                  Text('Elimina candidato'),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.delete,
                  )
                ]),
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
