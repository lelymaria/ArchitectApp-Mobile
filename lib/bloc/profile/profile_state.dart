part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  
  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final User userData;

  ProfileLoaded({this.userData});

  @override
  List<Object> get props => [userData];

  @override
  String toString() =>
      'ProfileLoaded { record: $userData }';
}

class ProfileEdited extends ProfileState {
  final EditProfileResponse record;

  ProfileEdited({this.record});

  @override
  List<Object> get props => [record];

  @override
  String toString() => 'EditProfilSuccess { record: $record }';
}

class PasswordChanged extends ProfileState {
  final ChangePasswordResponse record;

  PasswordChanged({this.record});

  @override
  List<Object> get props => [record];

  @override
  String toString() => 'ChangePasswordSuccess { record: $record }';
}

class ProfileFailure extends ProfileState {
  final String error;

  ProfileFailure({@required this.error});

  @override
  String toString() => 'ProfileFailure { error: $error }';

  @override
  List<Object> get props => [error];
}

class LogoutSuccess extends ProfileState {
  @override
  String toString() => 'Logout Success';
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {
  @override
  String toString() => 'ProfileLoading';

  @override
  List<Object> get props => [];
}
