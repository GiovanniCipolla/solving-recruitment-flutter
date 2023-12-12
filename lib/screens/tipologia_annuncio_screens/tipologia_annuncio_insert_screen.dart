import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/common.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/models/tipologia_annuncio.dart';
import 'package:solving_recruitment_flutter/providers/tipologia_annuncio_provider.dart';

class TipologiaAnnuncioInsertScreen extends StatefulWidget {
  const TipologiaAnnuncioInsertScreen({super.key});

  @override
  State<TipologiaAnnuncioInsertScreen> createState() =>
      _TipologiaAnnuncioInsertState();
}

class _TipologiaAnnuncioInsertState
    extends State<TipologiaAnnuncioInsertScreen> {
  Future<void> inserimentoRiuscito() async {
    final TipologiaAnnuncioProvider tipologiaAnnuncioProvider =
        Provider.of<TipologiaAnnuncioProvider>(context, listen: false);
    await tipologiaAnnuncioProvider.getTipologiaAnnuncio();
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }
final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    
    final TextEditingController descrizioneController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inserisci Tipologia Annuncio'),
      ),
      body: Form(
        key: formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: heightSize(context) * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              customTextFormFieldWithValidator(
                  descrizioneController, 'Descrizione'),
              ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final TipologiaAnnuncio tipologiaAnnuncio =
                          TipologiaAnnuncio(
                              descrizione: descrizioneController.text);
                      final tipologiaAnnuncioProvider =
                          Provider.of<TipologiaAnnuncioProvider>(context,
                              listen: false);
                      final result = await tipologiaAnnuncioProvider
                          .createTipologiaANnuncio(tipologiaAnnuncio);
                      result ? inserimentoRiuscito() : null;
                    }
                  },
                  child: const Text('Inserisci')),
            ],
          ),
        ),
      ),
    );
  }
}
