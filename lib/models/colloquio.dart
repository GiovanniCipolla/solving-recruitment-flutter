
// creazione enum tipologia_annuncio
import 'package:solving_recruitment_flutter/data/data_mock.dart';
import 'package:solving_recruitment_flutter/models/selezionatore.dart';

enum Tipologia { conoscitivo, tecnico, finale }

enum FeedbackColloquio { ottimo, buono, soddisfacente, dubbio, non_adeguato }

class Colloquio {
  Colloquio({
    this.id,
    required this.data,
    required this.tipologia,
    this.feedbackColloquio,
    required this.candidato,
    required this.selezionatore,
  });

  final String? id;
  final DateTime data;
  final Tipologia tipologia;
  final FeedbackColloquio? feedbackColloquio;
  CandidatoProva candidato;
  Selezionatore selezionatore;
  // String note;
  // Selezionatore(candidato),

  // factory Colloquio.fromJson(Map<String, dynamic> json) {
  //   return Colloquio(
  //     id: json['id'],
  //     data: json['data'],
  //     tipologia: json['tipologia'],
  //     feedback: json['feedback'], candidato: ,
  //   );
  // }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'data': data,
      'tipologia': tipologia,
      'feedback': feedbackColloquio,
    };
  }
}
