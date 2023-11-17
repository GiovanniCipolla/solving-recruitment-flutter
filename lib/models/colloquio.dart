// creazione enum tipologia_annuncio
import 'package:solving_recruitment_flutter/models/candidato.dart';
import 'package:solving_recruitment_flutter/models/selezionatore.dart';

enum Tipologia { CONOSCITIVO, TECNICO, FINALE }

enum FeedBackColloquio { OTTIMO, BUONO, SODDISFACENTE, DUBBIO, NON_ADEGUATO }

class Colloquio {
  Colloquio({
    this.id,
    this.data,
    this.tipologia,
    this.feedback,
    this.candidato,
    this.selezionatore,
    this.note,
    this.idSelezionatore,
    this.idCandidato,
     this.nomeCandidato,
     this.cognomeCandidato,
     this.nomeSelezionatore,
     this.cognomeSelezionatore,
  });

  final int? id;
  final DateTime? data;
  final Tipologia? tipologia;
  final FeedBackColloquio? feedback;
  final Candidato? candidato;
  final Selezionatore? selezionatore;
  final String? note;
  final int? idSelezionatore;
  final int? idCandidato;
  final String? nomeCandidato;
  final String? cognomeCandidato;
  final String? nomeSelezionatore;
  final String? cognomeSelezionatore;

  factory Colloquio.fromJson(Map<String, dynamic> json) {
    FeedBackColloquio? feedback = json['feedback'] != null
        ? FeedBackColloquio.values.firstWhere(
            (element) => element.toString() == 'FeedBack.${json['feedback']}')
        : null;

    Tipologia? tipologia = json['tipologia'] != null
        ? Tipologia.values.firstWhere(
            (element) => element.toString() == 'Tipologia.${json['tipologia']}')
        : null;

    return Colloquio(
      id: json['id'] != null ? json['id'] as int : null,
      data: json['data'] != null ? DateTime.parse(json['data']) : null,
      tipologia: json['tipologia'] != null ? tipologia : null,
      feedback: json['feedback'] != null ? feedback : null,
      candidato: json['candidato'] != null
          ? Candidato.fromJson(json['candidato'])
          : null,
      selezionatore: json['selezionatore'] != null
          ? Selezionatore.fromJson(json['selezionatore'])
          : null,
    );
  }

  factory Colloquio.fromJsonGetAllColloqui(Map<String, dynamic> json) {
    return Colloquio(
      id: json['id'] != null ? json['id'] as int : null,
      data: json['data'] != null ? DateTime.parse(json['data']) : null,
      tipologia: json['tipologia'] != null
          ? Tipologia.values.firstWhere((element) =>
              element.toString() == 'Tipologia.${json['tipologia']}')
          : null,
      feedback: json['feedback'] != null
          ? FeedBackColloquio.values.firstWhere(
              (element) => element.toString() == 'FeedBack.${json['feedback']}')
          : null,
      idCandidato: json['idCandidato'],
      idSelezionatore: json['idSelezionatore'],
      nomeCandidato: json['nomeCandidato'],
      cognomeCandidato: json['cognomeCandidato'],
      nomeSelezionatore: json['nomeSelezionatore'],
      cognomeSelezionatore: json['cognomeSelezionatore'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'data': data != null ? data!.toIso8601String() : null,
      'tipologia': tipologia.toString().split('.').last,
      'feedback': feedback != null ? feedback.toString().split('.').last : null,
      'candidato': candidato?.toJson(),
      'selezionatore': selezionatore?.toJson(),
      'note': note
    };
  }
}
