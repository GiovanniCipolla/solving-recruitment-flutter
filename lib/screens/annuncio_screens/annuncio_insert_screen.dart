import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/common.dart';
import 'package:solving_recruitment_flutter/models/annuncio.dart';
import 'package:solving_recruitment_flutter/models/area.dart';
import 'package:solving_recruitment_flutter/models/tipologia_annuncio.dart';
import 'package:solving_recruitment_flutter/providers/annuncio_provider.dart';
import 'package:solving_recruitment_flutter/providers/area_provider.dart';
import 'package:solving_recruitment_flutter/providers/tipologia_annuncio_provider.dart';
import 'package:intl/intl.dart';

class AnnuncioInsertScreen extends StatefulWidget {
  const AnnuncioInsertScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AnnuncioInsertScreenState();
}

class _AnnuncioInsertScreenState extends State<AnnuncioInsertScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titoloController = TextEditingController();
  final TextEditingController descrizioneController = TextEditingController();
  final TextEditingController dataInizioController = TextEditingController();
  DateTime? dataInizio;
  TipologiaAnnuncio? tipologiaAnnuncioSelezionata;
  final TextEditingController tipologiaAnnuncioController =
      TextEditingController();
  Area? areaSelezionata;
  final TextEditingController areaController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dataInizio ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dataInizio) {
      setState(() {
        dataInizio = picked;
        dataInizioController.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> inserimentoRiuscito() async {
    final AnnuncioProvider annuncioProvider =
        Provider.of<AnnuncioProvider>(context, listen: false);
    await annuncioProvider.getAnnunci();
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TipologiaAnnuncioProvider>(context).getTipologiaAnnuncio();
    Provider.of<AreaProvider>(context).getAreas();
    final tipologiaAnnunci =
        Provider.of<TipologiaAnnuncioProvider>(context).tipologiaAnnuncio;
    final areas = Provider.of<AreaProvider>(context).aree;
    return Scaffold(
      appBar: AppBar(
        title: Text('Inserisci Candidato',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                customTextFormFieldWithValidator(titoloController, 'Titolo'),
                customTextFormFieldWithValidator(
                    descrizioneController, 'Descrizione'),
                TextFormField(
                  controller: dataInizioController,
                  decoration: const InputDecoration(
                    labelText: 'Data Inizio',
                  ),
                  onTap: () {
                    _selectDate(context);
                  },
                ),
                DropdownButtonFormField<int>(
                  value: tipologiaAnnuncioSelezionata?.id,
                  items: tipologiaAnnunci
                      .map((TipologiaAnnuncio tipologiaAnnuncio) {
                    return DropdownMenuItem<int>(
                      value: tipologiaAnnuncio.id,
                      child: Text(tipologiaAnnuncio.descrizione ?? 'errore'),
                    );
                  }).toList(),
                  onChanged: (int? value) {
                    if (value != null) {
                      setState(() {
                        tipologiaAnnuncioSelezionata = tipologiaAnnunci
                            .firstWhere((annuncio) => annuncio.id == value);
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Tipologia Annuncio',
                  ),
                ),
                DropdownButtonFormField<int>(
                  value: areaSelezionata?.id,
                  items: areas.map((Area area) {
                    return DropdownMenuItem<int>(
                      value: area.id,
                      child: Text(area.denominazione ?? 'errore'),
                    );
                  }).toList(),
                  onChanged: (int? value) {
                    if (value != null) {
                      setState(() {
                        areaSelezionata =
                            areas.firstWhere((area) => area.id == value);
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Area',
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final annuncio = Annuncio(
                          titolo: titoloController.text,
                          descrizione: descrizioneController.text,
                          dataInizio: (dataInizioController.text.isNotEmpty &&
                                  dataInizio != null)
                              ? DateFormat('dd/MM/yyyy')
                                  .parse(dataInizioController.text)
                              : null,
                          tipologia: tipologiaAnnuncioSelezionata,
                          area: areaSelezionata,
                        );
                        final annuncioProvider =
                            Provider.of<AnnuncioProvider>(context, listen: false);
                        final result =
                            await annuncioProvider.createAnnuncio(annuncio);
                        result ? inserimentoRiuscito() : null;
                      }
                    },
                    child: const Text('Inserisci')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
