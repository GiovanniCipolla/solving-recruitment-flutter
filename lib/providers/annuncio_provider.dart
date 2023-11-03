import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/models/annuncio.dart';
import 'package:solving_recruitment_flutter/models/httpexception.dart';
import 'package:solving_recruitment_flutter/providers/auth_provider.dart';
import 'package:http/http.dart' as http;

class AnnuncioProvider extends ChangeNotifier {
  AnnuncioProvider({required this.authProvider, required this.annunci});
  List<Annuncio> annunci = [];
  final AuthProvider? authProvider;

  // // Future<void> getAnnunci() async {
  // //   String url = '$urlAPI/annuncio/get';
  // //   final response = await http.get(Uri.parse(url), headers: {
  // //     'Content-Type': 'application/json',
  // //   });
  // //   print(response.body);
  // //    print(response.statusCode);
  // //   final jsonData = json.decode(response.body);
  // //   if (response.statusCode == 200) {
  // //     List<Annuncio> annunci = [];
  // //     for (var item in jsonData) {
  // //       annunci.add(Annuncio.fromJson(item));
  // //     }
  // //     this.annunci.clear();
  // //     this.annunci.addAll(annunci);
  // //     notifyListeners();
  // //   } else {
  // //     throw HttpException(
  // //       statusCode: response.statusCode,
  // //       title: jsonData['title'],
  // //       description: jsonData['description'],
  // //     );
  // //   }
  // }
}
