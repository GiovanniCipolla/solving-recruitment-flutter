import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/screens/home.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key, required this.title});
  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) => AppBar(
        title: Text(title),
        leading: IconButton(
          icon: Image.asset("assets/images/logoNavbarCoge.png"),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, Home.routeName, (route) => false);
          },
        ),
      );
}
