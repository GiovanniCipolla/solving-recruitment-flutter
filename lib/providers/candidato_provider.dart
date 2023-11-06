import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/models/candidato.dart';
import 'package:solving_recruitment_flutter/providers/auth_provider.dart';

class CandidatoProvider extends ChangeNotifier {
  List<Candidato> candidati = [];
  final AuthProvider? authProvider;

  CandidatoProvider({required this.authProvider, required this.candidati});
}