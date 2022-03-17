part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable {
  LoginState([List props = const <dynamic>[]]);
}

class LoginInitial extends LoginState {
  @override
  String toString() => 'LoginUninitialized';

  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  @override
  String toString() => 'LoginLoading';

  @override
  List<Object> get props => [];
}

class LoginSuccess extends LoginState {
  final LoginResponse record;

  LoginSuccess({this.record});

  @override
  List<Object> get props => [record];

  @override
  String toString() => 'LoginSuccess { record: $record }';
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({this.error});

  @override
  String toString() => 'LoginFailure { error: $error }';

  @override
  List<Object> get props => [error];
}

class RegisterSuccess extends LoginState {
  final dynamic record;

  RegisterSuccess({this.record});

  @override
  List<Object> get props => [record];

  @override
  String toString() => 'RegisterSuccess { record: $record }';
}

class RegisterFailure extends LoginState {
  final String error;

  RegisterFailure({this.error});

  @override
  String toString() => 'RegisterFailure { error: $error }';

  @override
  List<Object> get props => [error];
}
