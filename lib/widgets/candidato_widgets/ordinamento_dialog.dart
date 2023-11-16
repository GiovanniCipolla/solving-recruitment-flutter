import 'package:flutter/material.dart';

class OrdinamentoDialog extends StatelessWidget {
  const OrdinamentoDialog({super.key, required this.onSelected, required this.context});

  final Function(String) onSelected;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Ordina per',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            Divider(
              color: Theme.of(context).colorScheme.primary,
              thickness: 2.0,
            ),
            const SizedBox(height: 16.0),
            _opzioneDialog('Età', 'eta'),
            const SizedBox(height: 8.0),
            _opzioneDialog('Data di primo contatto', 'dataPrimoContatto'),
          ],
        ),
      ),
    );
  }

  Widget _opzioneDialog(String label, String valore) {
    return TextButton(
  onPressed: () {
    onSelected(valore);
    Navigator.pop(context);
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.grey.withOpacity(0.35),
    padding: const EdgeInsets.all(12.0),
  ),
  child: Row(
    children: [
      Icon(
        Icons.arrow_forward,
        color: Theme.of(context).colorScheme.primary,
      ),
      const SizedBox(width: 8.0),
      Text(
        label,
        style: TextStyle(color: Theme.of(context).colorScheme.primary, ),
      ),
    ],
  ),
);
  }
}