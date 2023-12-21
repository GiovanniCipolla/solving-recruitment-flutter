import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/data/size.dart';

class AcademyItemAdd extends StatelessWidget {
  const AcademyItemAdd({super.key,});

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
          child: Column(
            children: [
              Icon(Icons.add, color: Colors.red.withOpacity(0.5), size: 60,),
              const Text('Aggiungi una nuova Academy', style: TextStyle(color: Colors.red, fontSize: 16),),
            ],
          )
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
      ],
    );
  }
}
