import 'package:another_flushbar/flushbar.dart';
import 'package:architect_app/bloc/login/login_bloc.dart';
import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/forms/login_form.dart';
import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/models/repositories/repository.dart';
import 'package:architect_app/utils/dimension.dart';
import 'package:architect_app/utils/validations.dart';
import 'package:architect_app/views/auth/choose_role.dart';
import 'package:architect_app/views/main_page.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final Repository _repository = Repository();
  final AuthPreference _authPreference = AuthPreference();
  final _emailForm = TextEditingController();
  final _passwordForm = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _obscureText = true;
  bool isLoading = false;
  LoginBloc _loginBloc;
  FirebaseMessaging _firebaseMessaging;
  String _token;

  _initialize() async {
    // await Firebase.initializeApp();
    _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.getToken().then((value) {
      _token = value;
    });
  }

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        // key: scaffoldKey,
        body: BlocProvider<LoginBloc>(
          create: (BuildContext context) => _loginBloc = LoginBloc(
              repository: _repository, authPreference: _authPreference),
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginFailure) {
                Flushbar(
                  flushbarStyle: FlushbarStyle.FLOATING,
                  flushbarPosition: FlushbarPosition.TOP,
                  backgroundColor: Colors.red,
                  message: "Login Gagal",
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
              } else if (state is LoginSuccess) {
                // navigator.pop(context);
                if (state.record.success == true) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
                      (Route<dynamic> route) => false);
                  setState(() {
                    isLoading = false;
                  });
                } else if (state.record.message == "Account not active.") {
                  Flushbar(
                    flushbarStyle: FlushbarStyle.FLOATING,
                    flushbarPosition: FlushbarPosition.TOP,
                    backgroundColor: Colors.red,
                    message: "Akun tidak aktif",
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
                } else {
                  Flushbar(
                    flushbarStyle: FlushbarStyle.FLOATING,
                    flushbarPosition: FlushbarPosition.TOP,
                    backgroundColor: Colors.red,
                    message: "Login Gagal",
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
                "Masuk",
                style: blackFontStyle3.copyWith(fontSize: 24),
              ),
              SizedBox(height: 24),
              TextFormField(
                  controller: _emailForm,
                  validator: Validations.emptyValidation,
                  decoration: InputDecoration(
                      hintStyle: greyFontStyle,
                      labelText: "email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ))),
              SizedBox(height: 24),
              Stack(children: [
                TextFormField(
                    controller: _passwordForm,
                    obscureText: _obscureText,
                    validator: Validations.emptyValidation,
                    decoration: InputDecoration(
                        hintStyle: greyFontStyle,
                        labelText: "password",
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
              SizedBox(height: 24),
              Container(
                width: double.infinity,
                child: isLoading
                    ? loadingIndicator
                    : ElevatedButton(
                        onPressed: () {
                          _onLoginClicked();
                        },
                        style: ElevatedButton.styleFrom(primary: Colors.amber),
                        child: Text("Masuk")),
              ),
              SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width),
                      child: Text(
                        "Belum memiliki akun?",
                        style: greyFontStyle,
                      )),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChooseRole()));
                    },
                    child: Container(
                        padding: EdgeInsets.only(left: 5),
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width),
                        child: Text(
                          "Daftar",
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

  _onLoginClicked() async {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      _loginBloc.add(LoginPost(
          loginForm: LoginForm(
              email: _emailForm.text.trim().toLowerCase(),
              password: _passwordForm.text)));
      setState(() {
        isLoading = true;
      });
    }
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }
}
