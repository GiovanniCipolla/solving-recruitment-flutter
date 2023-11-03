
import 'package:solving_recruitment_flutter/models/area.dart';
import 'package:solving_recruitment_flutter/models/candidato.dart';
import 'package:solving_recruitment_flutter/models/tipologia_annuncio.dart';

class Annuncio {
  Annuncio(
      {this.id,
      required this.titolo,
      required this.descrizione,
      required this.dataInizio,
      required this.dataFine,
      required this.tipologia,
      required this.area,
      this.candidati});

      
  final String? id;
  final String titolo;
  final String descrizione;
  final DateTime dataInizio;
  final DateTime dataFine;
  final TipologiaAnnuncio tipologia;
  final Area area;
  final List<Candidato>? candidati;

  // factory Annuncio.fromJson(Map<String, dynamic> json) {
  //   return Annuncio(
  //     id: json['id'],
  //     titolo: json['titolo'],
  //     descrizione: json['descrizione'],
  //     dataInizio: json['dataInizio'],
  //     dataFine: json['dataFine'],
  //     tipologia: TipologiaAnnuncio.fromJson(json['tipologiaAnnuncio']),
  //     area: Area.fromJson(json['area']),
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'titolo': titolo,
  //     'descrizione': descrizione,
  //     'dataInizio': dataInizio,
  //     'dataFine': dataFine,
  //     'tipologiaAnnuncio': tipologia.toJson(),
  //     'area': area.toJson(),
  //   };
  // }

  // Tipologiaannuncio,
  // area
  // candidati
}
