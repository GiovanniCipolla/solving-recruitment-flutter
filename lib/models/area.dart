
class Area {

Area({ this.id, required this.denominazione});

  final String? id;
  final String denominazione;
  // annunci
  // candidati

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      id: json['id'],
      denominazione: json['denominazione'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'denominazione': denominazione,
    };
  }
}