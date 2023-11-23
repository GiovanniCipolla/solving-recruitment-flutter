import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/bottom_sheet_utils.dart';
import 'package:solving_recruitment_flutter/dialog_utilies.dart';
import 'package:solving_recruitment_flutter/models/colloquio.dart';
import 'package:solving_recruitment_flutter/providers/colloquio_provider.dart';

class CandidatoDetailColloquiItem extends StatelessWidget {
  const CandidatoDetailColloquiItem(
      {super.key,
      required this.title,
      required this.color,
      required this.icon,
      required this.candidatoId,
      required this.tipologia});

  final String title;
  final Color color;
  final Icon icon;
  final int candidatoId;
  final String tipologia;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        showLoadingDialog(context);
        final colloquioProvider =
            Provider.of<ColloquioProvider>(context, listen: false);
        await colloquioProvider.getColloquioByCandidatoByTipologia(
            3, tipologia);
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
       List<Colloquio> colloqui = colloquioProvider.colloqui;
       // ignore: use_build_context_synchronously
       BottomSheetUtils.showListColloqui(context, 'Lista Colloqui ${tipologia}', colloqui);
      },
      child: Card(
          elevation: 5,
          shadowColor: color,
          color: color,
          child: Column(
            children: [
              Icon(
                Icons.assignment,
                color: Theme.of(context).colorScheme.onPrimary,
                size: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 15),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Icon(icon.icon,
                      color: Theme.of(context).colorScheme.onPrimary),
                ],
              )
            ],
          )),
    );
  }
}
