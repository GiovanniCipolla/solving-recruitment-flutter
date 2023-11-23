import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/models/annuncio.dart';
import 'package:solving_recruitment_flutter/models/area.dart';
import 'package:solving_recruitment_flutter/models/candidato.dart';
import 'package:solving_recruitment_flutter/models/httpexception.dart';
import 'package:solving_recruitment_flutter/providers/auth_provider.dart';
import 'package:http/http.dart' as http;

class AreaProvider extends ChangeNotifier {
  AreaProvider({
    required this.authProvider,
    required this.aree,
    required this.candidati,
    required this.annunci,
  });

  List<Area> aree = [];
  final AuthProvider? authProvider;
  List<Candidato> candidati = [];
  List<Annuncio> annunci = [];

  Future<void> getAreas() async {
    String url = '$urlAPI/area/getMobile';
    final response = await http.get(Uri.parse(url), headers: {
'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authProvider!.token}',      
    });
    final jsonData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      List<Area> areaa = [];
      for (var item in jsonData) {
        areaa.add(Area.fromJsonGetAll(item));
      }
      aree.clear();
      aree.addAll(areaa);
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
