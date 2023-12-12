import 'package:flutter/material.dart';

class CustomEmptyItems extends StatelessWidget {
  const CustomEmptyItems({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) => Center(
    child: Text(
      text,
      style: TextStyle(
          color: Theme.of(context).colorScheme.primary, fontSize: 30),
    ),
  );
}
