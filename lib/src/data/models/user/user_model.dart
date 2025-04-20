import 'package:my_book_store/src/core/exceptions/my_book_store_exceptions.dart';
import 'package:my_book_store/src/data/models/user/admin_model.dart';
import 'package:my_book_store/src/data/models/user/employee_model.dart';

enum UserType {
  admin('Admin'),
  employe('Employee');

  final String text;
  const UserType(this.text);
}

abstract class UserModel {
  final int id;
  final String name;
  final UserType type;
  final String? username;

  UserModel({
    required this.id,
    required this.name,
    required this.type,
    this.username,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>;
    final role = user['role'] as String;
    if (role == UserType.admin.text) {
      final store = json['store'] as Map<String, dynamic>;
      return AdminModel.fromMap(user, store);
    } else if (role == UserType.employe.text) {
      return EmployeeModel.fromMap(user);
    }
    throw MyBookStoreException('Invalid user type: $role');
  }

  bool get isAdmin => type == UserType.admin;
}
