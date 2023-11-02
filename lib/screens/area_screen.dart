import 'package:flutter/widgets.dart';
import 'package:solving_recruitment_flutter/widgets/custom_page_widget.dart';

class AreaScreen extends StatelessWidget{
    static const String routeName = '/area-screen';

  const AreaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPageWidget(title: 'Gestione Aree', body: const Placeholder());
  }

}