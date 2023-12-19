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
  bool filterActive = false;
  AnnuncioFiltro annuncioFiltro = AnnuncioFiltro();

  final AuthProvider? authProvider;

  Future<void> getAnnunci() async {
    String url = '$urlAPI/annuncio/getAllMobile';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authProvider!.token}',
    });
    final jsonData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      filterActive = false;
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
        title: jsonData['error'] ?? 'Errore',
        description: jsonData['trace'] ?? 'Errore sconosciuto',
      );
    }
  }

  Future<Annuncio> getAnnuncio(id) async {
    String url = '$urlAPI/annuncio/get/$id';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authProvider!.token}',
    });
    final jsonData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      filterActive = false;
      return Annuncio.fromJson(jsonData);
    } else {
      throw HttpException(
        statusCode: response.statusCode,
        title: jsonData['error'] ?? 'Errore',
        description: jsonData['trace'] ?? 'Errore sconosciuto',
      );
    }
  }

  Future<void> getAnnunciByIdArea(id) async {
    String url = '$urlAPI/area/getAnnunciByArea/$id';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authProvider!.token}',
    });
    final jsonData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      filterActive = false;
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
        title: jsonData['error'] ?? 'Errore',
        description: jsonData['trace'] ?? 'Errore sconosciuto',
      );
    }
  }

  Future<void> getAnnunciWithSameIdTipolgiaAnnuncio(id) async {
    String url = '$urlAPI/annuncio/getAllWithSameTipologiaMobile/$id';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authProvider!.token}',
    });
    final jsonData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      filterActive = false;
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
        'Authorization': 'Bearer ${authProvider!.token}',
      },
      body: json.encode(annuncio.toJson()),
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      notifyListeners();
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
        'Authorization': 'Bearer ${authProvider!.token}',
      },
      body: json.encode(annuncio.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteAnnuncio(id) async {
    String url = '$urlAPI/annuncio/delete/$id';
    final response = await http.delete(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authProvider!.token}',
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> getAnnunciByFilter(AnnuncioFiltro filtro) async {
    if (filterActive) {
      String url = '$urlAPI/annuncio/searchMobile';
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authProvider!.token}',
        },
        body: json.encode(filtro.toJson()),
      );
      final jsonData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        checkFIlterActive(filtro);
        List<Annuncio> annunci = [];
        for (var item in jsonData['content']) {
          annunci.add(Annuncio.fromJsonGetAllAnnunci(item));
        }
        this.annunci.clear();
        this.annunci.addAll(annunci);
        notifyListeners();
      } else {
        throw HttpException(
          statusCode: response.statusCode,
          title: jsonData['error'] ?? 'Errore',
          description: jsonData['trace'] ?? 'Errore sconosciuto',
        );
      }
    }
  }

  void checkFIlterActive(AnnuncioFiltro filtro) {
    annuncioFiltro = filtro;
    filterActive = filtro.titolo != null && filtro.titolo!.trim().isNotEmpty ||
        filtro.dataInizio != null ||
        filtro.tipologiaAnnuncio != null ||
        filtro.area != null;
    notifyListeners();
  }

  Future<StatsAnnuncio> getStatsAnnuncio() async {
    String url = '$urlAPI/annuncio/statsAnnuncioPerArea';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authProvider!.token}',
    });
    final jsonData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return StatsAnnuncio.fromJson(jsonData);
    } else {
      throw HttpException(
        statusCode: response.statusCode,
        title: jsonData['title'],
        description: jsonData['description'],
      );
    }
  }
}
