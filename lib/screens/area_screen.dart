import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/data/data_mock.dart';
import 'package:solving_recruitment_flutter/data/drawer_items.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/screens/home.dart';
import 'package:solving_recruitment_flutter/widgets/area_item.dart';

class AreaScreen extends StatelessWidget {
  static const String routeName = '/area-screen';

  const AreaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestione aree'),
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...areasMock.map((item) => AreaItem(area: item)).toList()
                ],
              ),
            ),
          ),
          Row(
            children: [
              const Spacer(),
              FloatingActionButton(
                onPressed: () {
                  showConfirmationDialog(context, 'Aggiungi Area',
                      'Sicuro di voler aggiungere un\' area ?', () {});
                },
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: heightSize(context) * 0.02,
              )
            ],
          ),
          SizedBox(
            height: heightSize(context) * 0.02,
          ),
        ],
      ),
    );
  }
}
