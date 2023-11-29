import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/bottom_sheet_utils.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/models/selezionatore.dart';
import 'package:solving_recruitment_flutter/providers/colloquio_provider.dart';
import 'package:solving_recruitment_flutter/providers/selezionatore_provider.dart';
import 'package:solving_recruitment_flutter/screens/selezionatore_screens/selezionatore_edit_screen.dart';
import 'package:solving_recruitment_flutter/screens/selezionatore_screens/selezionatore_screen.dart';

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
                                    color:
                                        Theme.of(context).colorScheme.primary,
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
                                  selezionatore.cognome ?? "Cognome mancante",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color:
                                        Theme.of(context).colorScheme.primary,
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
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.settings,
                            color: Theme.of(context).colorScheme.primary),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelezionatoreEditScreen(
                                      selezionatore: selezionatore)));
                        },
                      ),
                      Consumer<SelezionatoreProvider>(
                        builder: (context, provider, child) {
                          return IconButton(
                            onPressed: () async {
                              final result = await provider
                                  .deleteSelezionatore(selezionatore.id);
                              if (result) {
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Selezionatore eliminato correttamente"),
                                  ),
                                );
                                // ignore: use_build_context_synchronously
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  SelezionatoreScreen.routeName,
                                  (route) => false,
                                );
                              } else {
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Selezionatore non cancellato'),
                                  ),
                                );
                              }
                            },
                            icon: const Icon(Icons.delete, color: Colors.red),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: heightSize(context) * 0.02),
            Text(selezionatore.email ?? "Email mancante",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () async {
                    final colloquioProvider =
                        Provider.of<ColloquioProvider>(context, listen: false);
                    await colloquioProvider
                        .getColloquiBySelezionatore(selezionatore.id);
                    // ignore: use_build_context_synchronously
                    BottomSheetUtils.showListColloqui(
                        context,
                        'Lisa colloqui effetuati da ${selezionatore.nome}',
                        colloquioProvider.colloqui);
                  },
                  child: Row(
                    children: [
                      Text(
                        'Mostra Colloqui Effettuati',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: heightSize(context) * 0.015,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Theme.of(context).colorScheme.primary,
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
