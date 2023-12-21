import 'dart:core';

class Academy {
  Academy(
      {this.id,
      this.denominazione,
      this.dataInizio,
      this.dataFine,
      this.attiva,
      this.insegnante});

  final int? id;
  final String? denominazione;
  final DateTime? dataInizio;
  final DateTime? dataFine;
  final bool? attiva;
  final String? insegnante;

  factory Academy.fromJson(Map<String, dynamic> json) {
    return Academy(
      id: json['id'] != null ? json['id'] as int : null,
      denominazione: json['denominazione'] != null
          ? json['denominazione'] as String
          : null,
      dataInizio: json['dataInizio'] != null
          ? DateTime.parse(json['dataInizio'])
          : null,
      dataFine:
          json['dataFine'] != null ? DateTime.parse(json['dataFine']) : null,
      attiva: json['attiva'] != null ? json['attiva'] as bool : null,
      insegnante:
          json['insegnante'] != null ? json['insegnante'] as String : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'denominazione': denominazione,
      'dataInizio': dataInizio != null ? dataInizio!.toIso8601String() : null,
      'dataFine': dataFine != null ? dataFine!.toIso8601String() : null,
      'attiva': attiva,
      'insegnante': insegnante
    };
  }
}

class AcademyFiltro {
  String? denominazione;
  DateTime? dataInizio;
  DateTime? dataFine;
  bool? attiva;
  String? insegnante;
  int? pageNo;
  int? pageSize;
  String? sortBy;
  String? sortDirection;

  AcademyFiltro(
      {this.denominazione,
      this.dataInizio,
      this.dataFine,
      this.attiva,
      this.insegnante,
      this.pageNo,
      this.pageSize,
      this.sortBy,
      this.sortDirection});

  Map<String, dynamic> toJson() {
    return {
      'denominazione': denominazione,
      'dataInizio': dataInizio != null ? dataInizio!.toIso8601String() : null,
      'dataFine': dataFine != null ? dataFine!.toIso8601String() : null,
      'attiva': attiva,
      'insegnante': insegnante,
      'pageNo': pageNo,
      'pageSize': pageSize,
      'sortBy': sortBy,
      'sortDirection': sortDirection
    };
  }
}
