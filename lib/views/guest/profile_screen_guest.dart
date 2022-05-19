import 'package:architect_app/utils/generals.dart';
import 'package:architect_app/views/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreenGuest extends StatefulWidget {
  @override
  State<ProfileScreenGuest> createState() => _ProfileScreenGuestState();
}

class _ProfileScreenGuestState extends State<ProfileScreenGuest> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              height: 250,
              // color: Colors.amber,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                    // child: Image.asset('assets/images/avatar.png',
                    //     fit: BoxFit.cover),
                    radius: 40,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        // _onLoginClicked();
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return SignInScreen();
                          },
                        ));
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.amber),
                      child: Text("Masuk")),
                ],
              ),
            ),
          ],
        ));
  }
}
