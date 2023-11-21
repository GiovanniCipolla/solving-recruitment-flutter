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

Map<FeedBackColloquio, String> feedbackLabelMap = {
  FeedBackColloquio.OTTIMO: "Ottimo",
  FeedBackColloquio.BUONO: "buono",
  FeedBackColloquio.SODDISFACENTE: "Soddisfacente",
  FeedBackColloquio.DUBBIO: "Dubbio",
  FeedBackColloquio.NON_ADEGUATO: "Non adeguato",
};

Map<FeedBackColloquio, Color> feedbackColorMap = {
  FeedBackColloquio.OTTIMO: Colors.green,
  FeedBackColloquio.BUONO: Colors.lime,
  FeedBackColloquio.SODDISFACENTE: Colors.yellow,
  FeedBackColloquio.DUBBIO: Colors.orange,
  FeedBackColloquio.NON_ADEGUATO: Colors.red,
};

Map<Tipologia, String> tipologiaMap = {
  Tipologia.CONOSCITIVO: "Conoscitivo",
  Tipologia.TECNICO: "Tecnico",
  Tipologia.FINALE: "Finale",
};

Map<Stato, String> statoCandidatoMap = {
  Stato.ASSUNTO: "Superato",
  Stato.RIFIUTATO: "Rifiutato",
  Stato.IN_ATTESA: "In attesa",
  Stato.ND: "Non definito",
  Stato.ISCRITTO: "Iscritto",
};
Map<Stato, Icon> statoCandidatoIconMap = {
  Stato.IDONEO:
      const Icon(Icons.check, color: Color.fromARGB(255, 20, 218, 27)),
  Stato.RIFIUTATO:
      const Icon(Icons.close, color: Color.fromARGB(255, 209, 65, 55)),
  Stato.IN_ATTESA:  const Icon(Icons.watch_later, color: Color.fromARGB(154, 113, 237, 102)),
  Stato.ND:  const Icon(Icons.help_outline, color: Color.fromARGB(255, 243, 143, 21)),
  Stato.ISCRITTO:  const Icon(Icons.check, color: Color.fromARGB(255, 20, 218, 27)),
};

Map<LinguaInglese, String> linguaIngleseMap = {
  LinguaInglese.SCARSO: "Scarso",
  LinguaInglese.SUFFICIENTE: "Sufficiente",
  LinguaInglese.BUONO: "Buono",
  LinguaInglese.OTTIMO: "Ottimo",
  LinguaInglese.ND: "Non adeguato",
};

Map<Seniority, String> seniorityMap = {
  Seniority.JUNIOR: "Junior",
  Seniority.MEDIUM: "Medium",
  Seniority.SENIOR: "Senior",
};

Map<DisponibilitaLavoro, String> disponibilitaLavoroMap = {
  DisponibilitaLavoro.PRESENZA: "Presente",
  DisponibilitaLavoro.REMOTO: "Remoto",
  DisponibilitaLavoro.IBRIDA: "Ibrido",
};