part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileLoad extends ProfileEvent {
  @override
  String toString() => 'ProfileLoad';

  @override
  List<Object> get props => [];
}

class ProfileEdit extends ProfileEvent {
  final EditProfileForm param;

  ProfileEdit({this.param});

  @override
  String toString() => 'Edit Profile';

  @override
  List<Object> get props => [param];
}

class PasswordChange extends ProfileEvent {
  final ChangePasswordForm param;

  PasswordChange({this.param});

  @override
  String toString() => 'Edit Profile';

  @override
  List<Object> get props => [param];
}

class ProfileLogout extends ProfileEvent {
  @override
  String toString() => 'ProfileLogout';

  @override
  List<Object> get props => [];
}
