import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/models/academy.dart';
import 'package:solving_recruitment_flutter/models/httpexception.dart';
import 'package:solving_recruitment_flutter/providers/auth_provider.dart';
import 'package:http/http.dart' as http;

class AcademyProvider extends ChangeNotifier {
  List<Academy> academies = [];
  final AuthProvider? authProvider;
    bool filterActive = false;
  AcademyFiltro academyFiltro = AcademyFiltro();

  AcademyProvider({required this.academies, required this.authProvider});

  Future<void> getAcademies() async {
    String url = '$urlAPI/academy';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authProvider!.token}',
    });
    final jsonData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      List<Academy> academies = [];
      for (var item in jsonData) {
        academies.add(Academy.fromJson(item));
      }
      this.academies.clear();
      this.academies.addAll(academies);
      notifyListeners();
    }
  }

  Future<Academy> getAcademyById(id) async {
    String url = '$urlAPI/academy/$id';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authProvider!.token}',
    });
    final jsonData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Academy.fromJson(jsonData);
    } else {
      throw HttpException(
        statusCode: response.statusCode,
        title: jsonData['error'] ?? 'Errore',
        description: jsonData['trace'] ?? 'Errore sconosciuto',
      );
    }
  }

  Future<bool> createAcademy(academy) async {
    String url = '$urlAPI/academy';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authProvider!.token}',
      },
      body: json.encode(academy.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
    ;
  }

  Future<bool> updateAcademy(academy) async {
    String url = '$urlAPI/academy/${academy.id}';
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authProvider!.token}',
      },
      body: json.encode(academy.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
    ;
  }

  Future<bool> deleteAcademy(id) async {
    String url = '$urlAPI/academy/$id';
    final response = await http.delete(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authProvider!.token}',
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
    ;
  }
}
