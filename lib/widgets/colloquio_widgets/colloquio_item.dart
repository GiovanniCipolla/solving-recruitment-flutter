import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/models/colloquio.dart';
import 'package:solving_recruitment_flutter/providers/colloquio_provider.dart';
import 'package:solving_recruitment_flutter/screens/colloquio_screens/colloquio_detail_screen.dart';

class ColloquioItem extends StatelessWidget {
  const ColloquioItem({super.key, required this.colloquio});
  final Colloquio colloquio;

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('yyyy-MM-dd');

    return InkWell(
      onTap: ()async {
final colloquioToSend =await Provider.of<ColloquioProvider>(context, listen: false).getColloquioById(colloquio.id!);
        // ignore: use_build_context_synchronously
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ColloquioDetailScreen(colloquio: colloquioToSend);
        }));
      },
      child: Container(
        margin: EdgeInsets.all(heightSize(context) * 0.01),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 4,
                  child: Row(children: [
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
                ),
                Expanded(
                  flex: 2,
                  child: Column(children: [
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
                ),
                Expanded(
                  flex: 4,
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Text(
                              colloquio.cognomeSelezionatore ?? "Cognome mancante",
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
                              colloquio.nomeSelezionatore ?? "Nome mancante",
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
                  ]),
                )
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
            Divider(
              color: Theme.of(context).colorScheme.primary,
              thickness: 2,
            )
          ],
        ),
      ),
    );
  }
}
