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
    final CandidatoProvider candidatoProvider =
        Provider.of<CandidatoProvider>(context, listen: false);
    await candidatoProvider.getCandidati();
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AreaProvider>(context).getAreas();
    Provider.of<AnnuncioProvider>(context).getAnnunci();
    final areas = Provider.of<AreaProvider>(context).aree;
    final annunci = Provider.of<AnnuncioProvider>(context).annunci;
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
                customTextFormFieldWithValidator(nomeController, 'Nome'),
                customTextFormFieldWithValidator(cognomeController, 'Cognome'),
                customTextFormFieldWithEmail(emailController, 'E-Mail'),
                customTextFormFieldWithoutValidator(
                    luogoDiNascitaController, 'Luogo di nascita'),
                TextFormField(
                  controller: dataDiNascitaController,
                  decoration: const InputDecoration(
                    labelText: 'Data Di Nascita',
                  ),
                  onTap: () {
                    _selectDate(
                        context, dataDiNascitaController, dataDiNascita);
                  },
                ),
                customTextFormFieldWithoutValidator(
                    residenzaController, 'Residenza'),
                customTextFormFieldWithoutValidator(
                    recapitoTelefonicoController, 'Recapito telefonico'),
                customTextFormFieldWithoutValidator(
                    recapitoExtra, 'Recapito extra'),
                customTextFormFieldWithoutValidator(cap, 'CAP'),
                DropdownButtonFormField<LinguaInglese>(
                  value: linguaIngleseSelezionata,
                  items: LinguaInglese.values.map((LinguaInglese value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(linguaIngleseMap[value] ?? ''),
                    );
                  }).toList(),
                  onChanged: (LinguaInglese? value) {
                    if (value != null) {
                      setState(() {
                        linguaIngleseSelezionata = value;
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Lingua Inglese',
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
                ListTile(
                  title: const Text('Categoria Protetta'),
                  trailing: Checkbox(
                    value: categoriaProtetta ?? false,
                    onChanged: (value) {
                      setState(() {
                        categoriaProtetta = value;
                      });
                    },
                  ),
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
                DropdownButtonFormField<Seniority>(
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
                DropdownButtonFormField<DisponibilitaLavoro>(
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
                    labelText: 'Disponibilità Lavoro',
                  ),
                ),
                TextFormField(
                  controller: dataPrimoContattoController,
                  decoration: const InputDecoration(
                    labelText: 'Data Primo Contatto',
                  ),
                  onTap: () {
                    _selectDate(context, dataPrimoContattoController,
                        dataPrimoContatto);
                  },
                ),
                customTextFormFieldWithoutValidator(
                    posizioneController, 'Posizione'),
                customTextFormFieldWithoutValidator(noteController, 'Note'),
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
                          // ignore: use_build_context_synchronously
                          ? inserimentoRiuscito()
                          : print('aaaaaa');
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
