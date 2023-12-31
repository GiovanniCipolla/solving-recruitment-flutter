import 'package:solving_recruitment_flutter/models/annuncio.dart';
import 'package:solving_recruitment_flutter/models/area.dart';
import 'package:solving_recruitment_flutter/models/candidato.dart';
import 'package:solving_recruitment_flutter/models/colloquio.dart';
import 'package:solving_recruitment_flutter/models/selezionatore.dart';
import 'package:solving_recruitment_flutter/models/tipologia_annuncio.dart';

Annuncio annuncio1 = Annuncio(
  titolo: 'Sviluppo mobile',
  descrizione: 'Siamo alla ricerca di un candidato che sappia usare Flutter',
  area: area1,
  tipologia: tipologiaAnnuncio1,
  dataInizio: DateTime.now(),
  dataFine: DateTime(DateTime.now().year + 1),
);
Annuncio annuncio2 = Annuncio(
  titolo: 'Sviluppo J2ee',
  descrizione: 'Siamo alla ricerca di un candidato che sappia usare Java',
  area: area1,
  tipologia: tipologiaAnnuncio2,
  dataInizio: DateTime.now(),
  dataFine: DateTime(DateTime.now().year + 1),
);
Annuncio annuncio3 = Annuncio(
  titolo: 'Help Desk',
  descrizione:
      'Siamo alla ricerca di un candidato che possa inserirsi nel nostro staff interno',
  area: area2,
  tipologia: tipologiaAnnuncio3,
  dataInizio: DateTime.now(),
  dataFine: DateTime(DateTime.now().year + 1),
);

TipologiaAnnuncio tipologiaAnnuncio1 = TipologiaAnnuncio(descrizione: 'Java');
TipologiaAnnuncio tipologiaAnnuncio2 =
    TipologiaAnnuncio(descrizione: 'Flutter');
TipologiaAnnuncio tipologiaAnnuncio3 =
    TipologiaAnnuncio(descrizione: 'Help Desk');

Area area1 = Area(denominazione: 'Staff Tecnico');
Area area2 = Area(denominazione: 'Staff interno');
Area areaA1 = Area(denominazione: 'Staff Tecnico', annunciLenght: 2);
Area areaA2 = Area(denominazione: 'Staff interno', annunciLenght: 7);
Area areaA3 = Area(denominazione: 'Altro', annunciLenght: 0);

List<Annuncio> annunciMock = [annuncio1, annuncio2, annuncio3];
List<Area> areasMock = [areaA1, areaA2, areaA3];
List<TipologiaAnnuncio> tipologieAnnuncioMock = [
  tipologiaAnnuncio1,
  tipologiaAnnuncio2,
  tipologiaAnnuncio3
];

Selezionatore selezionatore1 = Selezionatore(
  nome: 'Alberto',
  cognome: 'Multari',
);
Selezionatore selezionatore2 = Selezionatore(
  nome: 'Mariangela',
  cognome: 'Piccinini',
);
Selezionatore selezionatore3 = Selezionatore(
  nome: 'Caterina',
  cognome: 'Avenali',
);

List<Selezionatore> selezionatoriMock = [
  selezionatore1,
  selezionatore2,
  selezionatore3
];

class CandidatoProva {
  CandidatoProva(
      {required this.nome,
      required this.cognome,
      required this.stato,
      required this.area,
      required this.annuncio,
      required this.email});

  final String email;
  final Annuncio annuncio;
  final Area area;
  final String nome;
  final String cognome;
  final Stato stato;
}

CandidatoProva candidato1 = CandidatoProva(
    nome: 'Lorenzo',
    cognome: 'Granata',
    stato: Stato.superato,
    area: areaA1,
    annuncio: annuncio1,
    email: 'lore@lore.it');
CandidatoProva candidato2 = CandidatoProva(
    nome: 'David',
    cognome: 'Leone',
    stato: Stato.in_attesa,
    area: areaA2,
    annuncio: annuncio2,
    email: 'dav@davit');
CandidatoProva candidato3 = CandidatoProva(
    nome: 'Giulia',
    cognome: 'Cimino',
    stato: Stato.rifiutato,
    area: area1,
    annuncio: annuncio3,
    email: 'giu@giu.it');
CandidatoProva candidato4 = CandidatoProva(
    nome: 'Cristian',
    cognome: 'Piarulli',
    stato: Stato.in_attesa,
    area: areaA1,
    annuncio: annuncio1,
    email: 'cri@criit');
CandidatoProva candidato5 = CandidatoProva(
    nome: 'Alexadnru',
    cognome: 'Stefu',
    stato: Stato.in_attesa,
    area: areaA2,
    annuncio: annuncio3,
    email: 'ale@ale.it');
CandidatoProva candidato6 = CandidatoProva(
    nome: 'Gabriel',
    cognome: 'Scarlat',
    stato: Stato.superato,
    area: areaA2,
    annuncio: annuncio2,
    email: 'gab@gab');
CandidatoProva candidato7 = CandidatoProva(
    nome: 'Simone',
    cognome: 'Riillo',
    stato: Stato.superato,
    area: areaA1,
    annuncio: annuncio1,
    email: 'sim@sim.it');
CandidatoProva candidato8 = CandidatoProva(
    nome: 'Ludovica',
    cognome: 'Guiducci',
    stato: Stato.rifiutato,
    area: areaA1,
    annuncio: annuncio2,
    email: 'lud@lud.it');

List<CandidatoProva> candidatiMock = [
  candidato1,
  candidato2,
  candidato3,
  candidato4,
  candidato5,
  candidato6,
  candidato7,
  candidato8
];

Colloquio colloquio1 = Colloquio(
  data: DateTime.now(),
  candidato: candidato1,
  selezionatore: selezionatore1,
  tipologia: Tipologia.conoscitivo,
);
Colloquio colloquio2 = Colloquio(
    data: DateTime.now(),
    candidato: candidato2,
    selezionatore: selezionatore2,
    tipologia: Tipologia.finale,
    feedbackColloquio: FeedbackColloquio.non_adeguato);
Colloquio colloquio3 = Colloquio(
  data: DateTime.now(),
  candidato: candidato3,
  selezionatore: selezionatore3,
  tipologia: Tipologia.conoscitivo,
);
Colloquio colloquio4 = Colloquio(
    data: DateTime.now(),
    candidato: candidato4,
    selezionatore: selezionatore1,
    tipologia: Tipologia.tecnico,
    feedbackColloquio: FeedbackColloquio.buono);

List<Colloquio> colloquiMock = [colloquio1, colloquio2, colloquio3, colloquio4];
