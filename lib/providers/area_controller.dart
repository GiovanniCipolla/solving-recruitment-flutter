import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/models/annuncio.dart';
import 'package:solving_recruitment_flutter/models/area.dart';
import 'package:solving_recruitment_flutter/models/candidato.dart';
import 'package:solving_recruitment_flutter/providers/auth_provider.dart';

class AreaProvider extends ChangeNotifier {

  AreaProvider({required this.authProvider, required this.areaa, required this.candidati, required this.annunci});

  List<Area> areaa = [];
  final AuthProvider? authProvider;
  List<Candidato> candidati = [];
  List<Annuncio> annunci = [];

  //metodo findbyid restituirà area

}