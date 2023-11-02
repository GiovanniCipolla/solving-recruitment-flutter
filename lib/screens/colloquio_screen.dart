import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/widgets/custom_page_widget.dart';

class ColloquioScreen extends StatelessWidget{
    static const String routeName = '/colloquio-screen';

  const ColloquioScreen({super.key});

  @override
  Widget build(BuildContext context) {
        return const CustomPageWidget(title: 'Gestione Colloqui', body: Placeholder());

  }

}