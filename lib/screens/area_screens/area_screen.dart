import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/common.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/providers/area_provider.dart';
import 'package:solving_recruitment_flutter/widgets/area_widgets/area_item.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_appbar.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_button_add.dart';
import 'package:solving_recruitment_flutter/widgets/custom/custom_end_drawer.dart';

class AreaScreen extends StatelessWidget {
  static const String routeName = '/area-screen';

  const AreaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final areaProvider = Provider.of<AreaProvider>(context, listen: false);
    
    return WillPopScope(
      onWillPop: () async {
        return backHome(context);
      },
      child: Scaffold(
        appBar: const CustomAppbar(title: 'Gestione Aree'),
        endDrawer: const CustomEndDrawer(),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: heightSize(context) * 0.02),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      FutureBuilder(
                          future: areaProvider.getAreas(),
                          builder: (context, snapshot) {
                            final aree = areaProvider.aree;
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            } else if (aree.isEmpty) {
                              return const Center(
                                  child: Text(
                                'Non ci sono aree',
                              ));
                            } else {
                              return Column(children: [
                                ...aree
                                    .map((item) => AreaItem(area: item))
                                    .toList(),
                              ]);
                            }
                          }),
                      SizedBox(
                        height: heightSize(context) * 0.15,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(
                              'Vai alla gestione academy',
                              style: TextStyle(color: Colors.red),
                            ),
                            const Icon(
                              Icons.arrow_forward,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: widthSize(context) * 0.02,
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 2.0,
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
              ),
              CustomButtonAdd(
                  titleShowDialog: 'Aggiungi Area',
                  descrizioneShowDialog:
                      'Sicuro di voler aggiungere un\' area ?',
                  metodoShowDialog: () {
                    showAlertDialog(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
