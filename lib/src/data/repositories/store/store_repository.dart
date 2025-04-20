import 'package:my_book_store/src/data/dtos/store_create_dto.dart';
import 'package:my_book_store/src/data/models/auth_model.dart';
import 'package:my_book_store/src/data/models/store_model.dart';

abstract interface class StoreRepository {
  Future<StoreModel> get(int id);
  Future<AuthModel> create(StoreCreateDto store);
  Future<void> update(StoreModel store);
}
