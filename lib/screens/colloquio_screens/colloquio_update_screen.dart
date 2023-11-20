import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:solving_recruitment_flutter/common.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/models/colloquio.dart';
import 'package:solving_recruitment_flutter/models/selezionatore.dart';

class ColloquioUpdateScreen extends StatefulWidget {
  const ColloquioUpdateScreen({super.key, required this.colloquio});
  final Colloquio colloquio;
  @override
  State<StatefulWidget> createState() => _ColloquioUpdateScreenState();
}

class _ColloquioUpdateScreenState extends State<ColloquioUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nomeCanditato;
  late TextEditingController cognomeCandidato;
  late TextEditingController nomeSelezionatore;
  late TextEditingController cognomeSelezionatore;
  late TextEditingController note;
  late TextEditingController dataController;
  DateTime? data;
  Tipologia? tipologiaSelezionata;
  FeedBackColloquio? feedbackSelezionato;

String formattaData(DateTime data) {
  return DateFormat('dd/MM/yyyy').format(data);
}

  @override
  void initState() {
    super.initState();
    nomeCanditato = TextEditingController(text: widget.colloquio.nomeCandidato);
    cognomeCandidato = TextEditingController(text: widget.colloquio.cognomeCandidato);
    nomeSelezionatore = TextEditingController(text: widget.colloquio.nomeSelezionatore);
    cognomeSelezionatore = TextEditingController(text: widget.colloquio.cognomeSelezionatore);
    note = TextEditingController(text: widget.colloquio.note);
 dataController = TextEditingController(
      text: widget.colloquio.data != null
          ? formattaData(widget.colloquio.data!)
          : '',
    );
    data = widget.colloquio.data;
    tipologiaSelezionata = widget.colloquio.tipologia;
    feedbackSelezionato = widget.colloquio.feedback;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifica colloquio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              customTextFormFieldWithValidator(nomeCanditato, 'Candidato'),
              customTextFormFieldWithValidator(nomeSelezionatore, 'Selezionatore'),
              customTextFormFieldWithoutValidator(note, 'Note'),
               DropdownButtonFormField<Tipologia>(
                  value: tipologiaSelezionata,
                  items: Tipologia.values.map((Tipologia value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(tipologiaMap[value] ?? ''),
                    );
                  }).toList(),
                  onChanged: (Tipologia? value) {
                    if (value != null) {
                      setState(() {
                        tipologiaSelezionata = value;
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Tipologia',
                  ),
                ),
               DropdownButtonFormField<FeedBackColloquio>(
                  value: feedbackSelezionato,
                  items: FeedBackColloquio.values.map((FeedBackColloquio value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(feedbackLabelMap[value] ?? ''),
                    );
                  }).toList(),
                  onChanged: (FeedBackColloquio? value) {
                    if (value != null) {
                      setState(() {
                        feedbackSelezionato = value;
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'FeedBack',
                  ),
                ),
            ]
          ),
          
        ),
      )
    );
  }
}
