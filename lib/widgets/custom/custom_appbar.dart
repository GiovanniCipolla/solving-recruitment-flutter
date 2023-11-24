import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/screens/home.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key, required this.title});
  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) => AppBar(
        title: Text(title, style: TextStyle(color: Theme.of(context).colorScheme.primary),),
        leading: IconButton(
          icon: Icon(Icons.home_filled, color: Theme.of(context).colorScheme.primary),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, Home.routeName, (route) => false);
          },
        ),
      );
}
