import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/models/annuncio.dart';
import 'package:solving_recruitment_flutter/models/candidato.dart';
import 'package:solving_recruitment_flutter/models/colloquio.dart';
import 'package:solving_recruitment_flutter/screens/annuncio_screens/annuncio_detail_screen.dart';


class BottomSheetUtils {
  static Widget _buildInfoCandidati(Candidato candidato) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                candidato.nome ?? "Nome mancante",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                candidato.cognome ?? "Cognome mancante",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              Text(candidato.email ?? "Email mancante",
                  style: const TextStyle(
                    fontSize: 14,
                  ))
            ],
          ),
          const Divider(
            thickness: 0.5,
          )
        ],
      ),
    );
  }

  static Widget _buildInfoAnnuncio(Annuncio annuncio, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AnnuncioDetailScreen(annuncio: annuncio)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  annuncio.titolo ?? "Titolo mancante",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Spacer(),
                Text(DateFormat('yyyy-MM-dd').format(annuncio.dataInizio ?? DateTime.now()),
                    style: const TextStyle(
                      fontSize: 14,
                    ))
              ],
            ),
            const Divider(
              thickness: 0.5,
            )
          ],
        ),
      ),
    );
  }
  static Widget _buildInfoColloquio(Colloquio colloquio) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                tipologiaMap[colloquio.tipologia] ?? "Errore",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              const Spacer(),
              Text(feedbackLabelMap[colloquio.feedback] ?? "Da dare feedback",
                  style:  TextStyle(
                    fontSize: 14,
                    color: feedbackColorMap[colloquio.feedback],
                  ))
            ],
          ),
          const Divider(
            thickness: 0.5,
          )
        ],
      ),
    );
  }
  static Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Flexible(
                child: Text(
                  value ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 0.5,
          )
        ],
      ),
    );
  }

  static Widget _buildInfoRowForList(String label, List<String>? values) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            if (values != null && values.isNotEmpty)
              Wrap(children: [
                const SizedBox(
                  width: 5,
                ),
                for (String value in values)
                  Text(
                    '- $value',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
              ]),
            if (values == null || values.isEmpty)
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(''),
              ),
            const Divider(
              thickness: 0.5,
            )
          ],
        ),
      ),
    );
  }

  static String calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;

    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }

    return age.toString();
  }

  static void showSchedaAnagrafica(BuildContext context, Candidato candidato) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      )),
      isScrollControlled: false,
      enableDrag: true,
      isDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Scheda Anagrafica',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Divider(
                  color: Theme.of(context).colorScheme.primary,
                  thickness: 2,
                ),
                _buildInfoRow('Nome', candidato.nome),
                _buildInfoRow('Cognome', candidato.cognome),
                _buildInfoRow(
                  'Età',
                  candidato.dataDiNascita != null
                      ? calculateAge(candidato.dataDiNascita!)
                      : '',
                ),
               Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'E-Mail',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Flexible(
                child: Text(
                  candidato.email ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 0.5,
          )
        ],
      ),
    ),
                _buildInfoRow('Luogo di Nascita', candidato.luogoDiNascita),
                _buildInfoRow(
                  'Data di Nascita',
                  candidato.dataDiNascita != null
                      ? DateFormat('dd/MM/yyyy')
                          .format(candidato.dataDiNascita!)
                      : '',
                ),
                _buildInfoRow('Residenza', candidato.residenza),
                _buildInfoRow(
                    'Recapito Telefonico', candidato.recapitoTelefonico),
                _buildInfoRow('Recapito Extra', candidato.recapitoExtra),
                _buildInfoRow('CAP', candidato.cap),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showRecensiamo(BuildContext context, Candidato candidato) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      )),
      isScrollControlled: false,
      enableDrag: true,
      isDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recensioni',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Divider(
                color: Theme.of(context).colorScheme.primary,
                thickness: 2,
              ),
              _buildInfoRow('Stato', statoCandidatoMap[candidato.stato]),
              _buildInfoRow(
                  'Dare riscontro', candidato.dareRiscontro! ? 'SI' : 'No'),
              candidato.dareRiscontro!
                  ? _buildInfoRow('Riscontro inviato ',
                      candidato.riscontroInviato! ? 'SI' : 'No')
                  : Container(),
              _buildInfoRow('Note', candidato.note)
            ],
          ),
        );
      },
    );
  }

  static void showInformazioniLavorative(
      BuildContext context, Candidato candidato) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      )),
      isScrollControlled: false,
      enableDrag: true,
      isDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Informazioni Lavorative',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Divider(
                color: Theme.of(context).colorScheme.primary,
                thickness: 2,
              ),
              _buildInfoRow('Categoria Protetta',
                  candidato.categoriaProtetta! ? 'SI' : 'No'),
              _buildInfoRow('Ral richiesta', candidato.ral.toString()),
              _buildInfoRow(
                  'Seniority', seniorityMap[candidato.seniority] ?? ''),
              _buildInfoRow('Posizione', candidato.posizione),
              _buildInfoRow('Disponibilità Lavoro',
                  disponibilitaLavoroMap[candidato.disponibilitaLavoro]),
              _buildInfoRow('Residenza', candidato.residenza),
              // _buildInfoRow(
              //     'Percorso Academy', candidato.percorsoAcademy! ? 'SI' : 'No'),
              _buildInfoRow('Annuncio', candidato.annuncio!.titolo),
              _buildInfoRow('Area di riferimento',
                  candidato.area!.denominazione),
            ],
          ),
        );
      },
    );
  }

  static void showCompetenze(BuildContext context, Candidato candidato) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      )),
      isScrollControlled: false,
      enableDrag: true,
      isDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Competenze Tecniche & Soft Skills',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Divider(
                color: Theme.of(context).colorScheme.primary,
                thickness: 2,
              ),
              _buildInfoRow(
                  'Inglese', linguaIngleseMap[candidato.linguaInglese]),
              _buildInfoRowForList(
                  'Competenze', candidato.tecnologieConosciute),
              _buildInfoRowForList('Soft Skills', candidato.softSkills),
              _buildInfoRowForList(
                  'Altre Competenze', candidato.altreCompetenzeMaturate),
            ],
          ),
        );
      },
    );
  }

  static void showListCandidati(
    BuildContext context,
    String title,
    List<Candidato> candidati,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Divider(
                color: Theme.of(context).colorScheme.primary,
                thickness: 2,
              ),
              // Costruisci la lista utilizzando _buildInfoRow per ogni candidato
             candidati.isEmpty
                ? const Text('Nessun candidato trovato', style: TextStyle(fontSize: 20))
                : Column(
                    children: candidati.map((Candidato candidato) {
                      return _buildInfoCandidati(candidato);
                    }).toList(),
                  ),
            ],
          ),
        );
      },
    );
  }
  static void showListAnnunci(
    BuildContext context,
    String title,
    List<Annuncio> annunci,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Divider(
                color: Theme.of(context).colorScheme.primary,
                thickness: 2,
              ),
              // Costruisci la lista utilizzando _buildInfoRow per ogni candidato
              annunci.isEmpty
                ? const Text('Nessun annuncio trovato', style: TextStyle(fontSize: 20))
                : Column(
                    children: annunci.map((Annuncio annuncio) {
                      return _buildInfoAnnuncio(annuncio, context);
                    }).toList(),
                  ),
            ],
          ),
        );
      },
    );
  }
  static void showListColloqui(
    BuildContext context,
    String title,
    List<Colloquio> colloqui,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Divider(
                color: Theme.of(context).colorScheme.primary,
                thickness: 2,
              ),
             colloqui.isEmpty
                ? const Text('Nessun colloquio trovato', style: TextStyle(fontSize: 20))
                : Column(
                    children: colloqui.map((Colloquio colloquio) {
                      return _buildInfoColloquio(colloquio);
                    }).toList(),
                  ),
            ],
          ),
        );
      },
    );
  }
}
