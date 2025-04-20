import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_book_store/src/core/constants/local_storage_constants.dart';
import 'package:my_book_store/src/core/exceptions/my_book_store_exceptions.dart';
import 'package:my_book_store/src/services/employee_service.dart';

import '../../mocks/app_mocks.dart';
import '../../mocks/local_storage_mock.dart';
import '../../mocks/repository_mocks.dart';

void main() {
  late EmployeeService employeeService;
  late MockEmployeeRepository employeeRepository;
  late MockLocalStorage localStorage;

  setUp(() {
    employeeRepository = MockEmployeeRepository();
    localStorage = MockLocalStorage();
    employeeService = EmployeeService(
      repository: employeeRepository,
      localStorage: localStorage,
    );
  });

  group('EmployeeService', () {
    test('getAll fetches all employees successfully', () async {
      when(
        () => localStorage.get(LocalStorageConstants.storeId),
      ).thenReturn('1');
      when(
        () => employeeRepository.getAll(1),
      ).thenAnswer((_) async => [AppMocks.employee1, AppMocks.employee2]);

      final employees = await employeeService.getAll();

      expect(employees.length, 2);
      expect(employees.first, AppMocks.employee1);
      verify(() => employeeRepository.getAll(1)).called(1);
    });

    test('get fetches a specific employee successfully', () async {
      when(
        () => localStorage.get(LocalStorageConstants.storeId),
      ).thenReturn('1');
      when(
        () => employeeRepository.get(1, 2),
      ).thenAnswer((_) async => AppMocks.employee2);

      final employee = await employeeService.get(2);

      expect(employee, AppMocks.employee2);
      verify(() => employeeRepository.get(1, 2)).called(1);
    });

    test('create calls repository create with correct parameters', () async {
      final employee = AppMocks.employee1;

      when(
        () => localStorage.get(LocalStorageConstants.storeId),
      ).thenReturn('1');
      when(
        () => employeeRepository.create(1, employee),
      ).thenAnswer((_) async => {});

      await employeeService.create(employee);

      verify(() => employeeRepository.create(1, employee)).called(1);
    });

    test('remove calls repository remove with correct parameters', () async {
      when(
        () => localStorage.get(LocalStorageConstants.storeId),
      ).thenReturn('1');
      when(() => employeeRepository.remove(1, 2)).thenAnswer((_) async => {});

      await employeeService.remove(2);

      verify(() => employeeRepository.remove(1, 2)).called(1);
    });

    test('update calls repository update with correct parameters', () async {
      final employee = AppMocks.employee1;

      when(
        () => localStorage.get(LocalStorageConstants.storeId),
      ).thenReturn('1');
      when(
        () => employeeRepository.update(1, employee),
      ).thenAnswer((_) async => {});

      await employeeService.update(employee);

      verify(() => employeeRepository.update(1, employee)).called(1);
    });

    test('getStoreId throws exception if storeId is not found', () {
      when(
        () => localStorage.get(LocalStorageConstants.storeId),
      ).thenReturn(null);

      expect(
        () => employeeService.getStoreId(),
        throwsA(isA<MyBookStoreException>()),
      );
    });

    test('getStoreId returns storeId if found', () {
      when(
        () => localStorage.get(LocalStorageConstants.storeId),
      ).thenReturn('1');

      final storeId = employeeService.getStoreId();

      expect(storeId, 1);
    });
  });
}
