import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/providers/annuncio_provider.dart';
import 'package:solving_recruitment_flutter/providers/area_provider.dart';
import 'package:solving_recruitment_flutter/providers/candidato_provider.dart';
import 'package:solving_recruitment_flutter/providers/colloquio_provider.dart';
import 'package:solving_recruitment_flutter/providers/selezionatore_provider.dart';
import 'package:solving_recruitment_flutter/providers/tipologia_annuncio_provider.dart';
import 'package:solving_recruitment_flutter/screens/annuncio_screens/annuncio_screen.dart';
import 'package:solving_recruitment_flutter/screens/area_screens/area_screen.dart';
import 'package:solving_recruitment_flutter/screens/candidato_screens/candidato_screen.dart';
import 'package:solving_recruitment_flutter/screens/colloquio_screens/colloquio_screen.dart';
import 'package:solving_recruitment_flutter/screens/home.dart';
import 'package:solving_recruitment_flutter/screens/login_screen.dart';
import 'package:solving_recruitment_flutter/screens/selezionatore_screens/selezionatore_screen.dart';
import 'package:solving_recruitment_flutter/screens/tipologia_annuncio_screens/tipologia_annuncio.dart';

final List<Map<String, dynamic>> drawerItems = [
  {
    'icon': Icons.dashboard,
    'title': 'Dashboard',
    'onTap': (context) {
      Navigator.pushNamedAndRemoveUntil(
          context, Home.routeName, (route) => false);
    },
  },
  {
    'divider': true,
    'thickness': 2.0,
  },
  {
    'icon': Icons.group,
    'title': 'Gestione Candidati',
    'onTap': (context) async {
      await Provider.of<CandidatoProvider>(context, listen: false)
          .getCandidati();
      Navigator.pushNamedAndRemoveUntil(
          context, CandidatoScreen.routeName, (route) => false);
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
      await Provider.of<AreaProvider>(context, listen: false).getAreas();
      Navigator.pushNamedAndRemoveUntil(
          context, AreaScreen.routeName, (route) => false);
    },
  },
  {
    'divider': true,
    'thickness': 2.0,
  },
  {
    'icon': Icons.date_range,
    'title': 'Gestione Colloqui',
    'onTap': (context) async {
      await Provider.of<ColloquioProvider>(context, listen: false)
          .getColloqui();
      Navigator.pushNamedAndRemoveUntil(
          context, ColloquioScreen.routeName, (route) => false);
    },
  },
  {
    'divider': true,
    'thickness': 2.0,
  },
  {
    'icon': Icons.person_search,
    'title': 'Gestione Selezionatori',
    'onTap': (context) async {
      await Provider.of<SelezionatoreProvider>(context, listen: false)
          .getSelezionatori();
      Navigator.pushNamedAndRemoveUntil(
          context, SelezionatoreScreen.routeName, (route) => false);
    },
  },
  {
    'divider': true,
    'thickness': 2.0,
  },
  {
    'icon': Icons.announcement,
    'title': 'Gestione Annunci',
    'onTap': (context) async {
      await Provider.of<AnnuncioProvider>(context, listen: false).getAnnunci();
      Navigator.pushNamedAndRemoveUntil(
          context, AnnuncioScreen.routeName, (route) => false);
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
      // Navigator.pushNamed(context, AreaScreen.routeName);
    },
  },
  {
    'divider': true,
    'thickness': 2.0,
  },
  {
    'icon': Icons.work,
    'title': 'Gestione Tipologia Annunci',
    'onTap': (context) async {
      await Provider.of<TipologiaAnnuncioProvider>(context, listen: false)
          .getTipologiaAnnuncio();
      Navigator.pushNamedAndRemoveUntil(
          context, TipologiaAnnuncioScreen.routeName, (route) => false);
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
      Navigator.pushNamedAndRemoveUntil(
          context, LoginScreen.routeName, (route) => false);
    },
  },
];
