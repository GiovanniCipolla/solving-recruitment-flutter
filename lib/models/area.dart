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
}
