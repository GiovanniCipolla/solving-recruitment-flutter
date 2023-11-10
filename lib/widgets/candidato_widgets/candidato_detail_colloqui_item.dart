import 'package:flutter/material.dart';

class CandidatoDetailColloquiItem extends StatelessWidget {
  const CandidatoDetailColloquiItem({super.key, required this.title, required this.color, required this.icon});

  final String title;
  final Color color;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: color,
      color: color,
      child: Column(
        children: [
          Icon(Icons.assignment, color: Theme.of(context).colorScheme.onPrimary, size: 80,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 15),),
              const SizedBox(width: 5,),
              Icon(icon.icon, color: Theme.of(context).colorScheme.onPrimary),
            ],
          )
        ],
      )
      );
  }
}
