import 'package:flutter/foundation.dart';
import 'package:my_book_store/src/core/constants/local_storage_constants.dart';
import 'package:my_book_store/src/core/exceptions/my_book_store_exceptions.dart';
import 'package:my_book_store/src/core/local_storage/local_storage.dart';
import 'package:my_book_store/src/data/models/store_model.dart';
import 'package:my_book_store/src/data/repositories/store/store_repository.dart';

class StoreService {
  StoreService({required this.repository, required this.localStorage});

  @protected
  final StoreRepository repository;
  @protected
  final LocalStorage localStorage;

  Future<StoreModel> get() async {
    final storeId = getStoreId();
    final store = await repository.get(storeId);
    return store;
  }

  int getStoreId() {
    final result = localStorage.get(LocalStorageConstants.storeId);
    if (result != null) {
      return int.parse(result);
    }
    throw MyBookStoreException('Erro ao buscar o storeId');
  }
}
