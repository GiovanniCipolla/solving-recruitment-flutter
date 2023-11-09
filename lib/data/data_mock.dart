// import 'package:solving_recruitment_flutter/models/annuncio.dart';
// import 'package:solving_recruitment_flutter/models/area.dart';
// import 'package:solving_recruitment_flutter/models/candidato.dart';
// import 'package:solving_recruitment_flutter/models/selezionatore.dart';
// import 'package:solving_recruitment_flutter/models/tipologia_annuncio.dart';
class AreaMock {
  final String denominazione;
  final double percentuale;

  AreaMock({required this.denominazione, required this.percentuale});
}

class Candidate {
  final String name;
  final String area;

  Candidate({required this.name, required this.area});
}

List<Candidate> generateMockCandidates = [
  Candidate(name: 'Alice', area: 'Area A'),
  Candidate(name: 'Bob', area: 'Area B'),
  Candidate(name: 'Charlie', area: 'Area C'),
  Candidate(name: 'David', area: 'Area A'),
  Candidate(name: 'Eva', area: 'Area B'),
  Candidate(name: 'Frank', area: 'Area C'),
  Candidate(name: 'Grace', area: 'Area A'),
];

List<AreaMock> areasMock = calculatePercentages();

List<AreaMock> calculatePercentages() {
  final areaCounts = <String, int>{};

  for (final candidate in generateMockCandidates) {
    final area = candidate.area;
    areaCounts[area] = (areaCounts[area] ?? 0) + 1;
  }

  final totalCandidates = generateMockCandidates.length;

  final List<AreaMock> result = [];

  areaCounts.forEach((area, count) {
    final percentage = (count / totalCandidates) * 100;
    result.add(AreaMock(denominazione: area, percentuale: percentage));
  });

  return result;
}
// Annuncio annuncio1 = Annuncio(
//   titolo: 'Sviluppo mobile',
//   descrizione: 'Siamo alla ricerca di un candidato che sappia usare Flutter',
//   area: area1,
//   tipologia: tipologiaAnnuncio1,
//   dataInizio: DateTime.now(),
//   dataFine: DateTime(DateTime.now().year + 1),
// );
// Annuncio annuncio2 = Annuncio(
//   titolo: 'Sviluppo J2ee',
//   descrizione: 'Siamo alla ricerca di un candidato che sappia usare Java',
//   area: area1,
//   tipologia: tipologiaAnnuncio2,
//   dataInizio: DateTime.now(),
//   dataFine: DateTime(DateTime.now().year + 1),
// );
// Annuncio annuncio3 = Annuncio(
//   titolo: 'Help Desk',
//   descrizione:
//       'Siamo alla ricerca di un candidato che possa inserirsi nel nostro staff interno',
//   area: area2,
//   tipologia: tipologiaAnnuncio3,
//   dataInizio: DateTime.now(),
//   dataFine: DateTime(DateTime.now().year + 1),
// );

// TipologiaAnnuncio tipologiaAnnuncio1 = TipologiaAnnuncio(descrizione: 'Java');
// TipologiaAnnuncio tipologiaAnnuncio2 =
//     TipologiaAnnuncio(descrizione: 'Flutter');
// TipologiaAnnuncio tipologiaAnnuncio3 =
//     TipologiaAnnuncio(descrizione: 'Help Desk');

// Area area1 = Area(denominazione: 'Staff Tecnico');
// Area area2 = Area(denominazione: 'Staff interno');
// Area areaA1 = Area(denominazione: 'Staff Tecnico');
// Area areaA2 = Area(denominazione: 'Staff interno');
// Area areaA3 = Area(denominazione: 'Altro');

// List<Annuncio> annunciMock = [annuncio1, annuncio2, annuncio3];
// List<Area> areasMock = [areaA1, areaA2, areaA3];
// List<TipologiaAnnuncio> tipologieAnnuncioMock = [
//   tipologiaAnnuncio1,
//   tipologiaAnnuncio2,
//   tipologiaAnnuncio3
// ];

