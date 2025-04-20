part of 'employees_bloc.dart';

sealed class EmployeesEvent extends Equatable {
  const EmployeesEvent();

  @override
  List<Object> get props => [];
}

class EmployeesGetEmployeesEvent extends EmployeesEvent {
  const EmployeesGetEmployeesEvent();
}

class EmployeesDeleteEmployeeEvent extends EmployeesEvent {
  const EmployeesDeleteEmployeeEvent(this.employeeId);

  final int employeeId;

  @override
  List<Object> get props => [employeeId];
}
