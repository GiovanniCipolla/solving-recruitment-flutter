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
import 'package:solving_recruitment_flutter/screens/annuncio_screens/annuncio_detail_screen.dart';

class AnnuncioUpdateScreen extends StatefulWidget {
  const AnnuncioUpdateScreen({super.key, required this.annuncio});
  final Annuncio annuncio;

  @override
  State<AnnuncioUpdateScreen> createState() => _AnnuncioUpdateScreenState();
}

class _AnnuncioUpdateScreenState extends State<AnnuncioUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController titoloController;
  late TextEditingController descrizioneController;
  late TextEditingController dataInizioController;
  DateTime? dataInizio;
  TipologiaAnnuncio? tipologiaAnnuncioSelezionata;
  Area? areaSelezionata;

  @override
  void initState() {
    super.initState();
    titoloController = TextEditingController(text: widget.annuncio.titolo);
    descrizioneController =
        TextEditingController(text: widget.annuncio.descrizione);
    dataInizioController = TextEditingController(
      text: widget.annuncio.dataInizio != null
          ? DateFormat('dd/MM/yyyy').format(widget.annuncio.dataInizio!)
          : '',
    );
    dataInizio = widget.annuncio.dataInizio;
    tipologiaAnnuncioSelezionata = widget.annuncio.tipologia;
    areaSelezionata = widget.annuncio.area;
  }

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

  Future<void> modificaRiuscita(annuncio) async {
    final AnnuncioProvider annuncioProvider =
        Provider.of<AnnuncioProvider>(context, listen: false);
    await annuncioProvider.getAnnuncio(annuncio.id);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => AnnuncioDetailScreen(
                  annuncio: annuncio,
                )),
        (route) => false);
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
        title: Text(
          'Modifica Annuncio',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
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
                        id: widget.annuncio.id,
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
                          await annuncioProvider.updateAnnuncio(annuncio);
                      result ? modificaRiuscita(annuncio) : null;
                    }
                  },
                  child: const Text('Aggiorna'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
