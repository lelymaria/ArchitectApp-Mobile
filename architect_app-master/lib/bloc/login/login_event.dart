part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const <dynamic>[]]);
}

class LoginPost extends LoginEvent {
  final LoginForm loginForm;

  LoginPost({this.loginForm});

  @override
  String toString() => 'Login';

  @override
  List<Object> get props => [loginForm];
}

class RegisterPost extends LoginEvent {
  final RegisterForm registerForm;

  RegisterPost({this.registerForm});

    @override
  String toString() => 'Register';

  @override
  List<Object> get props => [registerForm];
}

class RegisterConsultanPost extends LoginEvent {
  final RegisterForm registerForm;

  RegisterConsultanPost({this.registerForm});

    @override
  String toString() => 'Register Consultant';

  @override
  List<Object> get props => [registerForm];
}

class RegisterContractorPost extends LoginEvent {
  final RegisterForm registerForm;

  RegisterContractorPost({this.registerForm});

    @override
  String toString() => 'Register Contractor';

  @override
  List<Object> get props => [registerForm];
}
