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

  CandidatoProvider({required this.authProvider, required this.candidati});

  Future<void> getCandidati() async {
    String url = '$urlAPI/candidato/getMobile';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
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

  Future<void> getCandidatiWithSameArea(id) async {
    String url = '$urlAPI/candidato/getAllCandidatiByIdArea/$id';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
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

  Future<Candidato> getCandidato(id) async {
    String url = '$urlAPI/candidato/get/$id';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
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

  Future<void> getCandidatiByIdAnnuncio(id) async {
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

  Future<void> getCandidatoWithFilter(filter) async {
    String url = '$urlAPI/candidato/filtrata/$filter';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
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
      if (filtro != null) {
        String url = '$urlAPI/candidato/filtrataMobile?filtro=$filtro';
        final response = await http.get(Uri.parse(url), headers: {
          'Content-Type': 'application/json',
        });

        print('URL della richiesta: $url');
        print('Codice di risposta: ${response.statusCode}');
        print('Body della risposta: ${response.body}');

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
      }
    } catch (error) {
      print('Errore durante la chiamata: $error');
      // Tratta l'errore come desiderato
    }
  }

  Future<void> getCandidatisearchAndPagination(filtro) async {
    String url = '$urlAPI/search';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
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
    print('SONO ENTRATO ');
    String url = '$urlAPI/candidato';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(candidato.toJson()),
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
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
      },
      body: json.encode(candidato.toJson()),
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
Future<bool> deleteCandidato(id) async {
  String url = '$urlAPI/candidato/delete/$id';
  final response = await http.delete(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
  });
  if (response.statusCode == 200 || response.statusCode == 201) {
    return true;
  } else {
    return false;
  }

}
}

