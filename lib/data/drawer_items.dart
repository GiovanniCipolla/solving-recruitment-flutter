import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/providers/area_provider.dart';
import 'package:solving_recruitment_flutter/providers/candidato_provider.dart';
import 'package:solving_recruitment_flutter/screens/annuncio_screens/annuncio_screen.dart';
import 'package:solving_recruitment_flutter/screens/area_screens/area_screen.dart';
import 'package:solving_recruitment_flutter/screens/candidato_screens/candidato_screen.dart';
import 'package:solving_recruitment_flutter/screens/colloquio_screens/colloquio_screen.dart';
import 'package:solving_recruitment_flutter/screens/home.dart';
import 'package:solving_recruitment_flutter/screens/login_screen.dart';
import 'package:solving_recruitment_flutter/screens/selezionatore_screens/selezionatore_screen.dart';

final List<Map<String, dynamic>> drawerItems = [
  {
    'icon': Icons.dashboard,
    'title': 'Dashboard',
    'onTap': (context) {
      // Provider.of<AnnuncioProvider>(context, listen: false).getAnnunci();
      Navigator.pushNamed(context, Home.routeName);
    },
  },
  {
    'divider': true,
    'thickness': 2.0,
  },
  {
    'icon': Icons.group,
    'title': 'Gestione Candidati',
    'onTap': (context) {
      Provider.of<CandidatoProvider>(context, listen: false).getCandidati();
      Navigator.pushNamed(context, CandidatoScreen.routeName);
    },
  },
  {
    'divider': true,
    'thickness': 2.0,
  },
  {
    'icon': Icons.category,
    'title': 'Gestione Aree',
    'onTap': (context) async {
     await  Provider.of<AreaProvider>(context, listen: false).getAreas();
      Navigator.pushNamed(context, AreaScreen.routeName);
    },
  },
  {
    'divider': true,
    'thickness': 2.0,
  },
  {
    'icon': Icons.date_range,
    'title': 'Gestione Colloqui',
    'onTap': (context) {
      // Provider.of<AnnuncioProvider>(context, listen: false).getAnnunci();
       Navigator.pushNamed(context, ColloquioScreen.routeName);
    },
  },
  {
    'divider': true,
    'thickness': 2.0,
  },
  {
    'icon': Icons.person_search,
    'title': 'Gestione Selezionatori',
    'onTap': (context) {
      // Provider.of<AnnuncioProvider>(context, listen: false).getAnnunci();
      Navigator.pushNamed(context, SelezionatoreScreen.routeName);
    },
  },
  {
    'divider': true,
    'thickness': 2.0,
  },
  {
    'icon': Icons.announcement,
    'title': 'Gestione Annunci',
    'onTap': (context) {
      // Provider.of<AnnuncioProvider>(context, listen: false).getAnnunci();
      Navigator.pushNamed(context, AnnuncioScreen.routeName);
    },
  },
  {
    'divider': true,
    'thickness': 2.0,
  },
  {
    'icon': Icons.school,
    'title': 'Gestione Academy',
    'onTap': (context) {
      // Provider.of<AnnuncioProvider>(context, listen: false).getAnnunci();
      Navigator.pushNamed(context, AreaScreen.routeName);
    },
  },
   {
    'divider': true,
    'thickness': 2.0,
  },
  {
    'icon': Icons.work,
    'title': 'Gestione Tipologia Annunci',
    'onTap': (context) {
      // Provider.of<AnnuncioProvider>(context, listen: false).getAnnunci();
      // Navigator.pushNamed(context, AreaScreen.routeName);
    },
  },
  {
    'divider': true,
    'thickness': 2.0,
  },
  {
    'icon': Icons.logout,
    'title': 'Logout',
    'onTap': (context) {
      // Provider.of<AnnuncioProvider>(context, listen: false).getAnnunci();
      Navigator.pushNamed(context, LoginScreen.routeName);
    },
  },
];
