import 'package:flutter/foundation.dart';
import 'package:my_book_store/src/core/http/client/http_client.dart';
import 'package:my_book_store/src/data/models/user/employee_model.dart';

import './employee_repository.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  EmployeeRepositoryImpl({required this.httpClient});

  @protected
  final HttpClient httpClient;

  @override
  Future<void> create(int storeId, EmployeeModel employee) async {
    await httpClient.auth.post(
      '/v1/store/$storeId/employee',
      data: employee.toMap(),
    );
  }

  @override
  Future<List<EmployeeModel>> getAll(int storeId) async {
    final response = await httpClient.auth.get('/v1/store/$storeId/employee');
    final data = response.data as List<dynamic>;
    return data.map((e) => EmployeeModel.fromMap(e)).toList();
  }

  @override
  Future<void> remove(int storeId, int id) async {
    await httpClient.auth.delete('/v1/store/$storeId/employee/$id');
  }

  @override
  Future<void> update(int storeId, EmployeeModel employee) async {
    await httpClient.auth.put(
      '/v1/store/$storeId/employee/${employee.id}',
      data: employee.toMap(),
    );
  }

  @override
  Future<EmployeeModel> get(int storeId, int id) async {
    final response = await httpClient.auth.get(
      '/v1/store/$storeId/employee/$id',
    );
    return EmployeeModel.fromMap(response.data);
  }
}
