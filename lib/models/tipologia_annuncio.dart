
class TipologiaAnnuncio {
  TipologiaAnnuncio({
    this.id,
    required this.descrizione,
  });

  final int? id;
  final String descrizione;
  // annunci

  factory TipologiaAnnuncio.fromJson(Map<String, dynamic> json) {
    return TipologiaAnnuncio(
      id: json['id'],
      descrizione: json['descrizione'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descrizione': descrizione,
    };
  }
}
