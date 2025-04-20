import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:my_book_store/src/services/employee_service.dart';
import 'package:my_book_store/src/core/ui/mixins/error_message_mixin.dart';
import 'package:my_book_store/src/data/models/user/employee_model.dart';

part 'employee_form_event.dart';
part 'employee_form_state.dart';

class EmployeeFormBloc extends Bloc<EmployeeFormEvent, EmployeeFormState> {
  EmployeeFormBloc({required this.employeeService})
    : super(EmployeeFormInitial()) {
    on<EmployeeFormCreateEvent>(_onEmployeeCreateEvent);
    on<EmployeeFormUpdateEvent>(_onEmployeeUpdateEvent);
  }

  @protected
  final EmployeeService employeeService;

  Future<void> _onEmployeeCreateEvent(
    EmployeeFormCreateEvent event,
    Emitter<EmployeeFormState> emit,
  ) async {
    emit(EmployeeFormLoadingState());
    try {
      await employeeService.create(event.employee);
      emit(EmployeeFormCreatedState());
    } catch (e) {
      emit(EmployeeFormFailureState(e as Exception));
    }
  }

  Future<void> _onEmployeeUpdateEvent(
    EmployeeFormUpdateEvent event,
    Emitter<EmployeeFormState> emit,
  ) async {
    emit(EmployeeFormLoadingState());
    try {
      await employeeService.update(event.employee);
      emit(EmployeeFormUpdatedState());
    } catch (e) {
      emit(EmployeeFormFailureState(e as Exception));
    }
  }
}
