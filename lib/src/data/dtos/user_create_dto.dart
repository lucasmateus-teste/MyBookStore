import 'dart:convert';

class UserCreateDto {
  UserCreateDto({
    required this.name,
    required this.username,
    required this.password,
    required this.base64Photo,
  });

  final String name;
  final String username;
  final String password;
  final String base64Photo;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'password': password,
      // 'photo': base64Photo,
      'photo': '',
    };
  }

  String toJson() => json.encode(toMap());

  factory UserCreateDto.fromMap(Map<String, dynamic> map) {
    return UserCreateDto(
      name: map['name'] ?? '',
      username: map['username'] ?? '',
      password: map['password'] ?? '',
      base64Photo: map['base64Photo'] ?? '',
    );
  }

  factory UserCreateDto.fromJson(String source) =>
      UserCreateDto.fromMap(json.decode(source));
}
