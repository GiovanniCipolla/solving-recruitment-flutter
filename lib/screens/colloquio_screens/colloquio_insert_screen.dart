import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/models/candidato.dart';
import 'package:solving_recruitment_flutter/models/colloquio.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:solving_recruitment_flutter/models/selezionatore.dart';
import 'package:solving_recruitment_flutter/providers/candidato_provider.dart';
import 'package:solving_recruitment_flutter/providers/colloquio_provider.dart';
import 'package:solving_recruitment_flutter/providers/selezionatore_provider.dart';
import 'package:solving_recruitment_flutter/screens/colloquio_screens/colloquio_screen.dart';

class ColloquioInsertScreen extends StatefulWidget {
  const ColloquioInsertScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ColloquioInsertScreenState();
}

class _ColloquioInsertScreenState extends State<ColloquioInsertScreen> {
  final _formKey = GlobalKey<FormState>();
  Tipologia? tipologiaColloquioSelezionata;
  final TextEditingController dataColloquioController = TextEditingController();
  DateTime? dataColloquio;
  TextEditingController candidatoController = TextEditingController();
  List<Candidato> candidati = [];
  Candidato? candidato;
  Selezionatore? selezionatoreSelezionato;
  final TextEditingController selezionatoreController = TextEditingController();
  TextEditingController? noteController = TextEditingController();


  Future<void> _selectDate(BuildContext context, contoller, type) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: type ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != type) {
      setState(() {
        type = picked;
        contoller.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> candidatoSelezionato(id) async {
    final CandidatoProvider candidatoProvider =
        Provider.of<CandidatoProvider>(context, listen: false);
    candidato = await candidatoProvider.getCandidato(id);
  }

  Future<void> inserimentoRiuscito() async {
    Navigator.pushNamedAndRemoveUntil(
        context, ColloquioScreen.routeName, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final CandidatoProvider candidatoProvider =
        Provider.of<CandidatoProvider>(context, listen: false);
    final SelezionatoreProvider selezionatoreProvider =
        Provider.of<SelezionatoreProvider>(context, listen: false);
    final List<Selezionatore> selezionatori =
        selezionatoreProvider.selezionatori;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inserisci Colloquio',
          style: TextStyle(
              fontSize: 25, color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            DropdownButtonFormField<Tipologia>(
              value: tipologiaColloquioSelezionata,
              items: Tipologia.values.map((Tipologia value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(tipologiaMap[value] ?? ''),
                );
              }).toList(),
              onChanged: (Tipologia? value) {
                if (value != null) {
                  setState(() {
                    tipologiaColloquioSelezionata = value;
                  });
                }
              },
              decoration: const InputDecoration(
                labelText: 'Tipologia',
              ),
              validator: (value) {
                if (value == null) {
                  return 'Seleziona una tipologia';
                }
              },
            ),
            TextFormField(
              controller: dataColloquioController,
              decoration: const InputDecoration(
                labelText: 'Data Colloquio',
              ),
              onTap: () {
                _selectDate(context, dataColloquioController, dataColloquio);
              },
            ),
            AutoCompleteTextField<Candidato>(
              controller: candidatoController,
              key: GlobalKey(),
              clearOnSubmit: false,
              itemBuilder: (context, suggestion) => ListTile(
                title: Text('${suggestion.nome} ${suggestion.cognome}'),
              ),
              itemFilter: (item, query) {
                return (item.nome!
                        .toLowerCase()
                        .contains(query.toLowerCase()) ||
                    item.cognome!.toLowerCase().contains(query.toLowerCase()));
              },
              itemSorter: (a, b) {
                return (a.nome! + a.cognome!).compareTo(b.nome! + b.cognome!);
              },
              itemSubmitted: (item) async {
                await candidatoSelezionato(item.id);
                setState(() {
                  candidatoController.text = '${item.nome} ${item.cognome}';
                });
              },
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.go,
              suggestions: candidatoProvider.candidati,
              textChanged: (value) async {
                // Effettua la chiamata solo se il testo ha almeno tre caratteri
                if (value.length >= 1) {
                  await candidatoProvider
                      .getCandidatiFiltratiAutoComplete(value);
                }
              },
              decoration: const InputDecoration(
                labelText: 'Candidato',
              ),
              onFocusChanged: (hasFocus) async {
                if (hasFocus && candidatoProvider.candidati.isEmpty) {
                  await candidatoProvider.getCandidatiFiltratiAutoComplete('');
                }
              },
            ),
            DropdownButtonFormField<int>(
              value: selezionatoreSelezionato?.id,
              items: [
                // Aggiungi un elemento vuoto all'inizio della lista
                const DropdownMenuItem<int>(
                  value: 0,
                  child: Text(' - '),
                ),
                // Aggiungi gli altri elementi
                ...selezionatori.map((Selezionatore selezionatore) {
                  return DropdownMenuItem<int>(
                    value: selezionatore.id,
                    child: Row(
                      children: [
                        Text(selezionatore.nome ?? 'errore'),
                        const SizedBox(width: 8),
                        Text(selezionatore.cognome ?? 'errore'),
                      ],
                    ),
                  );
                }).toList(),
              ],
              onChanged: (int? value) {
                setState(() {
                  // Gestisci il caso in cui il valore è 0 (opzione vuota)
                  if (value == 0) {
                    selezionatoreSelezionato = null;
                  } else {
                    selezionatoreSelezionato = selezionatori.firstWhere(
                        (selezionatore) => selezionatore.id == value);
                  }
                });
              },
              decoration: const InputDecoration(
                labelText: 'Selezionatore',
              ),
              validator: (value) {
                if (value == null) {
                  return 'Seleziona un selezionatore';
                }
              },
            ),
            TextFormField(
              controller: noteController,
              decoration: const InputDecoration(
                labelText: 'Note',
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate() && candidato != null) {
                  final colloquio = Colloquio(
                    tipologia: tipologiaColloquioSelezionata,
                    data: (dataColloquioController.text.isNotEmpty)
                        ? DateFormat('dd/MM/yyyy')
                            .parse(dataColloquioController.text)
                        : null,
                    candidato: candidato,
                    selezionatore: selezionatoreSelezionato,
                    note: noteController != null ? noteController!.text : null,
                  );
                  final colloquioProvider =
                      Provider.of<ColloquioProvider>(context, listen: false);
                  final bool result =
                      await colloquioProvider.createColloquio(colloquio);
                  // ignore: use_build_context_synchronously
                  result
                      ? inserimentoRiuscito()
                      // ignore: use_build_context_synchronously
                      : ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                              content: Text(
                          'Errore durante l\'inserimento del colloquio',
                        )));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                    'Seleziona un candidato !',
                      )
                  ));
                }
              },
              child: const Text('Inserisci'),
            )
          ]),
        ),
      ),
    );
  }
}
