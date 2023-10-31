import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/providers/annuncio_provider.dart';
import 'package:solving_recruitment_flutter/screens/annuncio_screen.dart';

final List<Map<String, dynamic>> drawerItems = [
  {
    'icon': Icons.dashboard,
    'title': 'Dashboard',
    'onTap': () {},
  },
  {
    'divider': true,
    'thickness': 2.0,
  },
  {
    'icon': Icons.group,
    'title': 'Gestione Candidati',
    'onTap': () {},
  },
  {
    'divider': true,
    'thickness': 2.0,
  },
  {
    'icon': Icons.category,
    'title': 'Gestione Aree',
    'onTap': () {},
  },
  {
    'divider': true,
    'thickness': 2.0,
  },
  {
    'icon': Icons.date_range,
    'title': 'Gestione Colloqui',
    'onTap': () {},
  },
  {
    'divider': true,
    'thickness': 2.0,
  },
  {
    'icon': Icons.person_search,
    'title': 'Gestione Selezionatori',
    'onTap': (context) { Provider.of<AnnuncioProvider>(context, listen: false).getAnnunci();
    Navigator.push(context, MaterialPageRoute(builder: (context) => const AnnuncioScreen()));
    },
  },
  {
    'divider': true,
    'thickness': 2.0,
  },
  {
    'icon': Icons.announcement,
    'title': 'Gestione Annunci',
     'onTap': (context) { Provider.of<AnnuncioProvider>(context, listen: false).getAnnunci();
    Navigator.push(context, MaterialPageRoute(builder: (context) => const AnnuncioScreen()));
    },
  },
  {
    'divider': true,
    'thickness': 2.0,
  },
  {
    'icon': Icons.school,
    'title': 'Gestione Academy',
    'onTap': () {},
  },
  {
    'divider': true,
    'thickness': 2.0,
  },
  {
    'icon': Icons.logout,
    'title': 'Logout',
    'onTap': () {},
  },
];
