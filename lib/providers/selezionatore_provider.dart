import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/models/httpexception.dart';
import 'package:solving_recruitment_flutter/models/selezionatore.dart';
import 'package:solving_recruitment_flutter/providers/auth_provider.dart';
import 'package:http/http.dart' as http;

class SelezionatoreProvider extends ChangeNotifier {
  final AuthProvider? authProvider;
  List<Selezionatore> selezionatori = [];

  SelezionatoreProvider(
      {required this.authProvider, required this.selezionatori});

  Future<void> getSelezionatori() async {
    String url = '$urlAPI/selezionatore/get';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });
    final jsonData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      List<Selezionatore> selezionatori = [];
      for (var item in jsonData) {
        selezionatori.add(Selezionatore.fromJson(item));
      }
      this.selezionatori.clear();
      this.selezionatori.addAll(selezionatori);
      notifyListeners();
    } else {
      throw HttpException(
        statusCode: response.statusCode,
        title: jsonData['title'],
        description: jsonData['description'],
      );
    }
  }

  Future<bool> createSelezionatore(selezionatore) async {
    String url = '$urlAPI/selezionatore';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(selezionatore.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateSelezionatore(selezionatore) async {
    String url = '$urlAPI/selezionatore/update/${selezionatore.id}';
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(selezionatore.toJson()),
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
