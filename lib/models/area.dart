class Area {
  Area({this.id, this.denominazione, this.countAnnunci});

  final int? id;
  final String? denominazione;
  final int? countAnnunci;

  factory Area.fromJson(Map<String, dynamic> json) {
    Area area = Area(
      id: json['id'] as int,
      denominazione: json['denominazione'] as String,
      countAnnunci: json['countAnnunci'] as int,
    );
    return area;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'denominazione': denominazione,
      'countAnnunci': countAnnunci
    };
  }
}
