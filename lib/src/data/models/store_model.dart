class StoreModel {
  StoreModel({
    required this.name,
    required this.slogan,
    required this.id,
    required this.banner,
  });

  final int id;
  final String name;
  final String slogan;
  final String banner;

  Map<String, dynamic> toMap() => {
    'name': name,
    'slogan': slogan,
    'banner': banner,
  };

  factory StoreModel.fromMap(Map<String, dynamic> map) {
    return StoreModel(
      id: (map['id'] ?? map['idModel']) ?? 0,
      name: map['name'] ?? '',
      slogan: map['slogan'] ?? '',
      banner: map['banner'],
    );
  }

  StoreModel copyWith({int? id, String? name, String? slogan, String? banner}) {
    return StoreModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slogan: slogan ?? this.slogan,
      banner: banner ?? this.banner,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StoreModel &&
        other.id == id &&
        other.name == name &&
        other.slogan == slogan &&
        other.banner == banner;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ slogan.hashCode ^ banner.hashCode;
  }
}
