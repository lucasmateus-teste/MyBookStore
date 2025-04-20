import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_book_store/src/services/employee_service.dart';
import 'package:my_book_store/src/features/employees/form/bloc/employee_form_bloc.dart';
import 'package:my_book_store/src/data/models/user/employee_model.dart';

import '../../../../../mocks/app_mocks.dart';
import '../../../../../mocks/service_mocks.dart';

void main() {
  late EmployeeService employeeService;
  late EmployeeFormBloc bloc;
  late EmployeeModel employee;

  setUpAll(() {
    registerFallbackValue(AppMocks.employee1);
  });

  setUp(() {
    employeeService = MockEmployeeService();
    bloc = EmployeeFormBloc(employeeService: employeeService);
    employee = AppMocks.employee1;
  });

  group('EmployeeFormBloc', () {
    blocTest<EmployeeFormBloc, EmployeeFormState>(
      'Emits EmployeeFormCreatedState when an employee is created successfully',
      build: () {
        when(
          () => employeeService.create(any()),
        ).thenAnswer((_) async => Future.value());
        return bloc;
      },
      act: (bloc) => bloc.add(EmployeeFormCreateEvent(employee)),
      expect:
          () => [
            isA<EmployeeFormLoadingState>(),
            isA<EmployeeFormCreatedState>(),
          ],
    );

    blocTest<EmployeeFormBloc, EmployeeFormState>(
      'Emits EmployeeFormUpdatedState when an employee is updated successfully',
      build: () {
        when(
          () => employeeService.update(any()),
        ).thenAnswer((_) async => Future.value());
        return bloc;
      },
      act: (bloc) => bloc.add(EmployeeFormUpdateEvent(employee)),
      expect:
          () => [
            isA<EmployeeFormLoadingState>(),
            isA<EmployeeFormUpdatedState>(),
          ],
    );

    blocTest<EmployeeFormBloc, EmployeeFormState>(
      'Emits EmployeeFormFailureState when creating an employee fails',
      build: () {
        when(
          () => employeeService.create(any()),
        ).thenThrow(Exception('Error creating employee'));
        return bloc;
      },
      act: (bloc) => bloc.add(EmployeeFormCreateEvent(employee)),
      expect:
          () => [
            isA<EmployeeFormLoadingState>(),
            isA<EmployeeFormFailureState>(),
          ],
    );

    blocTest<EmployeeFormBloc, EmployeeFormState>(
      'Emits EmployeeFormFailureState when updating an employee fails',
      build: () {
        when(
          () => employeeService.update(any()),
        ).thenThrow(Exception('Error updating employee'));
        return bloc;
      },
      act: (bloc) => bloc.add(EmployeeFormUpdateEvent(employee)),
      expect:
          () => [
            isA<EmployeeFormLoadingState>(),
            isA<EmployeeFormFailureState>(),
          ],
    );
  });
}
