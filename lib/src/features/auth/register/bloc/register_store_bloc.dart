import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:my_book_store/src/services/auth_service.dart';
import 'package:my_book_store/src/data/dtos/store_create_dto.dart';
import 'package:my_book_store/src/data/models/user/admin_model.dart';
import 'package:my_book_store/src/core/exceptions/my_book_store_exceptions.dart';

part 'register_store_event.dart';
part 'register_store_state.dart';

class RegisterStoreBloc extends Bloc<RegisterStoreEvent, RegisterStoreState> {
  RegisterStoreBloc({required this.authService})
    : super(RegisterStoreInitialState()) {
    on<RegisterStoreSubmit>(_onRegisterSubmit);
  }

  @protected
  final AuthService authService;

  Future<void> _onRegisterSubmit(
    RegisterStoreSubmit event,
    Emitter<RegisterStoreState> emit,
  ) async {
    emit(RegisterStoreLoadingState());
    try {
      final result = await authService.createStore(event.store);
      emit(RegisterStoreSuccessState(result.user as AdminModel));
    } on Exception catch (e) {
      emit(RegisterStoreFailureState(e));
    }
  }
}
