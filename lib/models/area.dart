
class Area {

Area({ this.id, required this.denominazione,  this.annunciLenght});

  final String? id;
  final String denominazione;
  final int? annunciLenght;
 

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