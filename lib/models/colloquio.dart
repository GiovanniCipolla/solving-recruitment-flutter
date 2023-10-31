
// creazione enum tipologia_annuncio
enum Tipologia { conoscitivo, tecnico, finale }

enum Feedback { ottimo, buono, soddisfacente, dubbio, non_adeguato }

class Colloquio {
  Colloquio({
    this.id,
    required this.data,
    required this.tipologia,
    this.feedback,
  });

  final String? id;
  final DateTime data;
  final Tipologia tipologia;
  final Feedback? feedback;
  // String note;
  // Selezionatore(candidato),

  factory Colloquio.fromJson(Map<String, dynamic> json) {
    return Colloquio(
      id: json['id'],
      data: json['data'],
      tipologia: json['tipologia'],
      feedback: json['feedback'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'data': data,
      'tipologia': tipologia,
      'feedback': feedback,
    };
  }
}
