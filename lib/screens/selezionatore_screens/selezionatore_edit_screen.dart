import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/common.dart';
import 'package:solving_recruitment_flutter/models/selezionatore.dart';
import 'package:solving_recruitment_flutter/providers/selezionatore_provider.dart';
import 'package:solving_recruitment_flutter/screens/selezionatore_screens/selezionatore_screen.dart';

class SelezionatoreEditScreen extends StatefulWidget {
  const SelezionatoreEditScreen({super.key, required this.selezionatore});
  final Selezionatore selezionatore;
  @override
  State<SelezionatoreEditScreen> createState() =>
      _SelezionatoreEditScreenState();
}

class _SelezionatoreEditScreenState extends State<SelezionatoreEditScreen> {
  final _formKey = GlobalKey<FormState>();

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
    Navigator.pushNamedAndRemoveUntil(
        context, SelezionatoreScreen.routeName, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifica Selezionatore'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              customTextFormFieldWithValidator(nomeController, 'Nome'),
              customTextFormFieldWithValidator(cognomeController, 'Cognome'),
              customTextFormFieldWithEmail(emailController, 'E-Mail'),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
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
                  }
                  ;
                },
                child: const Text('Modifica'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
