import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/widgets/custom_page_widget.dart';

class CandidatoScreen extends StatelessWidget{
    static const String routeName = '/candidato-screen';

  const CandidatoScreen({super.key});

  @override
  Widget build(BuildContext context) {
      return const CustomPageWidget(title: 'Gestione Candidati', body: Placeholder());

  }

}