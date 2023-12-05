import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/common.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/models/annuncio.dart';
import 'package:solving_recruitment_flutter/models/area.dart';
import 'package:solving_recruitment_flutter/models/candidato.dart';
import 'package:solving_recruitment_flutter/providers/annuncio_provider.dart';
import 'package:solving_recruitment_flutter/providers/area_provider.dart';
import 'package:solving_recruitment_flutter/providers/candidato_provider.dart';
import 'package:intl/intl.dart';
import 'package:solving_recruitment_flutter/screens/candidato_screens/candidato_screen.dart';
import 'package:solving_recruitment_flutter/utilities/dropdownButtonFormField.dart';

class CandidatoInsertScreen extends StatefulWidget {
  const CandidatoInsertScreen({super.key});

  @override
  State<CandidatoInsertScreen> createState() => _CandidatoInsertScreenState();
}

class _CandidatoInsertScreenState extends State<CandidatoInsertScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController cognomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController luogoDiNascitaController =
      TextEditingController();
  final TextEditingController dataDiNascitaController = TextEditingController();
  DateTime? dataDiNascita;
  final TextEditingController residenzaController = TextEditingController();
  final TextEditingController recapitoTelefonicoController =
      TextEditingController();
  final TextEditingController recapitoExtra = TextEditingController();
  final TextEditingController cap = TextEditingController();
  LinguaInglese? linguaIngleseSelezionata;
  final List<String> tecnologieConosciute = [];
  final TextEditingController nuovaTecnologiaController =
      TextEditingController();
  final List<String> softSkills = [];
  final TextEditingController softSkillController = TextEditingController();
  final List<String> altreCompetenze = [];
  final TextEditingController altraCompetenzaController =
      TextEditingController();
  bool? categoriaProtetta;
  TextEditingController ralController = TextEditingController();
  Seniority? senioritySelezionata;
  DisponibilitaLavoro? disponibilitaLavoroSelezionata;
  TextEditingController dataPrimoContattoController = TextEditingController();
  DateTime? dataPrimoContatto;
  final TextEditingController posizioneController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  Area? areaSelezionata;
  final TextEditingController areaController = TextEditingController();
  Annuncio? annuncioSelezionato;
  final TextEditingController annuncioController = TextEditingController();

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

  Future<void> inserimentoRiuscito() async {
    Navigator.pushNamedAndRemoveUntil(
        context, CandidatoScreen.routeName, (route) => false);
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
                Row(
                  children: [
                    Expanded(
                        child: customTextFormFieldWithValidator(
                            nomeController, 'Nome')),
                    const SizedBox(width: 10),
                    Expanded(
                        child: customTextFormFieldWithValidator(
                            cognomeController, 'Cognome')),
                  ],
                ),
                Row(children: [
                  Expanded(
                    child: TextFormField(
                      controller: dataDiNascitaController,
                      decoration: const InputDecoration(
                        labelText: 'Data Di Nascita',
                      ),
                      onTap: () {
                        _selectDate(
                            context, dataDiNascitaController, dataDiNascita);
                      },
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
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: dataPrimoContattoController,
                      decoration: const InputDecoration(
                        labelText: 'Data Primo Contatto',
                      ),
                      onTap: () {
                        _selectDate(context, dataPrimoContattoController,
                            dataPrimoContatto);
                      },
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
                ]),
                Row(
                  children: [
                    Expanded(
                        flex: 7,
                        child: customTextFormFieldWithEmail(
                            emailController, 'E-Mail')),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: cap,
                        decoration: const InputDecoration(
                          labelText: 'Cap',
                        ),
                      ),
                    )
                  ],
                ),
                Row(children: [
                  Expanded(
                    child: customTextFormFieldWithoutValidator(
                        luogoDiNascitaController, 'Luogo di nascita'),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: customTextFormFieldWithoutValidator(
                        residenzaController, 'Residenza'),
                  ),
                ]),
                Row(children: [
                  Expanded(
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: recapitoTelefonicoController,
                        decoration: const InputDecoration(
                          labelText: 'Recapito telefonico',
                        )),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: recapitoExtra,
                        decoration: const InputDecoration(
                          labelText: 'Recapito extra',
                        )),
                  ),
                ]),
                Row(children: [
                  Expanded(
                    child: DropdownButtonFormField<Seniority>(
                      value: senioritySelezionata,
                      items: Seniority.values.map((Seniority value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(seniorityMap[value] ?? ''),
                        );
                      }).toList(),
                      onChanged: (Seniority? value) {
                        if (value != null) {
                          setState(() {
                            senioritySelezionata = value;
                          });
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Seniority',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<DisponibilitaLavoro>(
                      value: disponibilitaLavoroSelezionata,
                      items: DisponibilitaLavoro.values
                          .map((DisponibilitaLavoro value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(disponibilitaLavoroMap[value] ?? ''),
                        );
                      }).toList(),
                      onChanged: (DisponibilitaLavoro? value) {
                        if (value != null) {
                          setState(() {
                            disponibilitaLavoroSelezionata = value;
                          });
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Disponibilità',
                      ),
                    ),
                  ),
                ]),
                Row(children: [
                  Expanded(
                    child: showLinguaInglese(
                      linguaIngleseSelezionata ?? LinguaInglese.ND,
                      (LinguaInglese? value) {
                        setState(() {
                          linguaIngleseSelezionata = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: customTextFormFieldWithoutValidator(
                        posizioneController, 'Posizione'),
                  ),
                ]),
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
                const SizedBox(
                  height: 10,
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Text('Tecnologie Conosciute: '),
                    for (String tecnologia in tecnologieConosciute)
                      Chip(
                        label: Text(tecnologia),
                        onDeleted: () {
                          setState(() {
                            tecnologieConosciute.remove(tecnologia);
                          });
                        },
                      ),
                  ],
                ),
                TextFormField(
                  controller: nuovaTecnologiaController,
                  decoration: const InputDecoration(
                    labelText: 'Nuova Tecnologia',
                  ),
                  onEditingComplete: () {
                    final nuovaTecnologia =
                        nuovaTecnologiaController.text.trim();
                    if (nuovaTecnologia.isNotEmpty) {
                      setState(() {
                        tecnologieConosciute.add(nuovaTecnologia);
                        nuovaTecnologiaController.clear();
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Text('Soft Skills: '),
                    for (String skills in softSkills)
                      Chip(
                        label: Text(skills),
                        onDeleted: () {
                          setState(() {
                            softSkills.remove(skills);
                          });
                        },
                      ),
                  ],
                ),
                TextFormField(
                  controller: softSkillController,
                  decoration: const InputDecoration(
                    labelText: 'Nuova Soft Skills',
                  ),
                  onEditingComplete: () {
                    final nuovaSkills = softSkillController.text.trim();
                    if (nuovaSkills.isNotEmpty) {
                      setState(() {
                        softSkills.add(nuovaSkills);
                        softSkillController.clear();
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Text('Altre Competenze: '),
                    for (String competenze in altreCompetenze)
                      Chip(
                        label: Text(competenze),
                        onDeleted: () {
                          setState(() {
                            altreCompetenze.remove(competenze);
                          });
                        },
                      ),
                  ],
                ),
                TextFormField(
                  controller: altraCompetenzaController,
                  decoration: const InputDecoration(
                    labelText: 'Nuova Competenza',
                  ),
                  onEditingComplete: () {
                    final nuovaCompetenza =
                        altraCompetenzaController.text.trim();
                    if (nuovaCompetenza.isNotEmpty) {
                      setState(() {
                        altreCompetenze.add(nuovaCompetenza);
                        altraCompetenzaController.clear();
                      });
                    }
                  },
                ),
                TextFormField(
                    controller: ralController,
                    keyboardType:
                        TextInputType.number, // Tipo di tastiera numerica.
                    decoration: const InputDecoration(
                      labelText: 'RAL (Retribuzione Annua Lorda)',
                    ),
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        double? parsedValue = double.tryParse(value);
                        if (parsedValue! < 0) {
                          return 'Inserisci un valore numerico valido e maggiore di 0';
                        }
                      }
                      return null;
                    }),
                customTextFormFieldWithoutValidator(noteController, 'Note'),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      final candidato = Candidato(
                        nome: nomeController.text,
                        cognome: cognomeController.text,
                        email: emailController.text,
                        luogoDiNascita: luogoDiNascitaController.text,
                        dataDiNascita: (dataDiNascitaController.text.isNotEmpty)
                            ? DateFormat('dd/MM/yyyy')
                                .parse(dataDiNascitaController.text)
                            : null,
                        residenza: residenzaController.text,
                        recapitoTelefonico: recapitoTelefonicoController.text,
                        recapitoExtra: recapitoExtra.text,
                        cap: cap.text,
                        linguaInglese: linguaIngleseSelezionata,
                        tecnologieConosciute: tecnologieConosciute,
                        softSkills: softSkills,
                        altreCompetenzeMaturate: altreCompetenze,
                        categoriaProtetta: categoriaProtetta,
                        ral: ralController.text.isNotEmpty
                            ? double.parse(ralController.text)
                            : null,
                        seniority: senioritySelezionata,
                        disponibilitaLavoro: disponibilitaLavoroSelezionata,
                        dataPrimoContatto:
                            (dataPrimoContattoController.text.isNotEmpty)
                                ? DateFormat('dd/MM/yyyy')
                                    .parse(dataPrimoContattoController.text)
                                : null,
                        posizione: posizioneController.text,
                        note: noteController.text,
                        area: areaSelezionata,
                        annuncio: annuncioSelezionato,
                      );

                      final candidatoProvider = Provider.of<CandidatoProvider>(
                          context,
                          listen: false);
                      bool result =
                          await candidatoProvider.createCandidato(candidato);
                      // ignore: use_build_context_synchronously

                      result
                          ? inserimentoRiuscito()
                          // ignore: use_build_context_synchronously
                          : showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Attenzione'),
                                  content:
                                      const Text('Inserimento non riuscito.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(
                                            context); // Chiudi il dialog
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Errore nella validazione, controlla i campi',
                      )
                    )
                  );
                    }
                  },
                  child: const Text('Inserisci'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
