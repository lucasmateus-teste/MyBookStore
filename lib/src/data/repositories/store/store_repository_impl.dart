import 'package:flutter/widgets.dart';
import 'package:my_book_store/src/core/http/client/http_client.dart';
import 'package:my_book_store/src/data/dtos/store_create_dto.dart';
import 'package:my_book_store/src/data/models/auth_model.dart';
import 'package:my_book_store/src/data/models/store_model.dart';
import 'package:my_book_store/src/data/repositories/store/store_repository.dart';

class StoreRepositoryImpl implements StoreRepository {
  StoreRepositoryImpl({required this.httpClient});

  @protected
  final HttpClient httpClient;

  @override
  Future<AuthModel> create(StoreCreateDto store) async {
    final response = await httpClient.unauth.post(
      'v1/store',
      data: store.toMap(),
    );
    return AuthModel.fromMap(response.data);
  }

  @override
  Future<StoreModel> get(int id) async {
    final response = await httpClient.auth.get('/v1/store/$id');
    return StoreModel.fromMap(response.data);
  }

  @override
  Future<void> update(StoreModel store) async {
    await httpClient.auth.put('/v1/store/${store.id}', data: store.toMap());
  }
}
