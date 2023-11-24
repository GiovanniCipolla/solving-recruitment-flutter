import 'package:flutter/material.dart';

class FiltriDialog extends StatelessWidget {
  final Function(String) onSearch;

  const FiltriDialog({super.key, required this.onSearch});
 @override
  Widget build(BuildContext context) {
    String searchValue = ''; // Nuova variabile per memorizzare il valore di ricerca

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nome/Cognome',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              onChanged: (value) {
                searchValue = value;
              },
              decoration: const InputDecoration(
                hintText: 'Inserisci qui...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                onSearch(searchValue);
                Navigator.pop(context);
              },
              child: const Text('Cerca'),
            ),
          ],
        ),
      ),
    );
  }
}