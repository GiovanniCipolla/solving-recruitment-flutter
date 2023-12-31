import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/data/drawer_items.dart';

class CustomEndDrawer extends StatelessWidget implements PreferredSizeWidget {
  const CustomEndDrawer({super.key});

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Definisci l'altezza desiderata

  @override
  Widget build(BuildContext context) => Drawer(
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
      );
}
