import 'package:my_book_store/src/data/models/user/employee_model.dart';

abstract interface class EmployeeRepository {
  Future<List<EmployeeModel>> getAll(int storeId);
  Future<EmployeeModel> get(int storeId, int id);
  Future<void> create(int storeId, EmployeeModel employee);
  Future<void> remove(int storeId, int id);
  Future<void> update(int storeId, EmployeeModel employee);
}
