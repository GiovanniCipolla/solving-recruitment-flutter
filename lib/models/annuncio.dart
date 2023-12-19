// ignore_for_file: prefer_null_aware_operators

import 'package:solving_recruitment_flutter/models/area.dart';
import 'package:solving_recruitment_flutter/models/tipologia_annuncio.dart';

class Annuncio {
  Annuncio({
    this.id,
    this.titolo,
    this.descrizione,
    this.dataInizio,
    this.dataFine,
    this.tipologia,
    this.area,
    this.descrizioneArea,
    this.descrizioneTipologia,
    this.attivo,
  });

  final int? id;
  final String? titolo;
  final String? descrizione;
  final DateTime? dataInizio;
  final DateTime? dataFine;
  final TipologiaAnnuncio? tipologia;
  final Area? area;
  final String? descrizioneArea;
  final String? descrizioneTipologia;
  final bool? attivo;

  factory Annuncio.fromJson(Map<String, dynamic> json) {
    return Annuncio(
      id: json['id'] != null ? json['id'] as int : null,
      titolo: json['titolo'] != null ? json['titolo'] as String : null,
      descrizione:
          json['descrizione'] != null ? json['descrizione'] as String : null,
      dataInizio: json['dataInizio'] != null
          ? DateTime.parse(json['dataInizio'])
          : null,
      dataFine:
          json['dataFine'] != null ? DateTime.parse(json['dataFine']) : null,
      tipologia: json['tipologiaAnnuncio'] != null
          ? TipologiaAnnuncio.fromJson(json['tipologiaAnnuncio'])
          : null,
      area: json['area'] != null ? Area.fromJson(json['area']) : null,
      attivo: json['attivo'],
    );
  }

  factory Annuncio.fromJsonGetAllAnnunci(Map<String, dynamic> json) {
    return Annuncio(
      id: json['id'] != null ? json['id'] as int : null,
      titolo: json['titoloAnnuncio'] != null
          ? json['titoloAnnuncio'] as String
          : null,
      dataInizio: json['inizioAnnuncio'] != null
          ? DateTime.parse(json['inizioAnnuncio'])
          : null,
      descrizioneArea: json['denominazioneArea'] != null
          ? json['denominazioneArea'] as String
          : null,
      descrizioneTipologia: json['descrizioneTipologiaAnnuncio'] != null
          ? json['descrizioneTipologiaAnnuncio'] as String
          : null,
      attivo: json['attivo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titolo': titolo,
      'descrizione': descrizione,
      'dataInizio': dataInizio != null ? dataInizio!.toIso8601String() : null,
      'dataFine': dataFine != null ? dataFine!.toIso8601String() : null,
      'tipologiaAnnuncio': tipologia != null ? tipologia!.toJson() : null,
      'area': area != null ? area!.toJson() : null,
      'attivo': attivo,
    };
  }
}

class AnnuncioFiltro {
  int? id;
  String? titolo;
  Area? area;
  DateTime? dataInizio;
  TipologiaAnnuncio? tipologiaAnnuncio;
  int? pageNo;
  int? pageSize;
  String? sortBy;
  String? sortDirection;

  AnnuncioFiltro(
      {this.id,
      this.titolo,
      this.area,
      this.dataInizio,
      this.tipologiaAnnuncio,
      this.pageNo,
      this.pageSize,
      this.sortBy,
      this.sortDirection});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titolo': titolo,
      'area': area != null ? area!.toJson() : null,
      'dataInizio': dataInizio != null ? dataInizio!.toIso8601String() : null,
      'tipologiaAnnuncio':
          tipologiaAnnuncio != null ? tipologiaAnnuncio!.toJson() : null,
      'pageNo': pageNo,
      'pageSize': pageSize,
      'sortBy': sortBy,
      'sortDirection': sortDirection
    };
  }
}

class StatsAnnuncio {
  StatsAnnuncio(
      {this.annuncioStaffTecnico,
      this.annuncioStaffInterno,
      this.annuncioAltro});

  final int? annuncioStaffTecnico;
  final int? annuncioStaffInterno;
  final int? annuncioAltro;

  factory StatsAnnuncio.fromJson(Map<String, dynamic> json) {
    return StatsAnnuncio(
      annuncioStaffTecnico: json['annuncioStaffTecnico'] != null
          ? json['annuncioStaffTecnico'] as int
          : null,
      annuncioStaffInterno: json['annuncioStaffInterno'] != null
          ? json['annuncioStaffInterno'] as int
          : null,
      annuncioAltro:
          json['annuncioAltro'] != null ? json['annuncioAltro'] as int : null,
    );
  }
}