// Selezionatore selezionatore1 = Selezionatore(
//   nome: 'Alberto',
//   cognome: 'Multari',
// );
// Selezionatore selezionatore2 = Selezionatore(
//   nome: 'Mariangela',
//   cognome: 'Piccinini',
// );
// Selezionatore selezionatore3 = Selezionatore(
//   nome: 'Caterina',
//   cognome: 'Avenali',
// );

// List<Selezionatore> selezionatoriMock = [
//   selezionatore1,
//   selezionatore2,
//   selezionatore3
// ];

// class CandidatoProva {
//   CandidatoProva(
//       {required this.nome,
//       required this.cognome,
//       required this.stato,
//       required this.area,
//       required this.annuncio,
//       required this.email});

//   final String email;
//   final Annuncio annuncio;
//   final Area area;
//   final String nome;
//   final String cognome;
//   final Stato stato;
// }

// CandidatoProva candidato1 = CandidatoProva(
//     nome: 'Lorenzo',
//     cognome: 'Granata',
//     stato: Stato.SUPERATO,
//     area: areaA1,
//     annuncio: annuncio1,
//     email: 'lore@lore.it');
// CandidatoProva candidato2 = CandidatoProva(
//     nome: 'David',
//     cognome: 'Leone',
//     stato: Stato.IN_ATTESA,
//     area: areaA2,
//     annuncio: annuncio2,
//     email: 'dav@davit');
// CandidatoProva candidato3 = CandidatoProva(
//     nome: 'Giulia',
//     cognome: 'Cimino',
//     stato: Stato.RIFIUTATO,
//     area: area1,
//     annuncio: annuncio3,
//     email: 'giu@giu.it');
// CandidatoProva candidato4 = CandidatoProva(
//     nome: 'Cristian',
//     cognome: 'Piarulli',
//     stato: Stato.IN_ATTESA,
//     area: areaA1,
//     annuncio: annuncio1,
//     email: 'cri@criit');
// CandidatoProva candidato5 = CandidatoProva(
//     nome: 'Alexadnru',
//     cognome: 'Stefu',
//     stato: Stato.IN_ATTESA,
//     area: areaA2,
//     annuncio: annuncio3,
//     email: 'ale@ale.it');
// CandidatoProva candidato6 = CandidatoProva(
//     nome: 'Gabriel',
//     cognome: 'Scarlat',
//     stato: Stato.SUPERATO,
//     area: areaA2,
//     annuncio: annuncio2,
//     email: 'gab@gab');
// CandidatoProva candidato7 = CandidatoProva(
//     nome: 'Simone',
//     cognome: 'Riillo',
//     stato: Stato.SUPERATO,
//     area: areaA1,
//     annuncio: annuncio1,
//     email: 'sim@sim.it');
// CandidatoProva candidato8 = CandidatoProva(
//     nome: 'Ludovica',
//     cognome: 'Guiducci',
//     stato: Stato.RIFIUTATO,
//     area: areaA1,
//     annuncio: annuncio2,
//     email: 'lud@lud.it');

// List<CandidatoProva> candidatiMock = [
//   candidato1,
//   candidato2,
//   candidato3,
//   candidato4,
//   candidato5,
//   candidato6,
//   candidato7,
//   candidato8
// ];

// // Colloquio colloquio1 = Colloquio(
// //   data: DateTime.now(),
// //   candidato: candidato1,
// //   selezionatore: selezionatore1,
// //   tipologia: Tipologia.conoscitivo,
// // );
// // Colloquio colloquio2 = Colloquio(
// //     data: DateTime.now(),
// //     candidato: candidato2,
// //     selezionatore: selezionatore2,
// //     tipologia: Tipologia.finale,
// //     feedbackColloquio: FeedbackColloquio.non_adeguato);
// // Colloquio colloquio3 = Colloquio(
// //   data: DateTime.now(),
// //   candidato: candidato3,
// //   selezionatore: selezionatore3,
// //   tipologia: Tipologia.conoscitivo,
// // );
// // Colloquio colloquio4 = Colloquio(
// //     data: DateTime.now(),
// //     candidato: candidato4,
// //     selezionatore: selezionatore1,
// //     tipologia: Tipologia.tecnico,
// //     feedbackColloquio: FeedbackColloquio.buono);

// // List<Colloquio> colloquiMock = [colloquio1, colloquio2, colloquio3, colloquio4];
