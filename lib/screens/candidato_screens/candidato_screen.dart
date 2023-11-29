import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/common.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/dialog_utilies.dart';
import 'package:solving_recruitment_flutter/providers/candidato_provider.dart';
import 'package:solving_recruitment_flutter/screens/candidato_screens/candidato_insert_screen.dart';
import 'package:solving_recruitment_flutter/widgets/candidato_widgets/candidato_item.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_appbar.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_button_add.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_end_drawer.dart';

class CandidatoScreen extends StatelessWidget {
  static const String routeName = '/candidato-screen';

  const CandidatoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool filterActive = false;
    final candidatoProvider =
        Provider.of<CandidatoProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        return backHome(context);
      },
      child: Scaffold(
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
                    openFilterModal(context);
                  },
                  child: const Row(
                    children: [
                      Text('Applica filtri'),
                      Icon(
                        Icons.filter_list,
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: heightSize(context) * 0.02,
            ),
            Expanded(
              child: FutureBuilder(
                future: candidatoProvider.getCandidati(),
                builder: (context, snapshot) {
                  final candidati = candidatoProvider.candidati;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else if (candidati.isEmpty) {
                    return const Center(
                      child: Text(
                        'Non ci sono candidati',
                      ),
                    );
                  } else {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 200.0,
                      ),
                      itemCount: candidati.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CandidatoItem(candidato: candidati[index]);
                      },
                    );
                  }
                },
              ),
            ),
            CustomButtonAdd(
                titleShowDialog: 'Aggiungi candidato',
                descrizioneShowDialog:
                    'Sicuro di voler aggiungere un candidato?',
                metodoShowDialog: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CandidatoInsertScreen(),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
