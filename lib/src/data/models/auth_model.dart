import 'package:my_book_store/src/data/models/store_model.dart';
import 'package:my_book_store/src/data/models/user/user_model.dart';

class AuthModel {
  AuthModel({
    required this.token,
    required this.refreshToken,
    required this.user,
    required this.store,
  });

  final String token;
  final String refreshToken;
  final UserModel user;
  final StoreModel store;

  factory AuthModel.fromMap(Map<String, dynamic> json) {
    return AuthModel(
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String,
      user: UserModel.fromJson(json),
      store: StoreModel.fromMap(json['store']),
    );
  }
}
