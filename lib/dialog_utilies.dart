import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/models/candidato.dart';
import 'package:solving_recruitment_flutter/widgets/candidato_widgets/filter_modal.dart';

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
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return FilterModal(
            candidatoFiltro: filtro,
          );
        },
      );
    },
  );
}
