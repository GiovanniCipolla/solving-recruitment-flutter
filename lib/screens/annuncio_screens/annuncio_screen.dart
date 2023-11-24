import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/common.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/providers/annuncio_provider.dart';
import 'package:solving_recruitment_flutter/screens/annuncio_screens/annuncio_insert_screen.dart';
import 'package:solving_recruitment_flutter/widgets/annuncio_widgets/annuncio_item.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_appbar.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_button_add.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_end_drawer.dart';

class AnnuncioScreen extends StatelessWidget {
  static const String routeName = '/annuncio-screen';
  const AnnuncioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final annuncioProvider =
        Provider.of<AnnuncioProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        return backHome(context);
      },
      child: Scaffold(
        appBar: const CustomAppbar(title: 'Gestione annunci'),
        endDrawer: const CustomEndDrawer(),
        body: Column(
          children: [
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
                  onPressed: () {
                    showAlertDialog(context);
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
                    showAlertDialog(context);
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
            SizedBox(
              height: heightSize(context) * 0.02,
            ),
            Expanded(
                child: FutureBuilder(
                    future: annuncioProvider.getAnnunci(),
                    builder: (context, snapshot) {
                      final annunci = annuncioProvider.annunci;
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else if (annunci.isEmpty) {
                        return const Center(
                            child: Text(
                          'Non ci sono annunci',
                        ));
                      } else {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: annunci.length,
                          shrinkWrap: true,
                          physics:
                              const ClampingScrollPhysics(), // Questa opzione impedisce il rollio eccessivo
                          itemBuilder: (context, index) {
                            return AnnuncioItem(annuncio: annunci[index]);
                          },
                        );
                      }
                    })),
            CustomButtonAdd(
                titleShowDialog: 'Aggiungi annuncio',
                descrizioneShowDialog:
                    'Sicuro di voler aggiungere un annuncio?',
                metodoShowDialog: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AnnuncioInsertScreen()));
                }),
          ],
        ),
      ),
    );
  }
}
