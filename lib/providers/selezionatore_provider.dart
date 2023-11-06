import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/models/selezionatore.dart';
import 'package:solving_recruitment_flutter/providers/auth_provider.dart';

class SelezionatoreProvider extends ChangeNotifier{
final AuthProvider? authProvider;
List<Selezionatore> selezionatori = [];

SelezionatoreProvider({required this.authProvider, required this.selezionatori});
}