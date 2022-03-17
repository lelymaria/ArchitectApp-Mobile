import 'dart:async';

import 'package:architect_app/models/forms/change_password_form.dart';
import 'package:architect_app/models/forms/edit_profile_form.dart';
import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/models/repositories/repository.dart';
import 'package:architect_app/models/responses/change_password_response.dart';
import 'package:architect_app/models/responses/edit_profile_response.dart';
import 'package:architect_app/models/responses/login_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthPreference authPreference;
  final Repository repository;

  ProfileBloc({this.authPreference, this.repository}) : super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is ProfileLoad) {
      try {
        User record = await authPreference.getUserData();
        yield ProfileLoaded(userData: record);
      } catch (e) {
        yield ProfileFailure(error: "load data gagal");
      }
    }

    // if (event is ProfileEdit) {
    //   // yield ProfileLoading();
    //   try {
    //     String token = await authPreference.getToken();
    //     dynamic record =
    //         await repository.editProfile(event.param, token);
    //     // if (record.success == true) {
    //     //   await authPreference.setUserData(record.data);
    //     // }
    //     yield (ProfileEdited(record: record));
    //   } catch (e) {
    //     yield ProfileFailure(error: "Edit profile gagal");
    //   }
    // }

    if (event is PasswordChange) {
      try {
        String token = await authPreference.getToken();
        ChangePasswordResponse record =
            await repository.changePassword(event.param, token);
        yield (PasswordChanged(record: record));
      } catch (e) {
        yield ProfileFailure(error: "Ganti password gagal");
      }
    }

    // if (event is ProfileLogout) {
    //   try {
    //     String token = await authPreference.getToken();
    //     dynamic record = await repository.logout(token);
    //     if (record['success'] == true) {
    //       await authPreference.deleteAuthData();
    //     }
    //     yield LogoutSuccess();
    //   } catch (e) {
    //     yield ProfileFailure(error: "load data gagal");
    //   }
    // }
  }
}
