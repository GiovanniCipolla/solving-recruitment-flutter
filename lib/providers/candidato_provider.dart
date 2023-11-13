import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/models/candidato.dart';
import 'package:solving_recruitment_flutter/models/colloquio.dart';
import 'package:solving_recruitment_flutter/models/httpexception.dart';
import 'package:solving_recruitment_flutter/providers/auth_provider.dart';
import 'package:http/http.dart' as http;

class CandidatoProvider extends ChangeNotifier {
  List<Candidato> candidati = [];
  final AuthProvider? authProvider;
  List<Colloquio> colloqui = [];

  CandidatoProvider({required this.authProvider, required this.candidati});

  Future<void> getCandidati() async {
    String url = '$urlAPI/candidato/get';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });
    final jsonData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      List<Candidato> candidati = [];
      for (var item in jsonData) {
        candidati.add(Candidato.fromJson(item));
      }
      this.candidati.clear();
      this.candidati.addAll(candidati);
      notifyListeners();
    } else {
      throw HttpException(
        statusCode: jsonData['statusCode'],
        title: jsonData['title'],
        description: jsonData['description'],
      );
    }
  }

  Future<void> getCandidatiByIdArea(id) async {
    String url = '$urlAPI/candidato/candidatiPerArea/$id';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });
    final jsonData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('aaaaaa');
      List<Candidato> candidati = [];
      for (var item in jsonData) {
        candidati.add(Candidato.fromJson(item));
      }
      this.candidati.clear();
      this.candidati.addAll(candidati);
      notifyListeners();
    } else {
      throw HttpException(
        statusCode: jsonData['statusCode'],
        title: jsonData['title'],
        description: jsonData['description'],
      );
    }
  }

  Future<void> getCandidatiByIdAnnuncio (id) async {
    String url = '$urlAPI/candidato/candidatiPerAnnuncio/$id';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });
    final jsonData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      List<Candidato> candidati = [];
      for (var item in jsonData) {
        candidati.add(Candidato.fromJson(item));
      }
      this.candidati.clear();
      this.candidati.addAll(candidati);
      notifyListeners();
    } else {
      throw HttpException(
        statusCode: jsonData['statusCode'],
        title: jsonData['title'],
        description: jsonData['description'],
      );
    }
  }
}
