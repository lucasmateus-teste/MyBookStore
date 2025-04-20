import 'package:mocktail/mocktail.dart';
import 'package:my_book_store/src/data/repositories/book/book_repository.dart';
import 'package:my_book_store/src/data/repositories/employee/employee_repository.dart';
import 'package:my_book_store/src/data/repositories/store/store_repository.dart';
import 'package:my_book_store/src/data/repositories/user/user_repository.dart';

class MockBookRepository extends Mock implements BookRepository {}

class MockEmployeeRepository extends Mock implements EmployeeRepository {}

class MockStoreRepository extends Mock implements StoreRepository {}

class MockUserRepository extends Mock implements UserRepository {}
