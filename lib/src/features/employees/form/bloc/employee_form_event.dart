part of 'employee_form_bloc.dart';

sealed class EmployeeFormEvent extends Equatable {
  const EmployeeFormEvent();

  @override
  List<Object> get props => [];
}

final class EmployeeFormCreateEvent extends EmployeeFormEvent {
  const EmployeeFormCreateEvent(this.employee);

  final EmployeeModel employee;

  @override
  List<Object> get props => [employee];
}

final class EmployeeFormUpdateEvent extends EmployeeFormEvent {
  const EmployeeFormUpdateEvent(this.employee);

  final EmployeeModel employee;

  @override
  List<Object> get props => [employee];
}
