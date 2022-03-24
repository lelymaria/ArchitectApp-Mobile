import 'package:another_flushbar/flushbar.dart';
import 'package:architect_app/bloc/profile/profile_bloc.dart';
import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/models/repositories/repository.dart';
import 'package:architect_app/models/responses/login_response.dart';
import 'package:architect_app/views/professional/all_consultant_project.dart';
import 'package:architect_app/views/professional/proposal_screen.dart';
import 'package:architect_app/views/profile/auction.dart';
import 'package:architect_app/views/profile/change_password.dart';
import 'package:architect_app/views/profile/edit_profile.dart';
import 'package:architect_app/views/auth/sign_in_screen.dart';
import 'package:architect_app/views/profile/edit_profile_consultant.dart';
// import 'package:architect_app/views/profile/myservices.dart';
import 'package:architect_app/views/profile/projects_owner.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:architect_app/constants/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:architect_app/utils/generals.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthPreference _authPreference = AuthPreference();
  User _user;
  ProfileBloc _profileBloc;
  Repository _repository = Repository();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<ProfileBloc>(
        create: (BuildContext context) => _profileBloc =
            ProfileBloc(authPreference: _authPreference)..add(ProfileLoad()),
        child: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileLoaded) {
              setState(() {
                _user = state.userData;
              });
            } else if (state is LogoutSuccess) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(),
                  ),
                  (Route<dynamic> route) => false);
            }
          },
          child: FutureBuilder(
              future: _authPreference.getUserData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SafeArea(child: _buildContent(context));
                } else {
                  return Center(child: loadingIndicator);
                }
              }),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          width: size.width,
          margin: EdgeInsets.symmetric(vertical: defaultMargin * 2),
          child: Column(
            children: [
              Container(
                width: 110,
                height: 110,
                margin: EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        // "${'http://1803010.web.ti.polindra.ac.id/index.php/img/avatar/'}${_user.avatar}",
                        "${'${Generals.baseUrl}/img/avatar/'}${_user.avatar}",
                      ),
                    ),
                    borderRadius: BorderRadius.circular(100)),
              ),
              Text(_user.username,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))
            ],
          ),
        ),
        Container(
          width: size.width,
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            children: [
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => DesainTersimpan()));
              //   },
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text("Desain Tersimpan"),
              //       SizedBox(
              //           width: 24,
              //           height: 24,
              //           child: Image.asset('assets/images/right_arrow.png',
              //               fit: BoxFit.contain))
              //     ],
              //   ),
              // ),
              if (_user.level == "owner")
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProjectsOwner()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Project Saya"),
                            SizedBox(
                                width: 24,
                                height: 24,
                                child: Image.asset(
                                    'assets/images/right_arrow.png',
                                    fit: BoxFit.contain))
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Auction()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Lelang Saya"),
                            SizedBox(
                                width: 24,
                                height: 24,
                                child: Image.asset(
                                    'assets/images/right_arrow.png',
                                    fit: BoxFit.contain))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              if (_user.level == "konsultan")
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AllConsultantProject()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Desain Saya"),
                            SizedBox(
                                width: 24,
                                height: 24,
                                child: Image.asset(
                                    'assets/images/right_arrow.png',
                                    fit: BoxFit.contain))
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProposalScreen()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Proposal"),
                            SizedBox(
                                width: 24,
                                height: 24,
                                child: Image.asset(
                                    'assets/images/right_arrow.png',
                                    fit: BoxFit.contain))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              if (_user.level != "admin")
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => _user.level == "konsultan"
                                  ? EditProfileConsultant(
                                      _authPreference, _user)
                                  : EditProfile(_authPreference, _user)));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Edit Profile"),
                        SizedBox(
                            width: 24,
                            height: 24,
                            child: Image.asset('assets/images/right_arrow.png',
                                fit: BoxFit.contain))
                      ],
                    ),
                  ),
                ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChangePassword(_authPreference, _user.id)));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Ganti Password"),
                    SizedBox(
                        width: 24,
                        height: 24,
                        child: Image.asset('assets/images/right_arrow.png',
                            fit: BoxFit.contain))
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () async {
                      _confirmationDialog();
                    },
                    child: Text(
                      "Logout",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  _confirmationDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Icon(Icons.warning_amber_rounded),
                ),
                Expanded(
                  child: Text(
                    "Apakah anda yakin?",
                    style: TextStyle(fontSize: 14),
                  ),
                )
              ]),
          content: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white, onPrimary: Colors.black),
                    child: Text("Batal")),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                    onPressed: () async {
                      _logout();
                      // Navigator.pop(context);
                      // _profileBloc.add(ProfileLogout());
                      // _showLoaderDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white, onPrimary: Colors.black),
                    child: Text("Ya")),
              ),
            ],
          ),
        );
      },
    );
  }

  _showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text("Mohon tunggu"),
          )
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _logout() async {
    try {
      Navigator.pop(context);
      _showLoaderDialog(context);
      FirebaseMessaging.instance.unsubscribeFromTopic(_user.level == "owner"
          ? "owner"
          : _user.level == "konsultan"
              ? "konsultan"
              : "admin");
      _repository.logout(_authPreference).then((value) {
        if (value['success'] == true) {
          _authPreference.deleteAuthData();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => SignInScreen(),
              ),
              (Route<dynamic> route) => false);
        }
      });
    } catch (e) {
      Navigator.pop(context);
      Flushbar(
        flushbarStyle: FlushbarStyle.FLOATING,
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.red,
        message: "Logout Gagal",
        icon: Icon(
          FontAwesomeIcons.infoCircle,
          size: 28.0,
          color: Colors.white,
        ),
        duration: Duration(seconds: 3),
      ).show(context);
    }
  }
}
