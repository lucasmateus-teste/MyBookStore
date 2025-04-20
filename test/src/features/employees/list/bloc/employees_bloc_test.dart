import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_book_store/src/services/employee_service.dart';
import 'package:my_book_store/src/features/employees/list/bloc/employees_bloc.dart';

import '../../../../../mocks/app_mocks.dart';
import '../../../../../mocks/service_mocks.dart';

void main() {
  late EmployeeService employeeService;
  late EmployeesBloc bloc;

  setUpAll(() {
    registerFallbackValue(AppMocks.employee1);
  });

  setUp(() {
    employeeService = MockEmployeeService();
    bloc = EmployeesBloc(employeeService: employeeService);
  });

  group('EmployeesBloc', () {
    blocTest<EmployeesBloc, EmployeesState>(
      'Emits EmployeesLoadedState when employees are fetched successfully',
      build: () {
        when(
          () => employeeService.getAll(),
        ).thenAnswer((_) async => [AppMocks.employee1, AppMocks.employee2]);
        return bloc;
      },
      act: (bloc) => bloc.add(const EmployeesGetEmployeesEvent()),
      expect: () => [isA<EmployeesLoadingState>(), isA<EmployeesLoadedState>()],
    );

    blocTest<EmployeesBloc, EmployeesState>(
      'Emits EmployeesFailureState when fetching employees fails',
      build: () {
        when(
          () => employeeService.getAll(),
        ).thenThrow(Exception('Error fetching employees'));
        return bloc;
      },
      act: (bloc) => bloc.add(const EmployeesGetEmployeesEvent()),
      expect:
          () => [isA<EmployeesLoadingState>(), isA<EmployeesFailureState>()],
    );

    blocTest<EmployeesBloc, EmployeesState>(
      'Emits EmployeesEmployeeDeletedState when an employee is deleted successfully',
      build: () {
        when(
          () => employeeService.remove(any()),
        ).thenAnswer((_) async => Future.value());
        return bloc;
      },
      act: (bloc) => bloc.add(const EmployeesDeleteEmployeeEvent(1)),
      expect:
          () => [
            isA<EmployeesLoadingState>(),
            isA<EmployeesEmployeeDeletedState>(),
          ],
    );

    blocTest<EmployeesBloc, EmployeesState>(
      'Emits EmployeesFailureState when deleting an employee fails',
      build: () {
        when(
          () => employeeService.remove(any()),
        ).thenThrow(Exception('Error deleting employee'));
        return bloc;
      },
      act: (bloc) => bloc.add(const EmployeesDeleteEmployeeEvent(1)),
      expect:
          () => [isA<EmployeesLoadingState>(), isA<EmployeesFailureState>()],
    );
  });
}
