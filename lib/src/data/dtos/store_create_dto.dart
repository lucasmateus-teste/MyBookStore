import 'dart:convert';

import 'package:my_book_store/src/data/dtos/user_create_dto.dart';

class StoreCreateDto {
  StoreCreateDto({
    required this.name,
    required this.slogan,
    required this.base64Banner,
    required this.admin,
  });

  final String name;
  final String slogan;
  final String base64Banner;
  final UserCreateDto admin;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'slogan': slogan,
      'banner': base64Banner,
      // 'banner': '',
      'admin': admin.toMap(),
    };
  }

  factory StoreCreateDto.fromMap(Map<String, dynamic> map) {
    return StoreCreateDto(
      name: map['name'] ?? '',
      slogan: map['slogan'] ?? '',
      base64Banner: map['base64Banner'] ?? '',
      admin: UserCreateDto.fromMap(map['admin']),
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreCreateDto.fromJson(String source) =>
      StoreCreateDto.fromMap(json.decode(source));
}
