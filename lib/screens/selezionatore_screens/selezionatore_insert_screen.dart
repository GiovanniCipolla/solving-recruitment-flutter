import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/common.dart';
import 'package:solving_recruitment_flutter/models/selezionatore.dart';
import 'package:solving_recruitment_flutter/providers/selezionatore_provider.dart';

class SelezionatoreInsertScreen extends StatefulWidget {
  const SelezionatoreInsertScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SelezionatoreInsertScreenState();
}

class _SelezionatoreInsertScreenState extends State<SelezionatoreInsertScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController cognomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future<void> inserimentoRiuscito() async {
    final SelezionatoreProvider selezionatoreProvider =
        Provider.of<SelezionatoreProvider>(context, listen: false);
    await selezionatoreProvider.getSelezionatori();
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Inserisci Selezionatore',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    customTextFormFieldWithValidator(nomeController, 'Nome'),
                    customTextFormFieldWithValidator(
                        cognomeController, 'Cognome'),
                    customTextFormFieldWithEmail(emailController, 'E-Mail'),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final selezionatore = Selezionatore(
                            nome: nomeController.text,
                            cognome: cognomeController.text,
                            email: emailController.text,
                          );
                          final result = await Provider.of<SelezionatoreProvider>(
                                  context,
                                  listen: false)
                              .createSelezionatore(selezionatore);
                          result ? inserimentoRiuscito() : null;
                        }
                      },
                      child: const Text('Inserisci'),
                    )
                  ])),
        ));
  }
}
