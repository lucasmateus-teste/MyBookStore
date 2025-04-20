import 'dart:convert';

class CredentialsModel {
  const CredentialsModel({required this.user, required this.password});

  final String user;
  final String password;

  Map<String, dynamic> toMap() {
    return {'user': user, 'password': password};
  }

  factory CredentialsModel.fromMap(Map<String, dynamic> map) {
    return CredentialsModel(
      user: map['user'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CredentialsModel.fromJson(String source) =>
      CredentialsModel.fromMap(json.decode(source));
}
