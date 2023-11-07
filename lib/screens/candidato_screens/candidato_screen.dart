import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/data/data_mock.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/providers/candidato_provider.dart';
import 'package:solving_recruitment_flutter/widgets/candidato_widgets/candidato_item.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_appbar.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_button_add.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_end_drawer.dart';

class CandidatoScreen extends StatelessWidget {
  static const String routeName = '/candidato-screen';

  const CandidatoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final candidatoProvider = Provider.of<CandidatoProvider>(context);
    final candidati = candidatoProvider.candidati;
    return  Scaffold(
      appBar: const CustomAppbar(
        title: 'Gestione Candidati',
      ),
      endDrawer: const CustomEndDrawer(),
       body: Column(
        children: [
          SizedBox(
            height: heightSize(context) * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceEvenly, // Allinea i pulsanti orizzontalmente
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () {
                  // Aggiungi l'azione da eseguire quando il pulsante "Applica filtri" viene premuto.
                },
                child: const Row(
                  children: [
                    Text('Cerca per'),
                    Icon(
                      Icons.filter_list,
                    )
                  ],
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () {
                  // Aggiungi l'azione da eseguire quando il pulsante "Ordina per" viene premuto.
                },
                child: const Row(
                  children: [
                    Text('Ordina per'),
                    Icon(
                      Icons.sort,
                    )
                  ],
                ),
              ),
            ],
          ),
          Divider(
            color: Theme.of(context).colorScheme.primary,
            thickness: 1.5,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: candidati.length,
                shrinkWrap: true,
                physics:
                    const ClampingScrollPhysics(), // Questa opzione impedisce il rollio eccessivo
                itemBuilder: (context, index) {
                  return CandidatoItem(candidato: candidati[index]);
                },
              ),
            ),
          ),
          CustomButtonAdd(
              titleShowDialog: 'Aggiungi candidato',
              descrizioneShowDialog: 'Sicuro di voler aggiungere un candidato?',
              metodoShowDialog: () {}),
        ],
      ),
    );
    
  }
}
