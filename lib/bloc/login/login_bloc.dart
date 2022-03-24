import 'dart:async';

import 'package:architect_app/models/forms/login_form.dart';
import 'package:architect_app/models/forms/register_form.dart';
import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/models/repositories/repository.dart';
import 'package:architect_app/models/responses/login_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Repository repository;
  final AuthPreference authPreference;

  LoginBloc({@required this.repository, @required this.authPreference})
      : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginPost) {
      yield LoginLoading();
      try {
        dynamic record = await repository.postLogin(event.loginForm);

        // Menyimpan data pada shared preference
        if (record.success == true) {
          await authPreference.setUserData(record.data.user);
          await authPreference.setToken(record.data.token);
        }

        yield LoginSuccess(record: record);
      } catch (e) {
        yield LoginFailure(error: e.toString());
      }
    } else if (event is RegisterPost) {
      try {
        dynamic record = await repository.postRegister(event.registerForm);
        yield RegisterSuccess(record: record);
      } catch (e) {
        yield RegisterFailure(error: e.toString());
      }
    } else if (event is RegisterConsultanPost) {
      try {
        dynamic record = await repository.postRegisterPro(event.registerForm);
        yield RegisterSuccess(record: record);
      } catch (e) {
        yield RegisterFailure(error: e.toString());
      }
    } else if (event is RegisterContractorPost) {
      try {
        dynamic record = await repository.postRegisterPro(event.registerForm);
        yield RegisterSuccess(record: record);
      } catch (e) {
        yield RegisterFailure(error: e);
      }
    }
  }
}
