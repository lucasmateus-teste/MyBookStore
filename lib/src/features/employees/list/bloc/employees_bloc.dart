import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:my_book_store/src/services/employee_service.dart';
import 'package:my_book_store/src/core/ui/mixins/error_message_mixin.dart';
import 'package:my_book_store/src/data/models/user/employee_model.dart';

part 'employees_event.dart';
part 'employees_state.dart';

class EmployeesBloc extends Bloc<EmployeesEvent, EmployeesState> {
  EmployeesBloc({required this.employeeService}) : super(EmployeesInitial()) {
    on<EmployeesGetEmployeesEvent>(_onGetEmployeesEvent);
    on<EmployeesDeleteEmployeeEvent>(_onDeleteEmployeeEvent);
  }

  @protected
  final EmployeeService employeeService;

  Future<void> _onGetEmployeesEvent(
    EmployeesGetEmployeesEvent event,
    Emitter<EmployeesState> emit,
  ) async {
    emit(EmployeesLoadingState());
    try {
      final employees = await employeeService.getAll();
      emit(EmployeesLoadedState(employees));
    } on Exception catch (e) {
      emit(EmployeesFailureState(e));
    }
  }

  Future<void> _onDeleteEmployeeEvent(
    EmployeesDeleteEmployeeEvent event,
    Emitter<EmployeesState> emit,
  ) async {
    emit(EmployeesLoadingState());
    try {
      await employeeService.remove(event.employeeId);
      emit(EmployeesEmployeeDeletedState());
    } on Exception catch (e) {
      emit(EmployeesFailureState(e));
    }
  }
}
