import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/models/candidato.dart';
import 'package:solving_recruitment_flutter/models/colloquio.dart';
import 'package:solving_recruitment_flutter/widgets/candidato_widgets/filter_modal.dart';
import 'package:solving_recruitment_flutter/widgets/colloquio_widgets/filter_modal_colloquio.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text("Caricamento in corso..."),
          ],
        ),
      );
    },
  );
}

Future<void> openFilterModal(
    BuildContext context, CandidatoFiltro filtro) async {
  await showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: EdgeInsets.all(heightSize(context  ) * 0.015),
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: heightSize(context  ) * 0.0545,
                ),
                 Text('Applica i filtri per la ricerca ', style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.primary),),
                 Divider(
                   color: Theme.of(context).colorScheme.primary,
                   thickness: 2,
                 ),
                SingleChildScrollView(
                  child: FilterModal(
                    candidatoFiltro: filtro,
                  ),
                ),
              ]),
            ),
          );
        },
      );
    },
  );
}

Future<void> openFilterModalColloquio(
    BuildContext context, ColloquioFiltro filtro) async {
  await showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: EdgeInsets.all(heightSize(context  ) * 0.015),
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: heightSize(context  ) * 0.0545,
                ),
                 Text('Applica i filtri per la ricerca ', style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.primary),),
                 Divider(
                   color: Theme.of(context).colorScheme.primary,
                   thickness: 2,
                 ),
                SingleChildScrollView(
                  child: FilterModalColloquio(
                    colloquioFiltro: filtro,
                  ),
                ),
              ]),
            ),
          );
        },
      );
    },
  );
}
