class TipologiaAnnuncio {
  TipologiaAnnuncio({
    this.id,
    this.descrizione,
    this.countAnnunci,
  });

  final int? id;
  final String? descrizione;
  final int? countAnnunci;

  factory TipologiaAnnuncio.fromJson(Map<String, dynamic> json) {
    return TipologiaAnnuncio(
      id: json['id'] != null ? json['id'] as int : null,
      descrizione:
          json['descrizione'] != null ? json['descrizione'] as String : null,
      countAnnunci:
          json['countAnnunci'] != null ? json['countAnnunci'] as int : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'descrizione': descrizione, 'countAnnunci': countAnnunci};
  }
}
