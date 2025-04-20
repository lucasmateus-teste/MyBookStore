part of 'employee_form_bloc.dart';

sealed class EmployeeFormState extends Equatable {
  const EmployeeFormState();

  @override
  List<Object> get props => [];
}

final class EmployeeFormInitial extends EmployeeFormState {}

final class EmployeeFormLoadingState extends EmployeeFormState {}

final class EmployeeFormCreatedState extends EmployeeFormState {
  const EmployeeFormCreatedState();
}

final class EmployeeFormUpdatedState extends EmployeeFormState {
  const EmployeeFormUpdatedState();
}

final class EmployeeFormFailureState extends EmployeeFormState
    with ErrorMessageMixin {
  const EmployeeFormFailureState(this.exception);

  @override
  final Exception exception;

  @override
  List<Object> get props => [exception];
}
