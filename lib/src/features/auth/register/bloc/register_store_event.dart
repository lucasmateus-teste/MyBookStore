part of 'register_store_bloc.dart';

sealed class RegisterStoreEvent extends Equatable {
  const RegisterStoreEvent();

  @override
  List<Object> get props => [];
}

class RegisterStoreSubmit extends RegisterStoreEvent {
  const RegisterStoreSubmit({required this.store});

  final StoreCreateDto store;

  @override
  List<Object> get props => [store];
}
