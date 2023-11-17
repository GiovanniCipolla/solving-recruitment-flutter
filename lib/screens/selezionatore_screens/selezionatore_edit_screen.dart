import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/common.dart';
import 'package:solving_recruitment_flutter/models/selezionatore.dart';
import 'package:solving_recruitment_flutter/providers/selezionatore_provider.dart';

class SelezionatoreEditScreen extends StatefulWidget {
  const SelezionatoreEditScreen({super.key, required this.selezionatore});
  final Selezionatore selezionatore;
  @override
  State<SelezionatoreEditScreen> createState() =>
      _SelezionatoreEditScreenState();
}

class _SelezionatoreEditScreenState extends State<SelezionatoreEditScreen> {
  late TextEditingController nomeController;
  late TextEditingController cognomeController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    // Inizializza i controller con i valori correnti del selezionatore
    nomeController = TextEditingController(text: widget.selezionatore.nome);
    cognomeController =
        TextEditingController(text: widget.selezionatore.cognome);
    emailController = TextEditingController(text: widget.selezionatore.email);
  }

  Future<void> modificaRiuscita() async {
    final SelezionatoreProvider selezionatoreProvider =
        Provider.of<SelezionatoreProvider>(context, listen: false);
    await selezionatoreProvider.getSelezionatori();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifica Selezionatore'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            customTextFormFieldWithValidator(nomeController, 'Nome'),
            customTextFormFieldWithValidator(cognomeController, 'Cognome'),
            customTextFormFieldWithEmail(emailController, 'E-Mail'),
            ElevatedButton(
              onPressed: () async {
                final nuovoSelezionatore = Selezionatore(
                  id: widget.selezionatore.id,
                  nome: nomeController.text,
                  cognome: cognomeController.text,
                  email: emailController.text,
                );

                final result = await Provider.of<SelezionatoreProvider>(
                  context,
                  listen: false,
                ).updateSelezionatore(nuovoSelezionatore);

                result ? modificaRiuscita() : null;
              },
              child: const Text('Modifica'),
            ),
          ],
        ),
      ),
    );
  }
}
