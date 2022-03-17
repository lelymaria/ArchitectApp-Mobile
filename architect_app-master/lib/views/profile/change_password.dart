import 'package:another_flushbar/flushbar.dart';
import 'package:architect_app/bloc/profile/profile_bloc.dart';
import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/forms/change_password_form.dart';
import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/models/repositories/repository.dart';
import 'package:architect_app/utils/dimension.dart';
import 'package:architect_app/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChangePassword extends StatefulWidget {
  final AuthPreference authPreference;
  final int userId;

  ChangePassword(this.authPreference, this.userId);

  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<ChangePassword> {
  final _newpass = TextEditingController();
  final _newpassConfirm = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _repository = Repository();
  bool _obscureText = true;
  ProfileBloc _profileBloc;

  @override
  Widget build(BuildContext context) {
    Dimension().init(context);
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Ganti password",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: BlocProvider<ProfileBloc>(
          create: (context) => _profileBloc = ProfileBloc(authPreference: widget.authPreference, repository: _repository),
          child: BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileFailure) {
                Flushbar(
                  flushbarStyle: FlushbarStyle.FLOATING,
                  flushbarPosition: FlushbarPosition.TOP,
                  backgroundColor: Colors.red,
                  message: state.error,
                  icon: Icon(
                    FontAwesomeIcons.infoCircle,
                    size: 28.0,
                    color: Colors.white,
                  ),
                  duration: Duration(seconds: 3),
                ).show(context);
              } else if (state is PasswordChanged) {
                if (state.record.success == true) {
                  Flushbar(
                    flushbarStyle: FlushbarStyle.FLOATING,
                    flushbarPosition: FlushbarPosition.TOP,
                    backgroundColor: Colors.green,
                    message: "Ganti password berhasil",
                    icon: Icon(
                      FontAwesomeIcons.checkCircle,
                      size: 28.0,
                      color: Colors.white,
                    ),
                    duration: Duration(seconds: 3),
                  ).show(context);
                } else {
                  Flushbar(
                    flushbarStyle: FlushbarStyle.FLOATING,
                    flushbarPosition: FlushbarPosition.TOP,
                    backgroundColor: Colors.red,
                    message: "Password yang dimasukan tidak sama",
                    icon: Icon(
                      FontAwesomeIcons.infoCircle,
                      size: 28.0,
                      color: Colors.white,
                    ),
                    duration: Duration(seconds: 3),
                  ).show(context);
                }
              }
            },
            child: SafeArea(child: _buildContent(context)),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: Dimension.safeBlockHorizontal * 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Password baru",
                  style: blackFontStyle2.copyWith(fontSize: 16),
                ),
                SizedBox(height: 5),
                Stack(children: [
                  TextFormField(
                      obscureText: _obscureText,
                      controller: _newpass,
                      validator: Validations.emptyValidation,
                      decoration: InputDecoration(
                          hintStyle: greyFontStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ))),
                  Positioned(
                      top: Dimension.blockSizeVertical * 3,
                      right: Dimension.blockSizeVertical * 2,
                      child: GestureDetector(
                        child: SizedBox(
                            height: 24,
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey[700],
                            )),
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ))
                ]),
                SizedBox(height: 20),
                Text(
                  "Konfirmasi password",
                  style: blackFontStyle2.copyWith(fontSize: 16),
                ),
                SizedBox(height: 5),
                Stack(children: [
                  TextFormField(
                      obscureText: _obscureText,
                      controller: _newpassConfirm,
                      validator: Validations.emptyValidation,
                      decoration: InputDecoration(
                          hintStyle: greyFontStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ))),
                  Positioned(
                      top: Dimension.blockSizeVertical * 3,
                      right: Dimension.blockSizeVertical * 2,
                      child: GestureDetector(
                        child: SizedBox(
                            height: 24,
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey[700],
                            )),
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ))
                ]),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _onChangeClicked();
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.amber),
                    child: Text("Ganti Password"),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _onChangeClicked() {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      _profileBloc.add(PasswordChange(
          param: ChangePasswordForm(
              userId: widget.userId,
              newpass: _newpass.text,
              newpassConfirm: _newpassConfirm.text)));
    }
  }
}
