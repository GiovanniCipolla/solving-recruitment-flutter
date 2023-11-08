import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/models/colloquio.dart';
import 'package:solving_recruitment_flutter/models/httpexception.dart';
import 'package:solving_recruitment_flutter/providers/auth_provider.dart';
import 'package:http/http.dart' as http;


class ColloquioProvider extends ChangeNotifier{
  final AuthProvider? authProvider;
  List<Colloquio> colloqui = [];
  ColloquioProvider({required this.authProvider, required this.colloqui});

  Future<void> getColloqui() async {
    String url = '$urlAPI/colloquio/get';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });
    final jsonData = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      List<Colloquio> colloqui = [];
      for (var item in jsonData) {
        colloqui.add(Colloquio.fromJson(item));
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
}