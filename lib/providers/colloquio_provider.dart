import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/models/colloquio.dart';
import 'package:solving_recruitment_flutter/models/httpexception.dart';
import 'package:solving_recruitment_flutter/providers/auth_provider.dart';
import 'package:http/http.dart' as http;

class ColloquioProvider extends ChangeNotifier {
  final AuthProvider? authProvider;
  List<Colloquio> colloqui = [];
  ColloquioProvider({required this.authProvider, required this.colloqui});
  bool filterActive = false;
  ColloquioFiltro colloquioFiltro = ColloquioFiltro();

  Future<void> getColloqui() async {
    String url = '$urlAPI/colloquio/getMobile';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authProvider!.token}',
    });
    final jsonData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      filterActive = false;
      List<Colloquio> colloqui = [];
      for (var item in jsonData) {
        colloqui.add(Colloquio.fromJsonGetAllColloqui(item));
      }
      this.colloqui.clear();
      this.colloqui.addAll(colloqui);
      notifyListeners();
    } else {
      throw HttpException(
        statusCode: response.statusCode,
        title: jsonData['title'],
        description: jsonData['description'],
      );
    }
  }

  Future<Colloquio> getColloquioById(id) async {
    String url = '$urlAPI/colloquio/getMobile/$id';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authProvider!.token}',
    });
    final jsonData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      filterActive = false;
      return Colloquio.fromJsonGetAllColloqui(jsonData);
    } else {
      throw HttpException(
        statusCode: response.statusCode,
        title: jsonData['title'],
        description: jsonData['description'],
      );
    }
  }

  Future<void> getColloquioByCandidatoByTipologia(id, tipologia) async {
    String url =
        '$urlAPI/colloquio/colloquioWithNomeCognome/$id/tipologia/$tipologia';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authProvider!.token}',
    });
    final jsonData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      filterActive = false;
      List<Colloquio> colloqui = [];
      for (var item in jsonData) {
        colloqui.add(Colloquio.fromJsonGetAllColloqui(item));
      }
      this.colloqui.clear();
      this.colloqui.addAll(colloqui);
      notifyListeners();
    } else {
      throw HttpException(
        statusCode: response.statusCode,
        title: jsonData['title'],
        description: jsonData['description'],
      );
    }
  }

  Future<void> getColloquiBySelezionatore(id) async {
    String url = '$urlAPI/colloquio/colloquioBySelezionatore/$id';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authProvider!.token}',
    });
    final jsonData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      filterActive = false;
      List<Colloquio> colloqui = [];
      for (var item in jsonData) {
        colloqui.add(Colloquio.fromJsonGetAllColloqui(item));
      }
      this.colloqui.clear();
      this.colloqui.addAll(colloqui);
      notifyListeners();
    } else {
      throw HttpException(
        statusCode: response.statusCode,
        title: jsonData['title'],
        description: jsonData['description'],
      );
    }
  }

  Future<bool> createColloquio(colloquio) async {
    String url = '$urlAPI/colloquio';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authProvider!.token}',
      },
      body: json.encode(colloquio.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateColloquio(colloquio) async {
    String url = '$urlAPI/colloquio/update/${colloquio.id}';
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authProvider!.token}',
      },
      body: json.encode(colloquio.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<void> getCandidatiByFilter(ColloquioFiltro filtro) async {
    if (filterActive) {
      String url = '$urlAPI/colloquio/searchMobile';
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
        checkFilterActive(filtro);
        List<Colloquio> colloqui = [];
        for (var item in jsonData['content']) {
          colloqui.add(Colloquio.fromJsonGetAllColloqui(item));
        }
        this.colloqui.clear();
        this.colloqui.addAll(colloqui);
        notifyListeners();
      } else {
        throw HttpException(
          statusCode: jsonData['statusCode'],
          title: jsonData['title'],
          description: jsonData['description'],
        );
      }
    } else {
      getColloqui();
    }
  }

  void checkFilterActive(ColloquioFiltro filtro) {
    colloquioFiltro = filtro;
    filterActive = filtro.candidato != null ||
        filtro.selezionatore != null ||
        filtro.tipologia != null ||
        filtro.feedback != null;
    notifyListeners();
  }
}
