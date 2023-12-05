import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/models/candidato.dart';
import 'package:solving_recruitment_flutter/models/colloquio.dart';
import 'package:solving_recruitment_flutter/models/selezionatore.dart';
import 'package:solving_recruitment_flutter/providers/candidato_provider.dart';
import 'package:solving_recruitment_flutter/providers/colloquio_provider.dart';
import 'package:solving_recruitment_flutter/providers/selezionatore_provider.dart';
import 'package:solving_recruitment_flutter/screens/colloquio_screens/colloquio_screen.dart';

class FilterModalColloquio extends StatefulWidget {
  const FilterModalColloquio({
    super.key,
    required this.colloquioFiltro,
  });
  final ColloquioFiltro colloquioFiltro;

  @override
  State<FilterModalColloquio> createState() => _FilterModalColloquioState();
}

class _FilterModalColloquioState extends State<FilterModalColloquio> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController candidatoController = TextEditingController();
  Candidato? candidato;
  late TextEditingController selezionatoreController = TextEditingController();
  Selezionatore? selezionatoreSelezionato;
  FeedBackColloquio? feedBackColloquioSelezionato;
  Tipologia? tipologiaColloquioSelezionata;

  late FocusNode candidatoFocusNode;

  Future<void> candidatoSelezionato(id) async {
    final CandidatoProvider candidatoProvider =
        Provider.of<CandidatoProvider>(context, listen: false);
    await candidatoProvider.getCandidato(id);
  }

  void _resetFields() {
    setState(() {
      candidatoController.text = '';
      selezionatoreController.text = '';
      tipologiaColloquioSelezionata = null;
      feedBackColloquioSelezionato = null;
    });
  }

  @override
  void initState() {
    super.initState();
    candidatoFocusNode = FocusNode();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      candidatoController.text = widget.colloquioFiltro.candidato != null
          ? '${widget.colloquioFiltro.candidato!.nome ?? ''} ${widget.colloquioFiltro.candidato!.cognome ?? ''}'
          : '';
      candidatoSelezionato(widget.colloquioFiltro.candidato != null
          ? widget.colloquioFiltro.candidato!.id
          : null);
      widget.colloquioFiltro.selezionatore != null
          ? selezionatoreSelezionato = widget.colloquioFiltro.selezionatore
          : selezionatoreSelezionato = null;
      feedBackColloquioSelezionato = widget.colloquioFiltro.feedback;
      tipologiaColloquioSelezionata = widget.colloquioFiltro.tipologia;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Verifica se è necessario aggiornare le variabili in base alle nuove dipendenze
    // Aggiorna feedBackColloquioSelezionato se necessario
    if (widget.colloquioFiltro.feedback != feedBackColloquioSelezionato) {
      setState(() {
        feedBackColloquioSelezionato = widget.colloquioFiltro.feedback;
      });
    }
  }

  @override
  void dispose() {
    candidatoFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final candidatoProvider =
        Provider.of<CandidatoProvider>(context, listen: false);
    final selezionatoreProvider =
        Provider.of<SelezionatoreProvider>(context, listen: false);
    final selezionatori = selezionatoreProvider.selezionatori;
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoCompleteTextField<Candidato>(
                controller: candidatoController,
                focusNode: candidatoFocusNode,
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
              DropdownButtonFormField<int>(
                value: selezionatoreSelezionato?.id,
                items: [
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
                      selezionatoreSelezionato = selezionatori
                          .firstWhere((candidato) => candidato.id == value);
                    }
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Selezionatore',
                ),
              ),
              Row(
                children: [
                  const Expanded(child: Text('Filtra per tipologia')),
                  DropdownButton<Tipologia>(
                    value: tipologiaColloquioSelezionata,
                    onChanged: (Tipologia? newValue) {
                      setState(() {
                        tipologiaColloquioSelezionata = newValue;
                      });
                    },
                    items: [
                      const DropdownMenuItem<Tipologia>(
                        value: null,
                        child: Text(' - '),
                      ),
                      ...Tipologia.values.map((Tipologia tipologia) {
                        return DropdownMenuItem<Tipologia>(
                          value: tipologia,
                          child: Text(tipologiaMap[tipologia] ?? 'errore'),
                        );
                      }),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  const Expanded(child: Text('Filtra per feedback')),
                  DropdownButton<FeedBackColloquio>(
                    value: feedBackColloquioSelezionato,
                    onChanged: (FeedBackColloquio? newValue) {
                      setState(() {
                        feedBackColloquioSelezionato = newValue;
                      });
                    },
                    items: [
                      const DropdownMenuItem<FeedBackColloquio>(
                        value: null,
                        child: Text(' - '),
                      ),
                      ...FeedBackColloquio.values
                          .map((FeedBackColloquio feedback) {
                        return DropdownMenuItem<FeedBackColloquio>(
                          value: feedback,
                          child: Text(feedbackLabelMap[feedback] ?? 'errore'),
                        );
                      }),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: heightSize(context) * 0.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print(feedBackColloquioSelezionato);
                        ColloquioFiltro filter = ColloquioFiltro(
                          candidato: candidato,
                          selezionatore: selezionatoreSelezionato,
                          feedback: feedBackColloquioSelezionato,
                          tipologia: tipologiaColloquioSelezionata,
                          pageNo: 0,
                          pageSize: 10,
                          sortBy: 'note',
                          sortDirection: 'asc',
                        );
                        Provider.of<ColloquioProvider>(context, listen: false)
                            .checkFilterActive(filter);
                        Navigator.pushNamedAndRemoveUntil(context,
                            ColloquioScreen.routeName, (route) => false);
                      }
                    },
                    child: const Text('Applica filtri'),
                  ),
                  TextButton(
                      onPressed: _resetFields,
                      child: const Text('Resetta filtri')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
