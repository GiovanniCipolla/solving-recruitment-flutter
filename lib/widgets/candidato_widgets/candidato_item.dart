import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/dialog_utilies.dart';
import 'package:solving_recruitment_flutter/models/candidato.dart';
import 'package:solving_recruitment_flutter/providers/annuncio_provider.dart';
import 'package:solving_recruitment_flutter/providers/area_provider.dart';
import 'package:solving_recruitment_flutter/providers/candidato_provider.dart';
import 'package:solving_recruitment_flutter/screens/candidato_screens/candidato_detail_screen.dart';
import 'package:solving_recruitment_flutter/widgets/custom/wrapped_text.dart';

class CandidatoItem extends StatelessWidget {
  const CandidatoItem({super.key, required this.candidato});

  final Candidato candidato;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        showLoadingDialog(context);
        try {
          Candidato candidatoDetail =
              await Provider.of<CandidatoProvider>(context, listen: false)
                  .getCandidato(candidato.id);
          // ignore: use_build_context_synchronously
          await Provider.of<AreaProvider>(context, listen: false).getAreas();
          // ignore: use_build_context_synchronously
          await Provider.of<AnnuncioProvider>(context, listen: false)
              .getAnnunci();
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CandidatoDetailScreen(candidato: candidatoDetail),
            ),
          );
        } catch (error) {
          print('Errore durante il caricamento del candidato: $error');
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
            ' si è verificato un errore durante il caricamento',
            style: TextStyle(color: Colors.red),
          )));
        }
      },
      child: Container(
        margin: EdgeInsets.all(heightSize(context) * 0.01),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: statoCandidatoIconMap[candidato.stato]!.color ??
                      Colors.red,
                  size: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WrappedText(text: candidato.nome ?? '', limit: 10),
                    WrappedText(text: candidato.cognome ?? '', limit: 10),
                  ],
                ),
                const Spacer(),
              statoCandidatoIconMap[candidato.stato]! 
              ],
            ),
            Divider(
              color: Theme.of(context).colorScheme.onPrimary,
              thickness: 2,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              WrappedText(text: candidato.titoloAnnuncio, limit: 20)
            ]),
            SizedBox(
              height: heightSize(context) * 0.005,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              WrappedText(text: candidato.denominazioneArea, limit: 20)
            ]),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [WrappedText(text: candidato.email, limit: 20)],
            )
          ],
        ),
      ),
    );
  }
}
