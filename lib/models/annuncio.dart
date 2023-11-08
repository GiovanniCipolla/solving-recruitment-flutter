import 'package:solving_recruitment_flutter/models/area.dart';
import 'package:solving_recruitment_flutter/models/tipologia_annuncio.dart';

class Annuncio {
  Annuncio(
      {this.id,
      this.titolo,
      this.descrizione,
      this.dataInizio,
      this.dataFine,
      this.tipologia,
      this.area,});

  final int? id;
  final String? titolo;
  final String? descrizione;
  final DateTime? dataInizio;
  final DateTime? dataFine;
  final TipologiaAnnuncio? tipologia;
  final Area? area;

  factory Annuncio.fromJson(Map<String, dynamic> json) {
    return Annuncio(
      id: json['id'] != null ? json['id'] as int : null,
      titolo: json['titolo'] != null ? json['titolo'] as String : null,
      descrizione: json['descrizione'] != null ? json['descrizione'] as String : null,
      dataInizio: json['dataInizio'] != null ? DateTime.parse(json['dataInizio']) : null,
      dataFine: json['dataFine'] != null ? DateTime.parse(json['dataFine']) : null,
      tipologia: json['tipologiaAnnuncio'] != null
          ? TipologiaAnnuncio.fromJson(json['tipologiaAnnuncio'])
          : null,
      area: json['area'] != null ? Area.fromJson(json['area']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titolo': titolo,
      'descrizione': descrizione,
      'dataInizio': dataInizio,
      'dataFine': dataFine,
      'tipologiaAnnuncio': tipologia?.toJson(),
      'area': area?.toJson(),
    };
  }


}
