
class Annuncio {
  Annuncio(
      {this.id,
      required this.titolo,
      required this.descrizione,
      required this.dataInizio,
      required this.ddataFine});

      
  final String? id;
  final String titolo;
  final String descrizione;
  final DateTime dataInizio;
  final DateTime ddataFine;

  factory Annuncio.fromJson(Map<String, dynamic> json) {
    return Annuncio(
      id: json['id'],
      titolo: json['titolo'],
      descrizione: json['descrizione'],
      dataInizio: json['dataInizio'],
      ddataFine: json['ddataFine'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titolo': titolo,
      'descrizione': descrizione,
      'dataInizio': dataInizio,
      'ddataFine': ddataFine,
    };
  }

  // Tipologiaannuncio,
  // area
  // candidati
}
