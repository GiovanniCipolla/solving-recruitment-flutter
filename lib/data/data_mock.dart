import 'package:solving_recruitment_flutter/models/annuncio.dart';
import 'package:solving_recruitment_flutter/models/area.dart';
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

List<Annuncio> annunciMock = [annuncio1, annuncio2, annuncio3];
