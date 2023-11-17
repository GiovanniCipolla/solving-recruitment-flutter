import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/models/annuncio.dart';
import 'package:solving_recruitment_flutter/models/area.dart';
import 'package:solving_recruitment_flutter/models/candidato.dart';
import 'package:solving_recruitment_flutter/models/httpexception.dart';
import 'package:solving_recruitment_flutter/providers/auth_provider.dart';
import 'package:http/http.dart' as http;

class AnnuncioProvider extends ChangeNotifier {
  AnnuncioProvider(
      {required this.authProvider,
      required this.annunci,
      required this.candidati,
      required this.area});

  List<Annuncio> annunci = [];
  List<Candidato> candidati = [];
  Area? area;

  final AuthProvider? authProvider;

  Future<void> getAnnunci() async {
    String url = '$urlAPI/annuncio/getAllMobile';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });
    final jsonData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      List<Annuncio> annunci = [];
      for (var item in jsonData) {
        annunci.add(Annuncio.fromJsonGetAllAnnunci(item));
      }
      this.annunci.clear();
      this.annunci.addAll(annunci);
      notifyListeners();
    } else {
      throw HttpException(
        statusCode: response.statusCode,
        title: jsonData['title'],
        description: jsonData['description'],
      );
    }
  }

  Future<Annuncio> getAnnuncio(id) async {
    String url = '$urlAPI/annuncio/get/$id';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });
    final jsonData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Annuncio.fromJson(jsonData);
    } else {
      throw HttpException(
        statusCode: response.statusCode,
        title: jsonData['title'],
        description: jsonData['description'],
      );
    }
  }

  Future<void> getAnnunciByIdArea(id) async {
    String url = '$urlAPI/area/getAnnunciByArea/$id';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });
    final jsonData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      List<Annuncio> annunci = [];
      for (var item in jsonData) {
        annunci.add(Annuncio.fromJsonGetAllAnnunci(item));
      }
      this.annunci.clear();
      this.annunci.addAll(annunci);

      notifyListeners();
    } else {
      throw HttpException(
        statusCode: response.statusCode,
        title: jsonData['title'],
        description: jsonData['description'],
      );
    }
  }

  Future<void> getAnnunciWithSameIdTipolgiaAnnuncio(id) async {
    String url = '$urlAPI/annuncio/getAllWithSameTipologiaMobile/$id';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });
    final jsonData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      List<Annuncio> annunci = [];
      for (var item in jsonData) {
        annunci.add(Annuncio.fromJsonGetAllAnnunci(item));
      }
      this.annunci.clear();
      this.annunci.addAll(annunci);
    }
  }

  Future<bool> createAnnuncio(annuncio) async {
    String url = '$urlAPI/annuncio';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(annuncio.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateAnnuncio(annuncio) async {
    String url = '$urlAPI/annuncio/update/${annuncio.id}';
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(annuncio.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
