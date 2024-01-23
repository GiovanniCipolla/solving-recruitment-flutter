import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/models/academy.dart';

class AcademyItemContainerWidgets extends StatelessWidget {
   AcademyItemContainerWidgets({super.key, required this.academy,});
  final Academy academy;



  final dateFormatter = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(widthSize(context) * 0.05),
          padding: const EdgeInsets.all(10),
          width: widthSize(context) * 0.75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.red, // Colore del bordo
              width: 2.0, // Larghezza del bordo
            ),
          ),
          child:  Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text(
                      'Inizio ',
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                    Text(
               academy.dataInizio != null
                              ? dateFormatter.format(academy.dataInizio!)
                              : 'Errore',
                      
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'Fine ',
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                    Text(
                      academy.dataFine != null
                              ? dateFormatter.format(academy.dataFine!)
                              : 'Errore',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            Column(children: [
              Text(academy.countCandidati.toString(), style: TextStyle(color: Colors.red, fontSize: 16)),
              Text(
                'Candidati',
                style: TextStyle(color: Colors.black, fontSize: 13),
              )
            ]),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image(
                    image: AssetImage('assets/images/logo.png'),
                    width: 25,
                    height: 25),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text(academy.insegnante!),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(Icons.person, color: Colors.red),
                ]),
              ],
            )
          ]),
        ),
        Positioned(
          top: 0,
          right: widthSize(context) * 0.02,
          child: const Icon(
            Icons.school,
            color: Colors.red, // Colore dell'icona
            size: 24.0, // Dimensione dell'icona
          ),
        ),
        Positioned(
          top: -widthSize(context) * 0.01,
          left: widthSize(context) * 0.02,
          child: Text(
            academy.denominazione as String,
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
