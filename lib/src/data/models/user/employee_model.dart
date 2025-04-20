import 'package:my_book_store/src/data/models/user/user_model.dart';

class EmployeeModel extends UserModel {
  EmployeeModel({
    required super.id,
    required super.name,
    required super.username,
    this.password,
  }) : super(type: UserType.employe);

  final String? password;

  factory EmployeeModel.fromMap(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'] as int,
      name: json['name'] as String,
      username: json['username'] as String?,
      password: json['password'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'password': password,
      'photo': '',
    };
  }

  EmployeeModel copyWith({
    int? id,
    String? name,
    String? username,
    String? password,
  }) {
    return EmployeeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EmployeeModel && other.password == password;
  }

  @override
  int get hashCode => password.hashCode;
}
