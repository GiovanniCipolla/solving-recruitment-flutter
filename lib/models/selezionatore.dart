class Selezionatore {
  Selezionatore({
    this.id,
    this.nome,
    this.cognome,
  });

  int? id;
  String? nome;
  String? cognome;

  factory Selezionatore.fromJson(Map<String, dynamic> json) {
    return Selezionatore(
      id: json['id'] != null ? json['id'] as int : null,
      nome: json['nome'] != null ? json['nome'] as String : null,
      cognome: json['cognome'] != null ? json['cognome'] as String : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'cognome': cognome,
    };
  }
}
