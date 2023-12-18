import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/models/candidato.dart';
import 'package:solving_recruitment_flutter/models/colloquio.dart';
import 'package:solving_recruitment_flutter/models/selezionatore.dart';
import 'package:solving_recruitment_flutter/providers/candidato_provider.dart';
import 'package:solving_recruitment_flutter/providers/colloquio_provider.dart';
import 'package:solving_recruitment_flutter/providers/selezionatore_provider.dart';
import 'package:solving_recruitment_flutter/screens/colloquio_screens/colloquio_screen.dart';

class ColloquioUpdateScreen extends StatefulWidget {
  const ColloquioUpdateScreen({super.key, required this.colloquio});
  final Colloquio colloquio;
  @override
  State<StatefulWidget> createState() => _ColloquioUpdateScreenState();
}

class _ColloquioUpdateScreenState extends State<ColloquioUpdateScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController dataController;
  Selezionatore? selezionatoreSelezionato;
  DateTime? data;
  Tipologia? tipologiaSelezionata;
  FeedBackColloquio? feedbackSelezionato;
  late TextEditingController candidatoController = TextEditingController();
  Candidato? candidato;
  late TextEditingController? noteController;

  String formattaData(DateTime data) {
    return DateFormat('dd/MM/yyyy').format(data);
  }

  Future<void> candidatoSelezionato(id) async {
    final CandidatoProvider candidatoProvider =
        Provider.of<CandidatoProvider>(context, listen: false);
    candidato = await candidatoProvider.getCandidato(id);
  }

  Future<void> selezionatoreSelezionatoTrova(id) async {
    final SelezionatoreProvider selezionatoreProvider =
        Provider.of<SelezionatoreProvider>(context, listen: false);
    selezionatoreSelezionato = await selezionatoreProvider.getSelezionatore(id);
  }

  Future<void> modificaRiuscita(colloquio) async {
    Navigator.pushNamedAndRemoveUntil(
        context, ColloquioScreen.routeName, (route) => false);
  }

  @override
  void initState() {
    super.initState();
    selezionatoreSelezionatoTrova(widget.colloquio.idSelezionatore)
        .then((value) => setState(() {}));
    candidatoController.text =
        '${widget.colloquio.nomeCandidato ?? ''} ${widget.colloquio.cognomeCandidato ?? ''}';
    candidatoSelezionato(widget.colloquio.idCandidato);
    dataController = TextEditingController(
      text: widget.colloquio.data != null
          ? formattaData(widget.colloquio.data!)
          : '',
    );
    data = widget.colloquio.data;
    tipologiaSelezionata = widget.colloquio.tipologia;
    feedbackSelezionato = widget.colloquio.feedback;
    noteController = TextEditingController(text: widget.colloquio.note);
  }

  @override
  Widget build(BuildContext context) {
    final CandidatoProvider candidatoProvider =
        Provider.of<CandidatoProvider>(context, listen: false);
    final List<Selezionatore> selezionatori =
        Provider.of<SelezionatoreProvider>(context, listen: false)
            .selezionatori;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Modifica colloquio',
            style: TextStyle(
                fontSize: 25, color: Theme.of(context).colorScheme.primary),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownButtonFormField<int>(
                      value: selezionatoreSelezionato?.id,
                      items: [
                        // Aggiungi un elemento vuoto all'inizio della lista
                        const DropdownMenuItem<int>(
                          value: 0,
                          child: Text(' - '),
                        ),
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
                          if (value == 0) {
                            selezionatoreSelezionato = null;
                          } else {
                            selezionatoreSelezionato = selezionatori.firstWhere(
                                (selezionatore) => selezionatore.id == value);
                          }
                        });
                      },
                      validator: (value) {
                        if (value == null || value == 0) {
                          return 'Seleziona un selezionatore';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Selezionatore',
                      ),
                    ),
                    Divider(
                  color: Theme.of(context).primaryColor,
                  thickness: 1,
                ),
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
                    Divider(
                  color: Theme.of(context).primaryColor,
                  thickness: 1,
                ),
                    DropdownButtonFormField<FeedBackColloquio>(
                      value: feedbackSelezionato,
                      items:
                          FeedBackColloquio.values.map((FeedBackColloquio value) {
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
                    Divider(
                  color: Theme.of(context).primaryColor,
                  thickness: 1,
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
                            item.cognome!
                                .toLowerCase()
                                .contains(query.toLowerCase()));
                      },
                      itemSorter: (a, b) {
                        return (a.nome! + a.cognome!)
                            .compareTo(b.nome! + b.cognome!);
                      },
                      itemSubmitted: (item) async {
                        await candidatoSelezionato(item.id);
                        setState(() {
                          candidatoController.text =
                              '${item.nome} ${item.cognome}';
                        });
                      },
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.go,
                      suggestions: candidatoProvider.candidati,
                      textChanged: (value) async {
                        if (value.isNotEmpty) {
                          await candidatoProvider
                              .getCandidatiFiltratiAutoComplete(value);
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Candidato',
                      ),
                      onFocusChanged: (hasFocus) async {
                        if (hasFocus && candidatoProvider.candidati.isEmpty) {
                          await candidatoProvider
                              .getCandidatiFiltratiAutoComplete('');
                        }
                      },
                    ),
                    Divider(
                  color: Theme.of(context).primaryColor,
                  thickness: 1,
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
                        if (_formKey.currentState!.validate()) {
                          final colloquio = Colloquio(
                            id: widget.colloquio.id,
                            note: noteController == null
                                ? null
                                : noteController!.text,
                            data: (dataController.text.isNotEmpty && data != null)
                                ? DateFormat('dd/MM/yyyy')
                                    .parse(dataController.text)
                                : null,
                            selezionatore: selezionatoreSelezionato,
                            tipologia: tipologiaSelezionata,
                            feedback: feedbackSelezionato,
                            candidato: candidato,
                          );
                          final colloquioProvider =
                              Provider.of<ColloquioProvider>(context,
                                  listen: false);
                          final bool result =
                              await colloquioProvider.updateColloquio(colloquio);
                          if (result) {
                            modificaRiuscita(colloquio);
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    content: Text(
                              'Errore durante la modifica del colloquio',
                            )));
                          }
                        }
                      },
                      child: const Text('Modifica'),
                    )
                  ]),
            ),
          ),
        ));
  }
}
