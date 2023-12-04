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
  const FilterModal({super.key, required this.candidatoFiltro});
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
    // ignore: use_build_context_synchronously
    final annuncioProvider =
        Provider.of<AnnuncioProvider>(context, listen: false);
    areaProvider.getAreas();
    annuncioProvider.getAnnunci();
    final areas = areaProvider.aree;
    final annunci = annuncioProvider.annunci;
    return Form(
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
                    }),
              ),
              const SizedBox( width: 10,),
                  Expanded(
                    child: TextFormField(
                                  controller: _cognomeController,
                                  decoration: const InputDecoration(labelText: 'Cognome'),
                                  onChanged: (value) {
                                    setState(() {
                    _cognomeController.text = value;
                                    });
                                  },
                                  validator: (value) {
                                    return null;
                                  }),
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
                  // Primo elemento con testo "Seleziona stato" e valore nullo
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
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context)
                        .requestFocus(FocusNode()); // Chiudi la tastiera
                    _selectDate(context, dataDiNascitaController, dataDiNascita);
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: dataDiNascitaController,
                      decoration: const InputDecoration(
                        labelText: 'Data Di Nascita',
                      ),
                      validator: (value) {
                        if (dataDiNascita != null) {
                          final dateFormat = RegExp(r'^\d{2}/\d{2}/\d{4}$');
                          if (!dateFormat.hasMatch(value ?? '')) {
                            return 'Formato data non valido. Inserisci nel formato gg/mm/aaaa';
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
               Expanded(
                 child: GestureDetector(
                             onTap: () {
                               FocusScope.of(context)
                    .requestFocus(FocusNode()); // Chiudi la tastiera
                               _selectDate(
                    context, dataPrimoContattoController, dataPrimoContatto);
                             },
                             child: AbsorbPointer(
                               child: TextFormField(
                  controller: dataPrimoContattoController,
                  decoration: const InputDecoration(
                    labelText: 'Data Primo contatto',
                  ),
                  validator: (value) {
                    if (dataPrimoContatto != null) {
                      final dateFormat = RegExp(r'^\d{2}/\d{2}/\d{4}$');
                      if (!dateFormat.hasMatch(value ?? '')) {
                        return 'Formato data non valido. Inserisci nel formato gg/mm/aaaa';
                      }
                    }
                    return null;
                  },
                               ),
                             ),
                           ),
               ),
            ],
          ),
          // TextFormField(
          //   controller: etaMinController,
          //   decoration: const InputDecoration(
          //     labelText: 'Età Minima',
          //   ),
          //   keyboardType: TextInputType.number,
          //   validator: (value) {
          //     if (value != null && value.isNotEmpty) {
          //       final int etaMin = int.tryParse(value) ?? 0;
          //       if (etaMin < 0) {
          //         return 'Inserisci un numero positivo per l\'età minima';
          //       }
          //     }
          //     return null;
          //   },
          // ),
          // TextFormField(
          //   controller: etaMaxController,
          //   decoration: const InputDecoration(
          //     labelText: 'Età Massima',
          //   ),
          //   keyboardType: TextInputType.number,
          //   validator: (value) {
          //     if (value != null && value.isNotEmpty) {
          //       final int etaMax = int.tryParse(value) ?? 0;
          //       if (etaMax < 0) {
          //         return 'Inserisci un numero positivo per l\'età massima';
          //       }
          //       if (etaMinController.text.isNotEmpty) {
          //         final int etaMin =
          //             int.tryParse(etaMinController.text) ?? 0;
          //         if (etaMax < etaMin) {
          //           return 'L\'età massima deve essere maggiore o uguale all\'età minima';
          //         }
          //       }
          //     }
          //     return null;
          //   },
          // ),
          // TextFormField(
          //     controller: recapitoTelefonicoController,
          //     keyboardType: TextInputType.phone,
          //     decoration: const InputDecoration(
          //       labelText: 'Recapito telefonico',
          //     ),
          //     validator: (value) {
          //       return null;
          //     }),
          DropdownButtonFormField<int>(
            value: areaSelezionata?.id,
            items: [
              // Aggiungi un elemento vuoto all'inizio della lista
              const DropdownMenuItem<int>(
                value: 0,
                child: Text(' - '),
              ),
              // Aggiungi gli altri elementi
              ...areas.map((Area area) {
                return DropdownMenuItem<int>(
                  value: area.id,
                  child: Text(area.denominazione ?? 'errore'),
                );
              }).toList(),
            ],
            onChanged: (int? value) {
              setState(() {
                // Gestisci il caso in cui il valore è 0 (opzione vuota)
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
              // Aggiungi un elemento vuoto all'inizio della lista
              const DropdownMenuItem<int>(
                value: 0,
                child: Text(' - '),
              ),
              // Aggiungi gli altri elementi
              ...annunci.map((Annuncio annuncio) {
                return DropdownMenuItem<int>(
                  value: annuncio.id,
                  child: Text(annuncio.titolo ?? 'errore'),
                );
              }).toList(),
            ],
            onChanged: (int? value) {
              setState(() {
                // Gestisci il caso in cui il valore è 0 (opzione vuota)
                if (value == 0) {
                  annuncioSelezionato = null;
                } else {
                  annuncioSelezionato = annunci
                      .firstWhere((annuncio) => annuncio.id == value);
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
                onPressed: ()  {
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
                      recapitoTelefonico: recapitoTelefonicoController.text,
                      dataPrimoContatto:
                          (dataPrimoContattoController.text.isNotEmpty)
                              ? DateFormat('dd/MM/yyyy')
                                  .parse(dataPrimoContattoController.text)
                              : null,
                      area: areaSelezionata,
                      annuncio: annuncioSelezionato,
                      pageNo: 0,
                      pageSize: 10,
                      sortBy: 'nome',
                      sortDirection: 'asc',
                    );
                   Provider.of<CandidatoProvider>(context, listen: false).checkFilterActive(filter);
                    // ignore: use_build_context_synchronously
                    Navigator.pushNamedAndRemoveUntil(context, CandidatoScreen.routeName, (route) => false);
                  }
                },
                child: const Text('Applica filtri'),
              ),
              TextButton(onPressed: _resetFields, child: const Text('Resetta filtri')),
            ],
          ),
        ],
      ),
    );
  }
}
