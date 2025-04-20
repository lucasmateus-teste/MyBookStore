import 'package:my_book_store/src/data/models/auth_model.dart';
import 'package:my_book_store/src/data/models/credentials_model.dart';

abstract interface class UserRepository {
  Future<AuthModel> login(CredentialsModel credentials);
}
