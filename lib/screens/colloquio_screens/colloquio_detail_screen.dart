import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/dialog_utilies.dart';
import 'package:solving_recruitment_flutter/models/colloquio.dart';
import 'package:solving_recruitment_flutter/providers/colloquio_provider.dart';
import 'package:solving_recruitment_flutter/providers/selezionatore_provider.dart';
import 'package:solving_recruitment_flutter/screens/colloquio_screens/colloquio_screen.dart';
import 'package:solving_recruitment_flutter/screens/colloquio_screens/colloquio_update_screen.dart';

class ColloquioDetailScreen extends StatelessWidget {
  const ColloquioDetailScreen({super.key, required this.colloquio});

  final Colloquio colloquio;

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('yyyy-MM-dd');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dettagli Colloquio',
          style: TextStyle(
              fontSize: 25, color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: heightSize(context) * 0.01),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: heightSize(context) * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  SizedBox(
                    width: widthSize(context) * 0.02,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(colloquio.nomeCandidato ?? "Nome mancante",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          )),
                      Row(
                        children: [
                          SizedBox(
                            width: widthSize(context) * 0.015,
                          ),
                          Text(colloquio.cognomeCandidato ?? "Cognome mancante",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              )),
                        ],
                      )
                    ],
                  )
                ]),
                Column(children: [
                  Icon(
                    Icons.assignment,
                    color: Theme.of(context).colorScheme.primary,
                    size: heightSize(context) * 0.04,
                  ),
                  Text(
                    tipologiaMap[colloquio.tipologia] ??
                        "Tipologia mancante", // Utilizza il valore predefinito se tipologiaMap[colloquio.tipologia] è null
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: heightSize(context) * 0.013,
                    ),
                  )
                ]),
                Row(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            colloquio.cognomeSelezionatore ??
                                "cognome mancante",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          SizedBox(
                            width: widthSize(context) * 0.015,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            colloquio.nomeSelezionatore ?? "nome mancante",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          SizedBox(
                            width: widthSize(context) * 0.03,
                          )
                        ],
                      )
                    ],
                  ),
                  Icon(
                    Icons.person_search,
                    color: Theme.of(context).colorScheme.primary,
                  )
                ])
              ],
            ),
            SizedBox(
              height: heightSize(context) * 0.017,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(dateFormatter.format(colloquio.data!),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  )),
              Text(feedbackLabelMap[colloquio.feedback] ?? 'Da svolgere',
                  style: TextStyle(
                    color: feedbackColorMap[colloquio.feedback] ??
                        Theme.of(context).colorScheme.primary,
                  ))
            ]),
            SizedBox(
              height: heightSize(context) * 0.02,
            ),
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: heightSize(context) * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Altri widget...
                  SizedBox(
                    height: heightSize(context) * 0.02, // Spazio tra i widget
                  ),
                  Text(
                    'Note Colloquio ${tipologiaMap[colloquio.tipologia]}:',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: heightSize(context) * 0.025,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SingleChildScrollView(
                    child: TextField(
                      readOnly: true,
                      maxLines: 6,
                      controller: TextEditingController(
                          text: colloquio.note ?? 'Nessuna nota disponibile'),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        contentPadding: const EdgeInsets.all(8.0),
                        hintText: colloquio.note ?? 'Nessuna nota disponibile',
                        hintStyle: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
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
  final SelezionatoreProvider selezionatoreProvider =
      Provider.of<SelezionatoreProvider>(context, listen: false);
  await selezionatoreProvider.getSelezionatori();
  // ignore: use_build_context_synchronously
  Navigator.of(context).pop();
  // ignore: use_build_context_synchronously
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ColloquioUpdateScreen(colloquio: colloquio),
    ),
  );
} catch (error) {
  // ignore: use_build_context_synchronously
  Navigator.pop(context);
  // ignore: use_build_context_synchronously
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text(
        'Si è verificato un errore durante il caricamento dei selezionatori',
        style: TextStyle(color: Colors.red),
      ),
    ),
  );
}

                  },
                  child: const Row(
                    children: [
                      Text('Modifica Colloquio'),
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
                  onPressed:  () async {
                              final result = await  Provider.of<ColloquioProvider>(context, listen: false).deleteColloquio(colloquio.id);
                              if (result) {
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Colloquio eliminato correttamente"),
                                  ),
                                );
                                // ignore: use_build_context_synchronously
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  ColloquioScreen.routeName,
                                  (route) => false,
                                );
                              } else {
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Colloquio non cancellato'),
                                  ),
                                );
                              }
                            },
                  child: const Row(
                    children: [
                      Text('Elimina Colloquio'),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.delete,
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: heightSize(context) * 0.02,
            )
          ],
        ),
      ),
    );
  }
}
