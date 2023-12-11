import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/models/academy.dart';

class AcademyProvider extends ChangeNotifier {
  List<Academy> academies = [];
  AcademyProvider({required this.academies});
}