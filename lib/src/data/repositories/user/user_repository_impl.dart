import 'package:flutter/foundation.dart';
import 'package:my_book_store/src/core/http/client/http_client.dart';
import 'package:my_book_store/src/data/models/auth_model.dart';
import 'package:my_book_store/src/data/models/credentials_model.dart';
import 'package:my_book_store/src/data/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({required this.httpService});

  @protected
  final HttpClient httpService;

  @override
  Future<AuthModel> login(CredentialsModel credentials) async {
    final response = await httpService.unauth.post(
      'v1/auth',
      data: credentials.toMap(),
    );

    return AuthModel.fromMap(response.data);
  }
}
