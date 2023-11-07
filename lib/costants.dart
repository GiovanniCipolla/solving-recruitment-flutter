import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/models/candidato.dart';
import 'package:solving_recruitment_flutter/models/colloquio.dart';

const urlAPI = 'http://192.168.5.220:8080/api';

void showConfirmationDialog(BuildContext context, String title,
    String description, VoidCallback onConfirm) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(
              color: Theme.of(context).colorScheme.primary,
            ),
            Text(description),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Chiudi il dialog
            },
            child: const Text('Annulla'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Chiudi il dialog
              onConfirm();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                title == 'Conferma eliminazione'
                    ? Colors.red
                    : Theme.of(context).colorScheme.primary,
              ),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: const Text('Conferma'),
          ),
        ],
      );
    },
  );
}

Map<FeedbackColloquio, String> feedbackLabelMap = {
  FeedbackColloquio.ottimo: "Ottimo",
  FeedbackColloquio.buono: "buono",
  FeedbackColloquio.soddisfacente: "Soddisfacente",
  FeedbackColloquio.dubbio: "Dubbio",
  FeedbackColloquio.non_adeguato: "Non adeguato",
};

Map<FeedbackColloquio, Color> feedbackColorMap = {
  FeedbackColloquio.ottimo: Colors.green,
  FeedbackColloquio.buono: Colors.lime,
  FeedbackColloquio.soddisfacente: Colors.yellow,
  FeedbackColloquio.dubbio: Colors.orange,
  FeedbackColloquio.non_adeguato: Colors.red,
};

Map<Tipologia, String> tipologiaMap = {
  Tipologia.conoscitivo: "Conoscitivo",
  Tipologia.tecnico: "Tecnico",
  Tipologia.finale: "Finale",
};

Map<Stato, String> statoCandidatoMap = {
  Stato.SUPERATO: "Superato",
  Stato.RIFIUTATO: "Rifiutato",
  Stato.IN_ATTESA: "In attesa",
};
Map<Stato, Icon> statoCandidatoIconMap = {
  Stato.SUPERATO:
      const Icon(Icons.check, color: Color.fromARGB(255, 20, 218, 27)),
  Stato.RIFIUTATO:
      const Icon(Icons.close, color: Color.fromARGB(255, 209, 65, 55)),
  Stato.IN_ATTESA: const Icon(Icons.watch_later, color: Colors.white),
};
