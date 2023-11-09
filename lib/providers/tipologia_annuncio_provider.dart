import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/models/httpexception.dart';
import 'package:solving_recruitment_flutter/models/tipologia_annuncio.dart';
import 'package:solving_recruitment_flutter/providers/auth_provider.dart';
import 'package:http/http.dart' as http;

class TipologiaAnnuncioProvider extends ChangeNotifier {
  List<TipologiaAnnuncio> tipologiaAnnuncio = [];
  final AuthProvider? authProvider;

  TipologiaAnnuncioProvider(
      {required this.authProvider, required this.tipologiaAnnuncio});

  Future<void> getTipologiaAnnuncio() async {
    String url = '$urlAPI/tipologiaAnnuncio/getMobile';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });
    final jsonData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      List<TipologiaAnnuncio> tipologiaAnnuncio = [];
      for (var item in jsonData) {
        tipologiaAnnuncio.add(TipologiaAnnuncio.fromJson(item));
      }
      this.tipologiaAnnuncio.clear();
      this.tipologiaAnnuncio.addAll(tipologiaAnnuncio);
      notifyListeners();
    } else {
      throw HttpException(
        statusCode: response.statusCode,
        title: jsonData['title'],
        description: jsonData['description'],
      );
    }
  }
}
