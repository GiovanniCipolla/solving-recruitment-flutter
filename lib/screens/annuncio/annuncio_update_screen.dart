import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/models/annuncio.dart';

class AnnuncioUpdate extends StatelessWidget {
  final Annuncio annuncio;

  const AnnuncioUpdate({super.key, required this.annuncio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifica Annuncio'),
      ),
      body: Padding(
        padding:  EdgeInsets.all(heightSize(context) * 0.02),  
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              'Titolo:',
              style: TextStyle(fontSize: heightSize(context) * 0.025, fontWeight: FontWeight.bold, color:  Theme.of(context).colorScheme.primary),
            ),
            TextField(
              controller: TextEditingController(text: annuncio.titolo),
              decoration: const InputDecoration(
                hintText: 'Inserisci il titolo dell\'annuncio',
              ),
            ),
            SizedBox(height: heightSize(context) * 0.02),
            Text(
              'Descrizione:',
              style: TextStyle(fontSize: heightSize(context) * 0.025, fontWeight: FontWeight.bold, color:  Theme.of(context).colorScheme.primary),
            ),
            TextField(
              controller: TextEditingController(text: annuncio.descrizione),
              decoration: InputDecoration(
                hintText: 'Inserisci la descrizione dell\'annuncio',
              ),
            ),
            SizedBox(height: heightSize(context) * 0.02),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implementa qui la logica per salvare le modifiche all'annuncio
          // Potresti voler mostrare una conferma o tornare alla schermata precedente.
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
