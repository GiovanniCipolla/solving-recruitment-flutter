import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/common.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/models/candidato.dart';

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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dataPrimoContatto ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dataPrimoContatto) {
      setState(() {
        dataPrimoContatto = picked;
        dataPrimoContattoController.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inserisci Candidato'),
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
                TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Inserisci una email valida';
                      }
                      if (!value.contains('@')) {
                        return 'Inserisci una email valida';
                      }
                      return null;
                    }),
                customTextFormFieldWithoutValidator(
                    luogoDiNascitaController, 'Luogo di nascita'),
                customTextFormFieldWithoutValidator(
                    dataDiNascitaController, 'Data di nascita'),
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
                      if (value != null && double.parse(value) <= 0) {
                        return 'Il valore deve essere maggiore di 0';
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
                    labelText: 'Seniority',
                  ),
                ),
                TextFormField(
                  controller: dataPrimoContattoController,
                  decoration: const InputDecoration(
                    labelText: 'Data Primo Contatto',
                  ),
                  onTap: () {
                    _selectDate(context);
                  },
                ),
                customTextFormFieldWithoutValidator(
                    posizioneController, 'Posizione'),
                customTextFormFieldWithoutValidator(noteController, 'Note'),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Tutti i campi sono validi, procedi con la logica di salvataggio
                      // Puoi accedere ai valori inseriti tramite i controller, ad esempio nomeController.text per il Nome.
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
