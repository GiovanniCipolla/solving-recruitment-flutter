import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/models/annuncio.dart';
import 'package:solving_recruitment_flutter/models/area.dart';
import 'package:solving_recruitment_flutter/models/candidato.dart';
import 'package:solving_recruitment_flutter/providers/annuncio_provider.dart';
import 'package:solving_recruitment_flutter/providers/area_provider.dart';
import 'package:solving_recruitment_flutter/providers/candidato_provider.dart';
import 'package:solving_recruitment_flutter/screens/candidato_screens/candidato_screen.dart';

class FilterModal extends StatefulWidget {
  const FilterModal({Key? key, required this.candidatoFiltro}) : super(key: key);
  final CandidatoFiltro candidatoFiltro;
  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomeController = TextEditingController();
  late TextEditingController _cognomeController = TextEditingController();
  Stato? statoSelezionato;
  late TextEditingController dataDiNascitaController = TextEditingController();
  DateTime? dataDiNascita;
  late TextEditingController emailController = TextEditingController();
  late TextEditingController etaMinController = TextEditingController();
  late TextEditingController etaMaxController = TextEditingController();
  late TextEditingController recapitoTelefonicoController =
      TextEditingController();
  late TextEditingController dataPrimoContattoController =
      TextEditingController();
  DateTime? dataPrimoContatto;
  Area? areaSelezionata;
  late TextEditingController areaController = TextEditingController();
  Annuncio? annuncioSelezionato;
  late TextEditingController annuncioController = TextEditingController();

  void _resetFields() {
    setState(() {
      _nomeController.text = '';
      _cognomeController.text = '';
      statoSelezionato = null;
      dataDiNascitaController.text = '';
      dataDiNascita = null;
      emailController.text = '';
      etaMinController.text = '';
      etaMaxController.text = '';
      recapitoTelefonicoController.text = '';
      dataPrimoContattoController.text = '';
      dataPrimoContatto = null;
      areaSelezionata = null;
      annuncioSelezionato = null;
    });
  }

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

