import 'package:solving_recruitment_flutter/models/area.dart';
import 'package:solving_recruitment_flutter/models/candidato.dart';
import 'package:solving_recruitment_flutter/models/tipologia_annuncio.dart';

class Annuncio {
  Annuncio(
      {this.id,
      this.titolo,
      this.descrizione,
      this.dataInizio,
      this.dataFine,
      this.tipologia,
      this.area,
      this.candidati});

  final int? id;
  final String? titolo;
  final String? descrizione;
  final DateTime? dataInizio;
  final DateTime? dataFine;
  final TipologiaAnnuncio? tipologia;
  final Area? area;
  final List<Candidato>? candidati;

  factory Annuncio.fromJson(Map<String, dynamic> json) {
    return Annuncio(
      id: json['id'],
      titolo: json['titolo'],
      descrizione: json['descrizione'],
      dataInizio: DateTime.parse(json['dataInizio']),
      dataFine: DateTime.parse(json['dataFine']),
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

  // Tipologiaannuncio,
  // area
  // candidati
}
