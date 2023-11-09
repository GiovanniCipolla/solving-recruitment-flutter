import 'package:flutter/material.dart';

class AnnuncioDetailItem extends StatelessWidget {
  const AnnuncioDetailItem({super.key, required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$title : '),
            Text(description, style: TextStyle(color: Theme.of(context).colorScheme.primary),),
          ]
        ),
        Divider(
          color: Theme.of(context).colorScheme.primary,
          thickness: 0.5,
        )
      ],
    );
  }
}