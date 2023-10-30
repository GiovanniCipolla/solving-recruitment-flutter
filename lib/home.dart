import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/costants.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solving Recruitment'),
        leading: Image.asset("assets/images/logoNavbarCoge.png"),
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
                onTap: item['onTap'],
                tileColor: item['color'],
              );
            }
          }).toList(),
        ),
      ),
    );
  }
}
