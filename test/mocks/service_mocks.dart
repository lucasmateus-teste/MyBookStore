import 'package:mocktail/mocktail.dart';
import 'package:my_book_store/src/services/auth_service.dart';
import 'package:my_book_store/src/services/book_service.dart';
import 'package:my_book_store/src/services/employee_service.dart';
import 'package:my_book_store/src/services/store_service.dart';

class MockAuthService extends Mock implements AuthService {}

class MockBookService extends Mock implements BookService {}

class MockEmployeeService extends Mock implements EmployeeService {}

class MockStoreService extends Mock implements StoreService {}
