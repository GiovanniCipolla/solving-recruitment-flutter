import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/common.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/models/annuncio.dart';
import 'package:solving_recruitment_flutter/models/area.dart';
import 'package:solving_recruitment_flutter/models/candidato.dart';
import 'package:intl/intl.dart';
import 'package:solving_recruitment_flutter/providers/annuncio_provider.dart';
import 'package:solving_recruitment_flutter/providers/area_provider.dart';
import 'package:solving_recruitment_flutter/providers/candidato_provider.dart';
import 'package:solving_recruitment_flutter/screens/candidato_screens/candidato_detail_screen.dart';
import 'package:solving_recruitment_flutter/screens/candidato_screens/candidato_screen.dart';

class CandidatoUpdateScreen extends StatefulWidget {
  const CandidatoUpdateScreen({super.key, required this.candidato});

  final Candidato candidato;

  @override
  State<CandidatoUpdateScreen> createState() => _CandidatoUpdateScreenState();
}

class _CandidatoUpdateScreenState extends State<CandidatoUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nomeController;
  late TextEditingController cognomeController;
  late TextEditingController emailController;
  late TextEditingController luogoDiNascitaController;
  late TextEditingController dataDiNascitaController;
  DateTime? dataDiNascita;

  late TextEditingController residenzaController;
  late TextEditingController recapitoTelefonicoController;
  late TextEditingController recapitoExtra;
  late TextEditingController cap;
  late LinguaInglese? linguaIngleseSelezionata;
  late Stato statoSelezionato;
  late List<String> tecnologieConosciute;
  final TextEditingController nuovaTecnologiaController =
      TextEditingController();
  late List<String> softSkills;
  final TextEditingController softSkillController = TextEditingController();
  late List<String> altreCompetenze;
  final TextEditingController altraCompetenzaController =
      TextEditingController();
  late bool? categoriaProtetta;
  late TextEditingController ralController;
  late Seniority? senioritySelezionata;
  late DisponibilitaLavoro? disponibilitaLavoroSelezionata;
  late TextEditingController dataPrimoContattoController;
  DateTime? dataPrimoContatto;
  late TextEditingController posizioneController;
  late TextEditingController noteController;
  Area? areaSelezionata;
  late TextEditingController areaController;
  Annuncio? annuncioSelezionato;
  late TextEditingController annuncioController;

 Future<void> _selectDate(BuildContext context, TextEditingController controller, DateTime? type) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: type ?? DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );
  if (picked != null && picked != type) {
    setState(() {
      dataPrimoContatto = picked;
      controller.text = formattaData(picked);
    });
  }
}

String formattaData(DateTime data) {
  return DateFormat('dd/MM/yyyy').format(data);
}

  @override
  void initState() {
    super.initState();
    nomeController = TextEditingController(text: widget.candidato.nome ?? '');
    cognomeController =
        TextEditingController(text: widget.candidato.cognome ?? '');
    emailController = TextEditingController(text: widget.candidato.email ?? '');
    luogoDiNascitaController =
        TextEditingController(text: widget.candidato.luogoDiNascita ?? '');
    dataDiNascitaController = TextEditingController(
      text: widget.candidato.dataDiNascita != null
          ? formattaData(widget.candidato.dataDiNascita!)
          : '',
    );
    dataDiNascita = widget.candidato.dataDiNascita;
    residenzaController =
        TextEditingController(text: widget.candidato.residenza ?? '');
    recapitoTelefonicoController =
        TextEditingController(text: widget.candidato.recapitoTelefonico ?? '');
    recapitoExtra =
        TextEditingController(text: widget.candidato.recapitoExtra ?? '');
    cap = TextEditingController(text: widget.candidato.cap ?? '');
    linguaIngleseSelezionata = widget.candidato.linguaInglese;
    statoSelezionato = widget.candidato.stato!;
    tecnologieConosciute = widget.candidato.tecnologieConosciute ?? [];
    softSkills = widget.candidato.softSkills ?? [];
    altreCompetenze = widget.candidato.altreCompetenzeMaturate ?? [];
    categoriaProtetta = widget.candidato.categoriaProtetta;
    ralController = TextEditingController(
      text: widget.candidato.ral != null ? widget.candidato.ral.toString() : '',
    );
    senioritySelezionata = widget.candidato.seniority;
    disponibilitaLavoroSelezionata = widget.candidato.disponibilitaLavoro;
    dataPrimoContattoController = TextEditingController(
      text: widget.candidato.dataPrimoContatto != null
          ? formattaData(widget.candidato.dataPrimoContatto!)
          : '',
    );
    dataPrimoContatto = widget.candidato.dataPrimoContatto;
    posizioneController =
        TextEditingController(text: widget.candidato.posizione ?? '');
    noteController = TextEditingController(text: widget.candidato.note ?? '');
    widget.candidato.area!.id != null ? areaSelezionata = widget.candidato.area : areaSelezionata = null;
    widget.candidato.annuncio!.id != null ? annuncioSelezionato = widget.candidato.annuncio : annuncioSelezionato = null;
  }

  Future<void> modificaRiuscita(candidato) async {
  
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
   // ignore: use_build_context_synchronously
   Navigator.pushNamedAndRemoveUntil(context, CandidatoScreen.routeName, (route) => false);
  }


  @override
  Widget build(BuildContext context) {
    final areas = Provider.of<AreaProvider>(context).aree;
    final annunci = Provider.of<AnnuncioProvider>(context).annunci;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Modifica Candidato',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
                 DropdownButtonFormField<Stato>(
                  value: statoSelezionato,
                  items: Stato.values
                      .map((Stato value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(statoCandidatoMap[value] ?? ''),
                    );
                  }).toList(),
                  onChanged: (Stato? value) {
                    if (value != null) {
                      setState(() {
                        statoSelezionato = value;
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Stato candidato',
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
                  value: areaSelezionata == null
                      ? 0
                      : areaSelezionata!.id,
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
                  value: annuncioSelezionato == null ? 0 : annuncioSelezionato!.id,
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
                      // Esegui l'aggiornamento con i valori dei controller
                      final candidato = Candidato(
                        id: widget.candidato.id,
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
                      print(candidato.toJson());
                      final result = await Provider.of<CandidatoProvider>(
                              context,
                              listen: false)
                          .updateCandidato(candidato);

                      if (result) {
                        modificaRiuscita(candidato);
                      } else {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: Text(
                          'Errore durante la modifica del candidato',
                        )));
                      }
                    }
                  },
                  child: const Text('Modifica'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
