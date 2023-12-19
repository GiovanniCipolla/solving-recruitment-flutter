// ignore_for_file: prefer_null_aware_operators, constant_identifier_names

import 'package:solving_recruitment_flutter/models/annuncio.dart';
import 'package:solving_recruitment_flutter/models/area.dart';

enum Stato { ND, ASSUNTO, ISCRITTO, IDONEO, RIFIUTATO, IN_ATTESA }

enum LinguaInglese { ND, SCARSO, SUFFICIENTE, BUONO, OTTIMO }

enum PercorsoAcademy { ND, IN_ATTESA, IN_CORSO, RITIRATO, TERMINATO}

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
    this.cvObjectKey,
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
  final String? cvObjectKey;


 


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

            PercorsoAcademy? percorsoAcademy = json['percorsoAcademy'] != null
            ? PercorsoAcademy.values.firstWhere((element) =>
                element.toString() ==
                'PercorsoAcademy.${json['percorsoAcademy']}')
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
      percorsoAcademy: percorsoAcademy,
      note: json['note'],
      dareRiscontro: json['dareRiscontro'],
      riscontroInviato: json['riscontroInviato'],
      annuncio:
          json['annuncio'] != null ? Annuncio.fromJson(json['annuncio']) : null,
      area: json['area'] != null ? Area.fromJson(json['area']) : null,
      cvObjectKey: json['cvObjectKey'],
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
      'luogoNascita': luogoDiNascita,
      'dataNascita':
          dataDiNascita != null ? dataDiNascita!.toIso8601String() : null,
      'residenza': residenza,
      'recapitoTelefonico': recapitoTelefonico,
      'recapitoTelefonicoExtra': recapitoExtra,
      'cap': cap,
      'linguaInglese': linguaInglese != null
          ? linguaInglese.toString().split('.').last
          : 'ND',
      'tecnologieConosciute': tecnologieConosciute,
      'softSkills': softSkills,
      'altreCompetenzeMaturate': altreCompetenzeMaturate,
      'categoriaProtetta': categoriaProtetta,
      'ral': ral,
      'note': note,
      'seniority':
          (seniority != null) ? seniority.toString().split('.').last : 'ND',
      'disponibilitaLavoro': (disponibilitaLavoro != null)
          ? disponibilitaLavoro.toString().split('.').last
          : 'ND',
      'dataPrimoContatto': dataPrimoContatto != null
          ? dataPrimoContatto!.toIso8601String()
          : null,
      'posizione': posizione ,
       'percorsoAcademy': percorsoAcademy != null
          ? percorsoAcademy!.toString().split('.').last
          : PercorsoAcademy.ND.toString().split('.').last,
      'dareRiscontro': dareRiscontro,
      'riscontroInviato': riscontroInviato,
      'annuncio': annuncio != null ? annuncio!.toJson() : null,
      'area': area != null ? area!.toJson() : null,
      'cvObjectKey': cvObjectKey,
    };
  }

  @override
  String toString() {
    return '$nome $cognome';
  }
}

class CandidatoFiltro {
  int? id;
  String? nome;
  String? cognome;
  Stato? stato;
  DateTime? dataNascita;
  String? email;
  int? etaMin;
  int? etaMax;
  String? recapitoTelefonico;
  DateTime? dataPrimoContatto;
  int? pageNo;
  int? pageSize;
  String? sortBy;
  String? sortDirection;
  Seniority? seniority;
  DisponibilitaLavoro? disponibilitaLavoro;
  String? posizione;
  Area? area;
  Annuncio? annuncio;

  CandidatoFiltro(
      {this.id,
      this.nome,
      this.cognome,
      this.stato,
      this.dataNascita,
      this.email,
      this.etaMin,
      this.etaMax,
      this.recapitoTelefonico,
      this.dataPrimoContatto,
      this.pageNo,
      this.pageSize,
      this.sortBy,
      this.sortDirection,
      this.seniority,
      this.disponibilitaLavoro,
      this.posizione,
      this.area,
      this.annuncio});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'cognome': cognome,
      'stato': (stato != null) ? stato.toString().split('.').last : null,
      'dataNascita':
          dataNascita != null ? dataNascita!.toIso8601String() : null,
      'email': email,
      'etaMin': etaMin,
      'etaMax': etaMax,
      'recapitoTelefonico': recapitoTelefonico,
      'dataPrimoContatto': dataPrimoContatto != null
          ? dataPrimoContatto!.toIso8601String()
          : null,
      'pageNo': pageNo,
      'pageSize': pageSize,
      'sortBy': sortBy,
      'sortDirection': sortDirection,
      'seniority':
          (seniority != null) ? seniority.toString().split('.').last : 'ND',
      'disponibilitaLavoro': (disponibilitaLavoro != null)
          ? disponibilitaLavoro.toString().split('.').last
          : 'ND',
      'posizione': posizione,
      'area': area != null ? area!.toJsonForFilterCandidato() : null,
      'annuncio': annuncio != null ? annuncio!.toJson() : null
    };
  }
}
