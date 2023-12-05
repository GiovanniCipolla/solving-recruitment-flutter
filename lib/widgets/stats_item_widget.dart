import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/models/area.dart';

class StatsItemWidget extends StatelessWidget {
  const StatsItemWidget({super.key, required this.stats});

  final StatsArea stats;

  @override
  Widget build(BuildContext context) {
    stats.candidatiStaffInterno ?? 0;
    stats.candidatiStaffTecnico ?? 0;
    stats.candidatoAltro ?? 0;
    final totaleCandidati = stats.candidatiStaffInterno! +
        stats.candidatiStaffTecnico! +
        stats.candidatoAltro!;

    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      elevation: 2,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const SizedBox(
          height: 10,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            'Totale candidati : ',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 18),
          ),
          Text(
            totaleCandidati.toString(),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 20),
          ),
        ]),
        Divider(
          color: Theme.of(context).colorScheme.onPrimary,
          thickness: 1.5,
        ),
        ListTile(
          title: Text(
            'Staff Tecnico : ',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary, fontSize: 16),
          ),
          trailing: Text(
            stats.candidatiStaffTecnico.toString(),
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary, fontSize: 16),
          ),
        ),
        ListTile(
          title: Text(
            'Staff Interno : ',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary, fontSize: 16),
          ),
          trailing: Text(
            stats.candidatiStaffInterno.toString(),
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary, fontSize: 16),
          ),
        ),
        ListTile(
          title: Text(
            'Altro : ',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary, fontSize: 16),
          ),
          trailing: Text(
            stats.candidatoAltro.toString(),
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary, fontSize: 16),
          ),
        ),
      ]),
    );
  }
}
