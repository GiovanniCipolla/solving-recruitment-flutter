import 'package:flutter/material.dart';

class WrappedText extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? size;
  final int limit;

  const WrappedText({
    super.key,
    required this.text,
    this.color,
    this.size,
    required this.limit,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      (text ?? 'Errore').length > limit
          ? "${(text ?? 'Errore').substring(0, limit)}..."
          : text ?? 'Errore',
      style: TextStyle(
        color: color ?? Theme.of(context).colorScheme.onPrimary,
        fontSize: size ?? 14.0,
      ),
    );
  }
}
