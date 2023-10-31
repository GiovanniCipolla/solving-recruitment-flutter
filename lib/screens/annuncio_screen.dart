import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/providers/annuncio_provider.dart';

class AnnuncioScreen extends StatelessWidget {
  static const String routeName = '/annuncio-screen';
  const AnnuncioScreen({super.key});



  @override
  Widget build(BuildContext context) {
    final annuncioProvider = Provider.of<AnnuncioProvider>(context);
    final annunci = annuncioProvider.annunci;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Elenco Annunci'),
      ),
      body: ListView.builder(
        itemCount: annunci.length,
        itemBuilder: (context, index) {
          final annuncio = annunci[index];
          return ListTile(
            title: Text(annuncio.titolo), // Sostituisci con il campo appropriato del tuo annuncio
            subtitle: Text(annuncio.descrizione), // Sostituisci con il campo appropriato del tuo annuncio
            // Aggiungi altri widget per visualizzare altre informazioni dell'annuncio
          );
        },
      ),
    );
  }
}
