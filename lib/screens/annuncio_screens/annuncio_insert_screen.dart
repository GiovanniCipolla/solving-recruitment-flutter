import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/common.dart';

class AnnuncioInsertScreen extends StatefulWidget {
  const AnnuncioInsertScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AnnuncioInsertScreenState();
}

class _AnnuncioInsertScreenState extends State<AnnuncioInsertScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titoloController = TextEditingController();
  final TextEditingController descrizioneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text('Inserisci Candidato',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor)),
      ),
      body:  SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      customTextFormFieldWithValidator(
                          titoloController, 'Titolo'),
                      customTextFormFieldWithValidator(
                          descrizioneController, 'Descrizione'),
                      ElevatedButton(onPressed: () {}, child: Text('Inserisci')),
                    ]))),
      ),
    );
  }
}
