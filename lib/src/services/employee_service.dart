import 'package:flutter/foundation.dart';
import 'package:my_book_store/src/core/constants/local_storage_constants.dart';
import 'package:my_book_store/src/core/exceptions/my_book_store_exceptions.dart';
import 'package:my_book_store/src/core/local_storage/local_storage.dart';
import 'package:my_book_store/src/data/models/user/employee_model.dart';
import 'package:my_book_store/src/data/repositories/employee/employee_repository.dart';

class EmployeeService {
  EmployeeService({required this.repository, required this.localStorage});

  @protected
  final EmployeeRepository repository;
  @protected
  final LocalStorage localStorage;

  Future<List<EmployeeModel>> getAll() async {
    final storeId = getStoreId();
    final employees = await repository.getAll(storeId);

    return employees;
  }

  Future<EmployeeModel> get(int id) async {
    final storeId = getStoreId();
    final employee = await repository.get(storeId, id);

    return employee;
  }

  Future<void> create(EmployeeModel employee) async {
    final storeId = getStoreId();
    await repository.create(storeId, employee);
  }

  Future<void> remove(int id) async {
    final storeId = getStoreId();
    await repository.remove(storeId, id);
  }

  Future<void> update(EmployeeModel employee) async {
    final storeId = getStoreId();
    await repository.update(storeId, employee);
  }

  int getStoreId() {
    final result = localStorage.get(LocalStorageConstants.storeId);
    if (result != null) {
      return int.parse(result);
    }
    throw MyBookStoreException('Erro ao buscar o storeId');
  }
}
