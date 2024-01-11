class KarpimModel {
  int? id;
  final String name;
  final String position;

  KarpimModel({
    required this.id,
    required this.name,
    required this.position,
  });

  factory KarpimModel.fromMap(Map<String, dynamic> map) {
    return KarpimModel(
      id: map['id'],
      name: map['name'],
      position: map['position'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'position': position,
    };
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'position': position,
      };

  factory KarpimModel.fromJson(Map<String, dynamic> json) {
    return KarpimModel(
      id: json['id'],
      name: json['name'],
      position: json['position'],
    );
  }
}
