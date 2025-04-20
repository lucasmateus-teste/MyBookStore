import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:my_book_store/src/core/ui/mixins/error_message_mixin.dart';
import 'package:my_book_store/src/data/models/store_model.dart';
import 'package:my_book_store/src/data/repositories/store/store_repository.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc({required this.storeRepository})
    : super(EditProfileInitial()) {
    on<EditProfileUpdateEvent>(_onUpdateProfile);
  }

  @protected
  final StoreRepository storeRepository;

  Future<void> _onUpdateProfile(
    EditProfileUpdateEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(EditProfileLoading());
    try {
      await storeRepository.update(event.store);

      emit(EditProfileSuccess(store: event.store));
    } catch (e) {
      emit(EditProfileFailure(exception: Exception(e)));
    }
  }
}
