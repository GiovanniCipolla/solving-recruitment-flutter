import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/models/tipologia_annuncio.dart';
import 'package:solving_recruitment_flutter/providers/auth_provider.dart';

class TipologiaAnnuncioProvider extends ChangeNotifier {
  List<TipologiaAnnuncio> tipologiaAnnuncio = [];
  final AuthProvider? authProvider;

  TipologiaAnnuncioProvider({required this.authProvider, required this.tipologiaAnnuncio});
}