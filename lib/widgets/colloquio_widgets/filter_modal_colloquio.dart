import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/models/candidato.dart';
import 'package:solving_recruitment_flutter/models/colloquio.dart';
import 'package:solving_recruitment_flutter/models/selezionatore.dart';
import 'package:solving_recruitment_flutter/providers/candidato_provider.dart';
import 'package:solving_recruitment_flutter/providers/colloquio_provider.dart';
import 'package:solving_recruitment_flutter/providers/selezionatore_provider.dart';
import 'package:solving_recruitment_flutter/screens/colloquio_screens/colloquio_screen.dart';

class FilterModalColloquio extends StatefulWidget {
  const FilterModalColloquio({super.key, required this.colloquioFiltro});

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
  Future<Candidato> candidatoSelezionato(id) async {
    final CandidatoProvider candidatoProvider =
        Provider.of<CandidatoProvider>(context, listen: false);
    return candidato = await candidatoProvider.getCandidato(id);
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
    Future<Selezionatore> selezionatoreSelezionatoTrova(id) async {
      final SelezionatoreProvider selezionatoreProvider =
          Provider.of<SelezionatoreProvider>(context, listen: false);
      return selezionatoreSelezionato =
          await selezionatoreProvider.getSelezionatore(id);
    }

    widget.colloquioFiltro.selezionatore != null
        ? selezionatoreSelezionato = widget.colloquioFiltro.selezionatore
        : selezionatoreSelezionato = null;

    feedBackColloquioSelezionato = widget.colloquioFiltro.feedback;
    tipologiaColloquioSelezionata = widget.colloquioFiltro.tipologia;
  }

  @override
  Widget build(BuildContext context) {
    final candidatoProvider =
        Provider.of<CandidatoProvider>(context, listen: false);
    final selezionatoreProvider =
        Provider.of<SelezionatoreProvider>(context, listen: false);
    final candidati = candidatoProvider.candidati;
    final selezionatori = selezionatoreProvider.selezionatori;

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoCompleteTextField<Candidato>(
            controller: candidatoController,
            key: GlobalKey(),
            clearOnSubmit: false,
            itemBuilder: (context, suggestion) => ListTile(
              title: Text('${suggestion.nome} ${suggestion.cognome}'),
            ),
            itemFilter: (item, query) {
              return (item.nome!.toLowerCase().contains(query.toLowerCase()) ||
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
              if (value.isNotEmpty) {
                await candidatoProvider.getCandidatiFiltratiAutoComplete(value);
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
              const Expanded(child: Text('Filtra per feedback')),
              DropdownButton<FeedBackColloquio>(
                value: feedBackColloquioSelezionato,
                onChanged: (FeedBackColloquio? newValue) {
                  setState(() {
                    feedBackColloquioSelezionato = newValue;
                  });
                },
                items: [
                  // Primo elemento con testo "Seleziona stato" e valore nullo
                  const DropdownMenuItem<FeedBackColloquio>(
                    value: null,
                    child: Text(' - '),
                  ),
                  ...FeedBackColloquio.values
                      .map((FeedBackColloquio feedBackColloquio) {
                    return DropdownMenuItem<FeedBackColloquio>(
                      value: feedBackColloquio,
                      child:
                          Text(feedbackLabelMap[feedBackColloquio] ?? 'errore'),
                    );
                  }),
                ],
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(child: Text('Filtra per tipoligia')),
              DropdownButton<Tipologia>(
                value: tipologiaColloquioSelezionata,
                onChanged: (Tipologia? newValue) {
                  setState(() {
                    tipologiaColloquioSelezionata = newValue;
                  });
                },
                items: [
                  // Primo elemento con testo "Seleziona stato" e valore nullo
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
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
                    // ignore: use_build_context_synchronously
                    Navigator.pushNamedAndRemoveUntil(
                        context, ColloquioScreen.routeName, (route) => false);
                  }
                },
                child: const Text('Applica filtri'),
              ),
              TextButton(
                  onPressed: _resetFields, child: const Text('Resetta filtri')),
            ],
          ),
        ],
      ),
    );
  }
}
