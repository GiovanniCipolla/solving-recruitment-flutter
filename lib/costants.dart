import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/models/colloquio.dart';

const urlAPI = 'http://localhost:8080/api';

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
  FeedbackColloquio.ottimo: "ottimo",
  FeedbackColloquio.buono: "buono",
  FeedbackColloquio.soddisfacente: "soddisfacente",
  FeedbackColloquio.dubbio: "dubbio",
  FeedbackColloquio.non_adeguato: "non adeguato",
};

Map<FeedbackColloquio, Color> feedbackColorMap = {
  FeedbackColloquio.ottimo: Colors.green,
  FeedbackColloquio.buono: Colors.lime,
  FeedbackColloquio.soddisfacente: Colors.yellow,
  FeedbackColloquio.dubbio: Colors.orange,
  FeedbackColloquio.non_adeguato: Colors.red,
};

Map<Tipologia, String> tipologiaMap = {
  Tipologia.conoscitivo: "conoscitivo",
  Tipologia.tecnico: "tecnico",
  Tipologia.finale: "finale",
};