  String formattaData(DateTime data) {
    return DateFormat('dd/MM/yyyy').format(data);
  }

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.candidatoFiltro.nome);
    _cognomeController =
        TextEditingController(text: widget.candidatoFiltro.cognome);
    statoSelezionato = widget.candidatoFiltro.stato;
    dataDiNascitaController = TextEditingController(
        text: widget.candidatoFiltro.dataNascita != null
            ? formattaData(widget.candidatoFiltro.dataNascita!)
            : '');
    emailController = TextEditingController(text: widget.candidatoFiltro.email);
    etaMinController = TextEditingController(
        text: widget.candidatoFiltro.etaMin != null
            ? widget.candidatoFiltro.etaMin.toString()
            : '');
    etaMaxController = TextEditingController(
        text: widget.candidatoFiltro.etaMax != null
            ? widget.candidatoFiltro.etaMax.toString()
            : '');
    recapitoTelefonicoController =
        TextEditingController(text: widget.candidatoFiltro.recapitoTelefonico);
    dataPrimoContattoController = TextEditingController(
        text: widget.candidatoFiltro.dataPrimoContatto != null
            ? formattaData(widget.candidatoFiltro.dataPrimoContatto!)
            : '');
    widget.candidatoFiltro.area != null
        ? areaSelezionata = widget.candidatoFiltro.area
        : areaSelezionata = null;
    widget.candidatoFiltro.annuncio != null
        ? annuncioSelezionato = widget.candidatoFiltro.annuncio
        : annuncioSelezionato = null;
  }

  @override
  Widget build(BuildContext context) {
    final areaProvider = Provider.of<AreaProvider>(context, listen: false);
    final annuncioProvider =
        Provider.of<AnnuncioProvider>(context, listen: false);
    areaProvider.getAreas();
    annuncioProvider.getAnnunci();
    final areas = areaProvider.aree;
    final annunci = annuncioProvider.annunci;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _nomeController,
                      decoration: const InputDecoration(labelText: 'Nome'),
                      onChanged: (value) {
                        setState(() {
                          _nomeController.text = value;
                        });
                      },
                      validator: (value) {
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _cognomeController,
                      decoration:
                          const InputDecoration(labelText: 'Cognome'),
                      onChanged: (value) {
                        setState(() {
                          _cognomeController.text = value;
                        });
                      },
                      validator: (value) {
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Expanded(child: Text('Filtra per stato')),
                  DropdownButton<Stato>(
                    value: statoSelezionato,
                    onChanged: (Stato? newValue) {
                      setState(() {
                        statoSelezionato = newValue;
                      });
                    },
                    items: [
                      const DropdownMenuItem<Stato>(
                        value: null,
                        child: Text(' - '),
                      ),
                      ...Stato.values.map((Stato stato) {
                        return DropdownMenuItem<Stato>(
                          value: stato,
                          child: Text(statoCandidatoMap[stato]!),
                        );
                      }),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                   Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Eta\' Minima',
                      ),
                      controller: etaMinController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          etaMinController.text = value;
                        });
                      },
                      validator: (value) {
                        if ( value != null) {
                          if (int.tryParse(value) != null) {
                            return 'Valore non valido';
                          }
                        }
                        return null;
                      }
                    )
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Eta\ Massima',
                      ),
                      controller: etaMaxController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          etaMaxController.text = value;
                        });
                      },
                      validator: (value) {
                        if ( value != null) {
                          if (int.tryParse(value) != null) {
                            return 'Valore non valido';
                          }
                        }
                        return null;
                      }
                    )
                  ),
                ],
              ),
              DropdownButtonFormField<int>(
                value: areaSelezionata?.id,
                items: [
                  const DropdownMenuItem<int>(
                    value: 0,
                    child: Text(' - '),
                  ),
                  ...areas.map((Area area) {
                    return DropdownMenuItem<int>(
                      value: area.id,
                      child: Text(area.denominazione ?? 'errore'),
                    );
                  }).toList(),
                ],
                onChanged: (int? value) {
                  setState(() {
                    if (value == 0) {
                      areaSelezionata = null;
                    } else {
                      areaSelezionata =
                          areas.firstWhere((area) => area.id == value);
                    }
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Area',
                ),
              ),
              DropdownButtonFormField<int>(
                value: annuncioSelezionato?.id,
                items: [
                  const DropdownMenuItem<int>(
                    value: 0,
                    child: Text(' - '),
                  ),
                  ...annunci.map((Annuncio annuncio) {
                    return DropdownMenuItem<int>(
                      value: annuncio.id,
                      child: Text(annuncio.titolo ?? 'errore'),
                    );
                  }).toList(),
                ],
                onChanged: (int? value) {
                  setState(() {
                    if (value == 0) {
                      annuncioSelezionato = null;
                    } else {
                      annuncioSelezionato =
                          annunci.firstWhere((annuncio) => annuncio.id == value);
                    }
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Annuncio',
                ),
              ),
              SizedBox(
                height: heightSize(context) * 0.15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        CandidatoFiltro filter = CandidatoFiltro(
                          nome: _nomeController.text,
                          cognome: _cognomeController.text,
                          stato: statoSelezionato,
                          dataNascita: (dataDiNascitaController.text.isNotEmpty)
                              ? DateFormat('dd/MM/yyyy')
                                  .parse(dataDiNascitaController.text)
                              : null,
                          email: emailController.text,
                          etaMin: (etaMinController.text.isNotEmpty)
                              ? int.tryParse(etaMinController.text)
                              : null,
                          etaMax: (etaMaxController.text.isNotEmpty)
                              ? int.tryParse(etaMaxController.text)
                              : null,
                          recapitoTelefonico:
                              recapitoTelefonicoController.text,
                          dataPrimoContatto:
                              (dataPrimoContattoController.text.isNotEmpty)
                                  ? DateFormat('dd/MM/yyyy').parse(
                                      dataPrimoContattoController.text)
                                  : null,
                          area: areaSelezionata,
                          annuncio: annuncioSelezionato,
                          pageNo: 0,
                          pageSize: 10,
                          sortBy: 'nome',
                          sortDirection: 'asc',
                        );
                        Provider.of<CandidatoProvider>(context, listen: false)
                            .checkFilterActive(filter);
                        Navigator.pushNamedAndRemoveUntil(
                            context, CandidatoScreen.routeName, (route) => false);
                      }
                    },
                    child: const Text('Applica filtri'),
                  ),
                  TextButton(
                    onPressed: _resetFields,
                    child: const Text('Resetta filtri'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}