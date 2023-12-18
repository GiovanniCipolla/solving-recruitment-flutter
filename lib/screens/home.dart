import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/common.dart';
import 'package:solving_recruitment_flutter/models/annuncio.dart';
import 'package:solving_recruitment_flutter/providers/annuncio_provider.dart';
import 'package:solving_recruitment_flutter/providers/area_provider.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_appbar.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_end_drawer.dart';
import 'package:solving_recruitment_flutter/widgets/stats_bar.dart';

class Home extends StatelessWidget {
  static const String routeName = '/home-screen';

  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final areaProvider = Provider.of<AreaProvider>(context, listen: false);
    final annuncioProvider =
        Provider.of<AnnuncioProvider>(context, listen: false);

    return WillPopScope(
      onWillPop: () => showExitDialog(context),
      child: Scaffold(
        appBar: const CustomAppbar(title: 'Solving Recruitment'),
        endDrawer: const CustomEndDrawer(),
        body: Column(
          children: [
            FutureBuilder(
              future: areaProvider.getStatsArea(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  final statsArea = snapshot.data!;
                  return Container(
                    margin: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StatsBar(
                          a: statsArea.candidatiStaffTecnico ?? 0,
                          b: statsArea.candidatiStaffInterno ?? 0,
                          c: statsArea.candidatoAltro ?? 0, title: 'Candidati',
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            FutureBuilder<StatsAnnuncio>(
                future: annuncioProvider.getStatsAnnuncio(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  } else if (snapshot.hasError) {
                    return Column(
                      children: [
                        Text(snapshot.error.toString()),
                      ],
                    );
                  } else {
                    final statsAnnuncio = snapshot.data!;
                    return Container(
                      margin: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          StatsBar(
                            a: statsAnnuncio.annuncioStaffTecnico ?? 0,
                            b: statsAnnuncio.annuncioStaffInterno ?? 0,
                            c: statsAnnuncio.annuncioAltro ?? 0, title: 'Annunci',
                          ),
                        ],
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  Color getColor(int index) {
    List<Color> colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
    ];
    return colors[index % colors.length];
  }
}
