part of 'profile_overview_bloc.dart';

sealed class ProfileOverviewEvent extends Equatable {
  const ProfileOverviewEvent();

  @override
  List<Object> get props => [];
}

class ProfileOverviewGetDataEvent extends ProfileOverviewEvent {
  const ProfileOverviewGetDataEvent({required this.isAdmin});

  final bool isAdmin;

  @override
  List<Object> get props => [isAdmin];
}
