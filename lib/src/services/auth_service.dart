import 'package:flutter/foundation.dart';
import 'package:my_book_store/src/core/constants/local_storage_constants.dart';
import 'package:my_book_store/src/core/local_storage/local_storage.dart';
import 'package:my_book_store/src/data/dtos/store_create_dto.dart';
import 'package:my_book_store/src/data/models/auth_model.dart';
import 'package:my_book_store/src/data/models/credentials_model.dart';
import 'package:my_book_store/src/data/repositories/store/store_repository.dart';
import 'package:my_book_store/src/data/repositories/user/user_repository.dart';

class AuthService {
  AuthService({
    required this.userRepository,
    required this.localStorage,
    required this.storeRepository,
  });

  @protected
  final UserRepository userRepository;
  @protected
  final StoreRepository storeRepository;
  @protected
  final LocalStorage localStorage;

  Future<AuthModel> login(CredentialsModel credentials) async {
    try {
      final authModel = await userRepository.login(credentials);
      await localStorage.save(
        LocalStorageConstants.accessToken,
        authModel.token,
      );
      await localStorage.save(
        LocalStorageConstants.refreshToken,
        authModel.refreshToken,
      );
      await localStorage.save(
        LocalStorageConstants.storeId,
        authModel.store.id.toString(),
      );

      return authModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthModel> createStore(StoreCreateDto dto) async {
    try {
      final authModel = await storeRepository.create(dto);
      await localStorage.save(
        LocalStorageConstants.accessToken,
        authModel.token,
      );
      await localStorage.save(
        LocalStorageConstants.refreshToken,
        authModel.refreshToken,
      );

      return authModel;
    } catch (e) {
      rethrow;
    }
  }
}
