part of 'edit_profile_bloc.dart';

sealed class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

final class EditProfileInitial extends EditProfileState {}

final class EditProfileLoading extends EditProfileState {}

final class EditProfileSuccess extends EditProfileState {
  const EditProfileSuccess({required this.store});

  final StoreModel store;

  @override
  List<Object> get props => [store];
}

final class EditProfileFailure extends EditProfileState with ErrorMessageMixin {
  const EditProfileFailure({required this.exception});

  @override
  final Exception exception;

  @override
  List<Object> get props => [exception];
}
