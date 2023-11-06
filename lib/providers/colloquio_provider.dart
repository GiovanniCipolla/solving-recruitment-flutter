import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/models/colloquio.dart';
import 'package:solving_recruitment_flutter/providers/auth_provider.dart';

class ColloquioProvider extends ChangeNotifier{
  final AuthProvider? authProvider;
  List<Colloquio> colloqui = [];
  ColloquioProvider({required this.authProvider, required this.colloqui});
}