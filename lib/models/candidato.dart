import 'package:solving_recruitment_flutter/models/annuncio.dart';
import 'package:solving_recruitment_flutter/models/area.dart';

enum Stato { ND, SUPERATO, RIFIUTATO, IN_ATTESA }

enum LinguaInglese { ND, SCARSO, SUFFICIENTE, BUONO, OTTIMO }

enum PercorsoAcademy { IN_ATTESA, IN_CORSO, RITIRATO, TERMINATO }

enum Seniority { ND, JUNIOR, MEDIUM, SENIOR }

enum DisponibilitaLavoro { ND, PRESENZA, REMOTO, IBRIDA }

class Candidato {
  Candidato({
    this.id,
    this.stato,
    this.nome,
    this.cognome,
    this.email,
    this.luogoDiNascita,
    this.dataDiNascita,
    this.residenza,
    this.recapitoTelefonico,
    this.recapitoExtra,
    this.cap,
    this.linguaInglese,
    this.tecnologieConosciute,
    this.softSkills,
    this.altreCompetenzeMaturate,
    this.categoriaProtetta,
    this.ral,
    this.seniority,
    this.disponibilitaLavoro,
    this.dataPrimoContatto,
    this.posizione,
    this.percorsoAcademy,
    this.note,
    this.dareRiscontro,
    this.riscontroInviato,
    this.annuncio,
    this.area,
    this.annuncioID,
    this.areaID,
    this.denominazioneArea,
    this.titoloAnnuncio,
  });

  final int? id;
  final Stato? stato;
  final String? nome;
  final String? cognome;
  final String? email;
  final String? luogoDiNascita;
  final DateTime? dataDiNascita;
  final String? residenza;
  final String? recapitoTelefonico;
  final String? recapitoExtra;
  final String? cap;
  final LinguaInglese? linguaInglese;
  final List<String>? tecnologieConosciute;
  final List<String>? softSkills;
  final List<String>? altreCompetenzeMaturate;
  final bool? categoriaProtetta;
  final double? ral;
  final Seniority? seniority;
  final DisponibilitaLavoro? disponibilitaLavoro;
  final DateTime? dataPrimoContatto;
  final String? posizione;
  final PercorsoAcademy? percorsoAcademy;
  final String? note;
  final bool? dareRiscontro;
  final bool? riscontroInviato;
  final int? annuncioID;
  final int? areaID;
  final Area? area;
  final Annuncio? annuncio;
  final String? denominazioneArea;
  final String? titoloAnnuncio;

  factory Candidato.fromJson(Map<String, dynamic> json) {
    Stato? stato = json['stato'] != null
        ? Stato.values.firstWhere(
            (element) => element.toString() == 'Stato.${json['stato']}')
        : null;

    LinguaInglese? linguaInglese = json['linguaInglese'] != null
        ? LinguaInglese.values.firstWhere((element) =>
            element.toString() == 'LinguaInglese.${json['linguaInglese']}')
        : null;

    Seniority? seniority = json['seniority'] != null
        ? Seniority.values.firstWhere(
            (element) => element.toString() == 'Seniority.${json['seniority']}')
        : null;

    DisponibilitaLavoro? disponibilitaLavoro =
        json['disponibilitaLavoro'] != null
            ? DisponibilitaLavoro.values.firstWhere((element) =>
                element.toString() ==
                'DisponibilitaLavoro.${json['disponibilitaLavoro']}')
            : null;

    return Candidato(
      id: json['id'],
      stato: stato,
      nome: json['nome'],
      cognome: json['cognome'],
      email: json['email'],
      luogoDiNascita: json['luogoNascita'],
      dataDiNascita: json['dataNascita'] != null
          ? DateTime.parse(json['dataNascita'])
          : null,
      residenza: json['residenza'],
      recapitoTelefonico: json['recapitoTelefonico'],
      recapitoExtra: json['recapitoExtra'],
      cap: json['cap'],
      linguaInglese: linguaInglese,
      tecnologieConosciute: json['tecnologieConosciute'] != null
          ? List<String>.from(json['tecnologieConosciute'])
          : null,
      softSkills: json['softSkills'] != null
          ? List<String>.from(json['softSkills'])
          : null,
      altreCompetenzeMaturate: json['altreCompetenzeMaturate'] != null
          ? List<String>.from(json['altreCompetenzeMaturate'])
          : null,
      categoriaProtetta: json['categoriaProtetta'],
      ral: json['ral'],
      seniority: seniority,
      disponibilitaLavoro: disponibilitaLavoro,
      dataPrimoContatto: json['dataPrimoContatto'] != null
          ? DateTime.parse(json['dataPrimoContatto'])
          : null,
      posizione: json['posizione'],
      percorsoAcademy: json['percorsoAcademy'],
      note: json['note'],
      dareRiscontro: json['dareRiscontro'],
      riscontroInviato: json['riscontroInviato'],
      annuncio:
          json['annuncio'] != null ? Annuncio.fromJson(json['annuncio']) : null,
      area: json['area'] != null ? Area.fromJson(json['area']) : null,
    );
  }

  factory Candidato.fromJsonGetAllCandidato(Map<String, dynamic> json) {
    Stato? stato = json['stato'] != null
        ? Stato.values.firstWhere(
            (element) => element.toString() == 'Stato.${json['stato']}')
        : null;
    return Candidato(
      id: json['id'],
      nome: json['nome'],
      cognome: json['cognome'],
      stato: stato,
      denominazioneArea: json['denominazioneArea'],
      titoloAnnuncio: json['titoloArea'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'cognome': cognome,
      'email': email,
'stato': (stato != null) ? stato.toString().split('.').last : 'ND',
      'luogoDiNascita': luogoDiNascita,
      'dataDiNascita':
          dataDiNascita != null ? dataDiNascita!.toIso8601String() : null,
      'residenza': residenza,
      'recapitoTelefonico': recapitoTelefonico,
      'recapitoExtra': recapitoExtra,
      'cap': cap,
      'linguaInglese': linguaInglese != null ? linguaInglese.toString().split('.').last  : 'ND',
      'tecnologieConosciute': tecnologieConosciute,
      'softSkills': softSkills,
      'altreCompetenzeMaturate': altreCompetenzeMaturate,
      'categoriaProtetta': categoriaProtetta,
      'ral': ral,
      'seniority': (seniority != null) ? seniority.toString().split('.').last  : 'ND',
      'disponibilitaLavoro': (disponibilitaLavoro != null) ?  disponibilitaLavoro.toString().split('.').last  : 'ND',
      'dataPrimoContatto': dataPrimoContatto != null
          ? dataPrimoContatto!.toIso8601String()
          : null,
      'posizione': posizione,
      'percorsoAcademy': percorsoAcademy,
      'note': note,
      'dareRiscontro': dareRiscontro,
      'riscontroInviato': riscontroInviato,
      'annuncio': annuncio != null ? annuncio!.toJson() : null,
      'area': area != null ? area!.toJson() : null,
    };
  }
}
