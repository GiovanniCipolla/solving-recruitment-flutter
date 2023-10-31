
enum Stato { superato, rifiutato, in_attesa }

enum LinguaInglese { a1, a2, b1, b2, c1, c2 }

enum PercorsoAcademy { in_attesa, in_corso, ritirato, terminato }

enum Seniority { junior, medium, senior }

enum DisponibiltaLavoro { presenza, ibrida, remoto }

class Candidato {
  Candidato({
    this.id,
    required this.stato,
    required this.nome,
    required this.cognome,
    required this.email,
    required this.luogoDiNascita,
    required this.dataDiNascita,
    required this.residenza,
    required this.recapitoTelefonico,
    this.recapitoExtra,
    required this.cap,
    required this.linguaInglese,
    required this.tecnologieConosciute,
    this.softSkills,
    this.altreCompetenzeMaturate,
    required this.categoriaProtetta,
    required this.ral,
    required this.seniority,
    required this.disponibilitaLavoro,
    required this.dataPrimoContatto,
    this.percorsoAcademy,
    this.note,
    required this.dareRiscontro,
    required this.riscontroInviato,
  });

  final String? id;
  final Stato stato;
  final String nome;
  final String cognome;
  final String email;
  final String luogoDiNascita;
  final DateTime dataDiNascita;
  final String residenza;
  final String recapitoTelefonico;
  final String? recapitoExtra;
  final String cap;
  final LinguaInglese linguaInglese;
  final String tecnologieConosciute;
  final String? softSkills;
  final String? altreCompetenzeMaturate;
  final bool categoriaProtetta;
  final double? ral;
  final Seniority seniority;
  final DisponibiltaLavoro disponibilitaLavoro;
  final DateTime dataPrimoContatto;
  final PercorsoAcademy? percorsoAcademy;
  final String? note;
  final bool dareRiscontro;
  final bool riscontroInviato;

  factory Candidato.fromJson(Map<String, dynamic> json) {
    return Candidato(
      id: json['id'],
      stato: json['stato'],
      nome: json['nome'],
      cognome: json['cognome'],
      email: json['email'],
      luogoDiNascita: json['luogoDiNascita'],
      dataDiNascita: json['dataDiNascita'],
      residenza: json['residenza'],
      recapitoTelefonico: json['recapitoTelefonico'],
      recapitoExtra: json['recapitoExtra'],
      cap: json['cap'],
      linguaInglese: json['linguaInglese'],
      tecnologieConosciute: json['tecnologieConosciute'],
      softSkills: json['softSkills'],
      altreCompetenzeMaturate: json['altreCompetenzeMaturate'],
      categoriaProtetta: json['categoriaProtetta'],
      ral: json['ral'],
      seniority: json['seniority'],
      disponibilitaLavoro: json['disponibilitaLavoro'],
      dataPrimoContatto: json['dataPrimoContatto'],
      percorsoAcademy: json['percorsoAcademy'],
      note: json['note'],
      dareRiscontro: json['dareRiscontro'],
      riscontroInviato: json['riscontroInviato'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stato': stato,
      'nome': nome,
      'cognome': cognome,
      'email': email,
      'luogoDiNascita': luogoDiNascita,
      'dataDiNascita': dataDiNascita,
      'residenza': residenza,
      'recapitoTelefonico': recapitoTelefonico,
      'recapitoExtra': recapitoExtra,
      'cap': cap,
      'linguaInglese': linguaInglese,
      'tecnologieConosciute': tecnologieConosciute,
      'softSkills': softSkills,
      'altreCompetenzeMaturate': altreCompetenzeMaturate,
      'categoriaProtetta': categoriaProtetta,
      'ral': ral,
      'seniority': seniority,
      'disponibilitaLavoro': disponibilitaLavoro,
      'dataPrimoContatto': dataPrimoContatto,
      'percorsoAcademy': percorsoAcademy,
      'note': note,
      'dareRiscontro': dareRiscontro,
      'riscontroInviato': riscontroInviato,
    };
  }

  // area,annuncio,colloqui
}
