
enum Stato {
  SUPERATO,
  RIFIUTATO,
  IN_ATTESA
}


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
    // required this.annuncio,
    // required this.area
  });

  // final Annuncio annuncio;
  // final Area area;
  final int? id;
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
  final List<String> tecnologieConosciute;
  final List<String>? softSkills;
  final List<String>? altreCompetenzeMaturate;
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
      dataDiNascita: DateTime.parse(json['dataDiNascita']),
      residenza: json['residenza'],
      recapitoTelefonico: json['recapitoTelefonico'],
      recapitoExtra: json['recapitoExtra'],
      cap: json['cap'],
      linguaInglese: json['linguaInglese'],
      tecnologieConosciute: List<String>.from(json['tecnologieConosciute']),
      softSkills: json['softSkills'] != null
          ? List<String>.from(json['softSkills'])
          : null,
      altreCompetenzeMaturate: json['altreCompetenzeMaturate'] != null
          ? List<String>.from(json['altreCompetenzeMaturate'])
          : null,
      categoriaProtetta: json['categoriaProtetta'],
      ral: json['ral'],
      seniority: json['seniority'],
      disponibilitaLavoro: json['disponibilitaLavoro'],
      dataPrimoContatto: DateTime.parse(json['dataPrimoContatto']),
      percorsoAcademy: json['percorsoAcademy'],
      note: json['note'],
      dareRiscontro: json['dareRiscontro'],
      riscontroInviato: json['riscontroInviato'],
      // annuncio: Annuncio.fromJson(json['annuncio']),
      // area: Area.fromJson(json['area']),
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
      'dataDiNascita': dataDiNascita.toIso8601String(),
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
      'dataPrimoContatto': dataPrimoContatto.toIso8601String(),
      'percorsoAcademy': percorsoAcademy,
      'note': note,
      'dareRiscontro': dareRiscontro,
      'riscontroInviato': riscontroInviato,
      // 'annuncio': annuncio.toJson(),
      // 'area': area.toJson(),
    };
  }
}
