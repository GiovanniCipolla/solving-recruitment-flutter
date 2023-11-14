import 'package:flutter/material.dart';

class CustomDialogConfirm extends StatelessWidget {
  const CustomDialogConfirm({super.key, required this.text});

  final String text;
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  Text(text),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Si'),
        ),
      ],
    );
  }
}
