class Area {
  Area({this.id, this.denominazione, this.countAnnunci});

  final int? id;
  final String? denominazione;
  final int? countAnnunci;

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      id: json['id'] != null ? json['id'] as int : null,
      denominazione:
          json['denominazione'] != null ? json['denominazione'] as String : "",
    );
  }
  factory Area.fromJsonGetAll(Map<String, dynamic> json) {
    return Area(
      id: json['id'] != null ? json['id'] as int : null,
      denominazione:
          json['denominazione'] != null ? json['denominazione'] as String : "",
      countAnnunci:
          json['countAnnunci'] != null ? json['countAnnunci'] as int : 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'denominazione': denominazione,
      'countAnnunci': countAnnunci
    };
  }

  Map<String, dynamic> toJsonForFilterCandidato() {
    return {
      'id': id,
      'denominazione': denominazione,
    };
  }
}

class StatsArea {
  StatsArea(
      {this.candidatiStaffTecnico,
      this.candidatiStaffInterno,
      this.candidatoAltro});

  final int? candidatiStaffTecnico;
  final int? candidatiStaffInterno;
  final int? candidatoAltro;

  factory StatsArea.fromJson(Map<String, dynamic> json) {
    return StatsArea(
      candidatiStaffTecnico: json['candidatiStaffTecnico'] != null
          ? json['candidatiStaffTecnico'] as int
          : null,
      candidatiStaffInterno: json['candidatiStaffInterno'] != null
          ? json['candidatiStaffInterno'] as int
          : null,
      candidatoAltro:
          json['candidatoAltro'] != null ? json['candidatoAltro'] as int : null,
    );
  }
}
