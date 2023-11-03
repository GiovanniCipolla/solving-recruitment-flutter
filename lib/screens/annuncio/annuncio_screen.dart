import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/data/data_mock.dart';
import 'package:solving_recruitment_flutter/data/drawer_items.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/screens/home.dart';
import 'package:solving_recruitment_flutter/widgets/annuncio_item.dart';

class AnnuncioScreen extends StatelessWidget {
  static const String routeName = '/annuncio-screen';
  const AnnuncioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestione annunci'),
        leading: IconButton(
          icon: Image.asset("assets/images/logoNavbarCoge.png"),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, Home.routeName, (route) => false);
          },
        ),
      ),
      endDrawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.background,
        child: ListView(
          children: drawerItems.map((item) {
            if (item.containsKey('divider')) {
              return Divider(
                thickness: item['thickness'] ?? 1.0,
              );
            } else {
              return ListTile(
                leading: item['icon'] == Icons.logout
                    ? Icon(item['icon'], color: Colors.red)
                    : Icon(item['icon']),
                title: Text(item['title']),
                onTap: () {
                  item['onTap'](context);
                },
                tileColor: item['color'],
              );
            }
          }).toList(),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: heightSize(context) * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceEvenly, // Allinea i pulsanti orizzontalmente
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () {
                  // Aggiungi l'azione da eseguire quando il pulsante "Applica filtri" viene premuto.
                },
                child: const Row(
                  children: [
                    Text('Cerca per'),
                    Icon(
                      Icons.filter_list,
                    )
                  ],
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () {
                  // Aggiungi l'azione da eseguire quando il pulsante "Ordina per" viene premuto.
                },
                child: const Row(
                  children: [
                    Text('Ordina per'),
                    Icon(
                      Icons.sort,
                    )
                  ],
                ),
              ),
            ],
          ),
          Divider(
            color: Theme.of(context).colorScheme.primary,
            thickness: 1.5,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: annunciMock.length,
                shrinkWrap: true,
                physics:
                    const ClampingScrollPhysics(), // Questa opzione impedisce il rollio eccessivo
                itemBuilder: (context, index) {
                  return AnnuncioItem(annuncio: annunciMock[index]);
                },
              ),
            ),
          ),
          Row(
            children: [
              const Spacer(),
              FloatingActionButton(
                onPressed: () {
                  showConfirmationDialog(context, 'Aggiungi annuncio',
                      'Sicuro di voler aggiungere un annuncio?', () {});
                },
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Icon(
                  Icons.add,
                  color: Colors.white, // Colore dell'icona
                ), // Colore di sfondo
              ),
              SizedBox(
            width: heightSize(context) * 0.02,
          )
            ],
          ),
          SizedBox(
            height: heightSize(context) * 0.02,
          )
        ],
      ),
    );
  }
}
