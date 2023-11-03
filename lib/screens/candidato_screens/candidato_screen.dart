import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_appbar.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_end_drawer.dart';

class CandidatoScreen extends StatelessWidget {
  static const String routeName = '/candidato-screen';

  const CandidatoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppbar(
        title: 'Gestione Candidati',
      ),
      endDrawer: CustomEndDrawer(),
    );
  }
}
