import 'package:another_flushbar/flushbar.dart';
import 'package:architect_app/bloc/login/login_bloc.dart';
import 'package:architect_app/models/forms/register_form.dart';
import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/models/repositories/repository.dart';
import 'package:architect_app/utils/dimension.dart';
import 'package:architect_app/utils/validations.dart';
import 'package:architect_app/views/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:architect_app/constants/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscureText = true;
  final nameForm = TextEditingController();
  final usernameForm = TextEditingController();
  final emailForm = TextEditingController();
  final passwordForm = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final Repository repository = Repository();
  final AuthPreference authPreference = AuthPreference();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  LoginBloc loginBloc;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        key: scaffoldKey,
        body: BlocProvider<LoginBloc>(
          create: (BuildContext context) => loginBloc =
              LoginBloc(repository: repository, authPreference: authPreference),
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is RegisterFailure) {
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
                setState(() {
                  isLoading = false;
                });
              } else if (state is RegisterSuccess) {
                var filenames = [];
                for (var i = 0; i < state.record['data'].length; i++) {
                  var item = state.record['data'];
                  var key = item.keys.first;
                  var filename = item[key];
                  filenames.add(filename[0]);
                }
                if (state.record['success'] == true) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignInScreen()));
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    Flushbar(
                      flushbarStyle: FlushbarStyle.FLOATING,
                      flushbarPosition: FlushbarPosition.TOP,
                      backgroundColor: Colors.green,
                      message: "Daftar berhasil",
                      icon: Icon(
                        FontAwesomeIcons.checkCircle,
                        size: 28.0,
                        color: Colors.white,
                      ),
                      duration: Duration(seconds: 3),
                    )..show(scaffoldKey.currentState.context);
                  });
                  setState(() {
                    nameForm.text = "";
                    usernameForm.text = "";
                    emailForm.text = "";
                    passwordForm.text = "";
                    isLoading = false;
                  });
                } else {
                  Flushbar(
                    flushbarStyle: FlushbarStyle.FLOATING,
                    flushbarPosition: FlushbarPosition.TOP,
                    backgroundColor: Colors.red,
                    message: filenames[0].toString(),
                    icon: Icon(
                      FontAwesomeIcons.infoCircle,
                      size: 28.0,
                      color: Colors.white,
                    ),
                    duration: Duration(seconds: 3),
                  ).show(context);
                  setState(() {
                    isLoading = false;
                  });
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
    Dimension().init(context);
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Daftar",
                style: blackFontStyle3.copyWith(fontSize: 24),
              ),
              SizedBox(height: 24),
              TextFormField(
                controller: nameForm,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Tidak boleh kosong";
                  } else if (value.length < 3) {
                    return "Minimal 3 karakter";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    hintStyle: greyFontStyle,
                    labelText: "nama",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
              ),
              SizedBox(height: 24),
              TextFormField(
                controller: usernameForm,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Tidak boleh kosong";
                  } else if (value.length < 3) {
                    return "Minimal 3 karakter";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    hintStyle: greyFontStyle,
                    labelText: "username",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
              ),
              SizedBox(height: 24),
              TextFormField(
                controller: emailForm,
                validator: Validations.emptyValidation,
                decoration: InputDecoration(
                    hintStyle: greyFontStyle,
                    labelText: "email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
              ),
              SizedBox(height: 24),
              Stack(children: [
                TextFormField(
                  controller: passwordForm,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Tidak boleh kosong";
                    } else if (value.length < 8) {
                      return "Minimal 8 karakter";
                    } else {
                      return null;
                    }
                  },
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                      hintStyle: greyFontStyle,
                      labelText: "password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      )),
                ),
                Positioned(
                    top: Dimension.blockSizeVertical * 3,
                    right: Dimension.blockSizeVertical * 2,
                    child: GestureDetector(
                      child: SizedBox(
                          height: 24,
                          child: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey[700],
                          )),
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ))
              ]),
              SizedBox(height: 24),
              Container(
                width: double.infinity,
                child: isLoading
                    ? loadingIndicator
                    : ElevatedButton(
                        onPressed: () {
                          _onRegisterClicked();
                        },
                        style: ElevatedButton.styleFrom(primary: Colors.amber),
                        child: Text("Daftar")),
              ),
              SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width),
                      child: Text(
                        "Sudah memiliki akun?",
                        style: greyFontStyle,
                      )),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()));
                    },
                    child: Container(
                        padding: EdgeInsets.only(left: 5),
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width),
                        child: Text(
                          "Masuk",
                          style: greyFontStyle.copyWith(
                              fontWeight: FontWeight.w600),
                        )),
                  )
                ],
              )
            ]),
          ),
        ],
      ),
    );
  }

  _onRegisterClicked() async {
    if (formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      loginBloc.add(
        RegisterPost(
          registerForm: RegisterForm(
            name: nameForm.text,
            username: usernameForm.text,
            email: emailForm.text.trim().toLowerCase(),
            password: passwordForm.text,
            isActive: 1,
          ),
        ),
      );
      setState(() {
        isLoading = true;
      });
    }
  }

  @override
  void dispose() {
    loginBloc.close();
    super.dispose();
  }
}
