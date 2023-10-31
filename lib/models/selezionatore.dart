
class Selezionatore {
  Selezionatore(
      {this.id, required this.nome, required this.cognome, this.colloqui});

  String? id;
  String nome;
  String cognome;
  List? colloqui;

  factory Selezionatore.fromJson(Map<String, dynamic> json) {
    return Selezionatore(
      id: json['id'],
      nome: json['nome'],
      cognome: json['cognome'],
      colloqui: json['colloqui'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'cognome': cognome,
      'colloqui': colloqui,
    };
  }
}
