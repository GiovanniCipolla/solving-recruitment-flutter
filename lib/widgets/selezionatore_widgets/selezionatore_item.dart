import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/models/selezionatore.dart';

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
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: widthSize(context) * 0.02),
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
                            selezionatore.nome,
                            style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: widthSize(context) * 0.2,
                          ),
                          Text(
                            selezionatore.cognome,
                            style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.primary,
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
          SizedBox(height: heightSize(context) * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  // Azione da eseguire quando viene premuto il pulsante "Mostra candidati"
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
      ));
}
