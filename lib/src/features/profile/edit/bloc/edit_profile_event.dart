part of 'edit_profile_bloc.dart';

sealed class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class EditProfileUpdateEvent extends EditProfileEvent {
  const EditProfileUpdateEvent({required this.store});

  final StoreModel store;
  // final EmployeeModel user;
}
