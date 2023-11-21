import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/common.dart';
import 'package:solving_recruitment_flutter/models/tipologia_annuncio.dart';
import 'package:solving_recruitment_flutter/providers/tipologia_annuncio_provider.dart';
import 'package:solving_recruitment_flutter/screens/tipologia_annuncio_screens/tipologia_annuncio.dart';

class TipologiaAnnuncioUpdateScreen extends StatefulWidget {
  const TipologiaAnnuncioUpdateScreen(
      {super.key, required this.tipologiaAnnuncio});

  final TipologiaAnnuncio tipologiaAnnuncio;
  @override
  State<TipologiaAnnuncioUpdateScreen> createState() =>
      _TipologiaAnnuncioUpdateScreenState();
}

class _TipologiaAnnuncioUpdateScreenState
    extends State<TipologiaAnnuncioUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController tipologiaAnnuncioController;

  @override
  void initState() {
    super.initState();
    tipologiaAnnuncioController =
        TextEditingController(text: widget.tipologiaAnnuncio.descrizione);
  }

  Future<void> modificaRiuscita(tipologiaAnnuncio) async {
    final TipologiaAnnuncioProvider tipologiaAnnuncioProvider =
        Provider.of<TipologiaAnnuncioProvider>(context, listen: false);
    await tipologiaAnnuncioProvider.getTipologiaAnnuncio();
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => const TipologiaAnnuncioScreen()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Modifica tipologia annuncio',
          style: TextStyle(
              fontSize: 20, color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              customTextFormFieldWithValidator(
                  tipologiaAnnuncioController, 'Descrizione'),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final tipologiaAnnuncio = TipologiaAnnuncio(
                      id: widget.tipologiaAnnuncio.id,
                      descrizione: tipologiaAnnuncioController.text,
                    );
                    final tipologiaAnnuncioProvider =
                        Provider.of<TipologiaAnnuncioProvider>(context,
                            listen: false);
                    final result = await tipologiaAnnuncioProvider
                        .updateTipologiaAnnuncio(tipologiaAnnuncio);

                    // ignore: use_build_context_synchronously
                    result ? modificaRiuscita(tipologiaAnnuncio) : null;
                  }
                },
                child: const Text('Modifica'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
