part of 'employees_bloc.dart';

sealed class EmployeesState extends Equatable {
  const EmployeesState();

  @override
  List<Object> get props => [];
}

final class EmployeesInitial extends EmployeesState {}

final class EmployeesLoadingState extends EmployeesState {}

final class EmployeesLoadedState extends EmployeesState {
  const EmployeesLoadedState(this.employees);

  final List<EmployeeModel> employees;

  @override
  List<Object> get props => [employees];
}

final class EmployeesFailureState extends EmployeesState
    with ErrorMessageMixin {
  const EmployeesFailureState(this.exception);

  @override
  final Exception exception;

  @override
  List<Object> get props => [exception];
}

final class EmployeesEmployeeDeletedState extends EmployeesState {
  const EmployeesEmployeeDeletedState();
}
