import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/models/candidato.dart';
import 'package:solving_recruitment_flutter/models/colloquio.dart';
import 'package:solving_recruitment_flutter/models/httpexception.dart';
import 'package:solving_recruitment_flutter/providers/auth_provider.dart';
import 'package:http/http.dart' as http;

class CandidatoProvider extends ChangeNotifier {
  final AuthProvider? authProvider;
  List<Candidato> candidati = [];
  List<Colloquio> colloqui = [];
  bool filterActive = false;
  CandidatoFiltro candidatoFiltro = CandidatoFiltro();

  CandidatoProvider({required this.authProvider, required this.candidati});

  Future<void> getCandidati() async {
    String url = '$urlAPI/candidato/getMobile';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authProvider!.token}',
    });
    final jsonData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      filterActive = false;
      List<Candidato> candidati = [];
      for (var item in jsonData) {
        candidati.add(Candidato.fromJsonGetAllCandidato(item));
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

  Future<void> getCandidatiWithSameArea(id) async {
    String url = '$urlAPI/candidato/getAllCandidatiByIdArea/$id';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authProvider!.token}',
    });
    final jsonData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      filterActive = false;

      List<Candidato> candidati = [];
      for (var item in jsonData) {
        candidati.add(Candidato.fromJsonGetAllCandidato(item));
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

  Future<Candidato> getCandidato(id) async {
    String url = '$urlAPI/candidato/get/$id';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authProvider!.token}',
    });
    final jsonData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Candidato.fromJson(jsonData);
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
      'Authorization': 'Bearer ${authProvider!.token}',
    });
    final jsonData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      filterActive = false;

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

  Future<void> getCandidatiByIdAnnuncio(id) async {
    String url = '$urlAPI/candidato/candidatiPerAnnuncio/$id';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authProvider!.token}',
    });
    final jsonData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      filterActive = false;

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

  Future<void> getCandidatoWithFilter(filter) async {
    String url = '$urlAPI/candidato/filtrata/$filter';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authProvider!.token}',
    });
    final jsonData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      List<Candidato> candidati = [];
      for (var item in jsonData) {
        candidati.add(Candidato.fromJsonGetAllCandidato(item));
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

  Future<void> getCandidatiFiltratiAutoComplete(String filtro) async {
    try {
      String url = '$urlAPI/candidato/filtrataMobile?filtro=$filtro';
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authProvider!.token}',
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<Candidato> candidati = [];
        final jsonData = json.decode(response.body);

        for (var item in jsonData) {
          candidati.add(Candidato.fromJsonGetAllCandidato(item));
        }
        this.candidati.clear();
        this.candidati.addAll(candidati);
        notifyListeners();
      } else {
        throw HttpException(
          statusCode: response.statusCode,
          title: 'Errore di rete',
          description: 'Errore durante la chiamata al server',
        );
      }
    } catch (error) {
      // Tratta l'errore come desiderato
    }
  }

  Future<void> getCandidatisearchAndPagination(filtro) async {
    String url = '$urlAPI/search';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authProvider!.token}',
      },
      body: json.encode(filtro.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<Candidato> candidati = [];
      var decodedResponse = json.decode(response.body);
      if (decodedResponse is List) {
        for (var item in decodedResponse) {
          if (item is Map<String, dynamic>) {
            candidati.add(Candidato.fromJsonGetAllCandidato(item));
          }
        }
      }

      this.candidati.clear();
      this.candidati.addAll(candidati);
      notifyListeners();
    } else {
      throw HttpException(
        statusCode: json.decode(response.body)['statusCode'],
        title: json.decode(response.body)['title'],
        description: json.decode(response.body)['description'],
      );
    }
  }

  Future<bool> createCandidato(candidato) async {
    String url = '$urlAPI/candidato';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authProvider!.token}',
      },
      body: json.encode(candidato.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateCandidato(Candidato candidato) async {
    String url = '$urlAPI/candidato/update/${candidato.id}';
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authProvider!.token}',
      },
      body: json.encode(candidato.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteCandidato(id) async {
    String url = '$urlAPI/candidato/delete/$id';
    final response = await http.delete(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authProvider!.token}',
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<void> getCandidatiByFilter(CandidatoFiltro filtro) async {
    if (filterActive) {
      String url = '$urlAPI/candidato/searchMobile';
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
        List<Candidato> candidati = [];
        for (var item in jsonData['content']) {
          candidati.add(Candidato.fromJsonGetAllCandidato(item));
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
    } else {
      getCandidati();
    }
  }

  void checkFilterActive(CandidatoFiltro filtro) {
    candidatoFiltro = filtro;
    filterActive = (filtro.nome != null && filtro.nome!.trim().isNotEmpty) ||
        (filtro.cognome != null && filtro.cognome!.trim().isNotEmpty) ||
        filtro.stato != null ||
        filtro.dataNascita != null ||
        (filtro.email != null && filtro.email!.trim().isNotEmpty) ||
        filtro.etaMin != null ||
        filtro.etaMax != null ||
        (filtro.recapitoTelefonico != null &&
            filtro.recapitoTelefonico!.trim().isNotEmpty) ||
        filtro.dataPrimoContatto != null ||
        filtro.area != null ||
        filtro.annuncio != null;
    notifyListeners();
  }

//    void getCV(int candidatoId) async {
//   String url = '$urlAPI/candidato/downloadFile/$candidatoId';
//   final response = await http.get(Uri.parse(url), headers: {
//     'Content-Type': 'application/json',
//     'Authorization': 'Bearer ${authProvider!.token}',

//   });
//   final jsonData = json.decode(response.body);
//   print(jsonData);
//   if (response.statusCode == 200 || response.statusCode == 201) {
//    try {
//     await launch(url);
//   } catch (e) {
//     print('Errore durante il lancio del CV: $e'); // Debug
//     throw 'Impossibile aprire il CV';
//   }
//   } else {
//     throw HttpException(
//       statusCode: jsonData['statusCode'],
//       title: jsonData['title'],
//       description: jsonData['description'],
//     );
//   }

// }
}
