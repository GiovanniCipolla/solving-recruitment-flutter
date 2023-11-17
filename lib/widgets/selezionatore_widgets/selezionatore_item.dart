import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/models/selezionatore.dart';
import 'package:solving_recruitment_flutter/screens/selezionatore_screens/selezionatore_edit_screen.dart';

class SelezionatoreItem extends StatelessWidget {
  const SelezionatoreItem({super.key, required this.selezionatore});

  final Selezionatore selezionatore;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: heightSize(context) * 0.03),
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: widthSize(context) * 0.02),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Theme.of(context).colorScheme.primary,
                        size: 50,
                      ),
                      SizedBox(width: widthSize(context) * 0.03),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: widthSize(context) * 0.05,
                                ),
                                Text(
                                  selezionatore.nome ?? "Nome mancante",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary,
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: widthSize(context) * 0.2,
                                ),
                                Text(
                                  selezionatore.cognome ??
                                      "Cognome mancante",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 5,
                  child: IconButton(
                    icon: Icon(Icons.settings, color: Theme.of(context).colorScheme.primary),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SelezionatoreEditScreen(selezionatore: selezionatore)));
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: heightSize(context) * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                    child: Text(selezionatore.email ??
                        "Email mancante",
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .primary))),
                TextButton(
                  onPressed: () {
                    // Azione da eseguire quando viene premuto il pulsante "Mostra candidati"
                  },
                  child: Row(
                    children: [
                      Text(
                        'Mostra Colloqui Effettuati',
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .primary,
                          fontSize: heightSize(context) * 0.015,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Theme.of(context)
                            .colorScheme
                            .primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              color: Theme.of(context).colorScheme.primary,
              thickness: 2,
            ),
          ],
        ),
      );
}
