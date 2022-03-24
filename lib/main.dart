import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/views/main_page.dart';
import 'package:architect_app/views/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthPreference _authPreference = AuthPreference();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Architect App',
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _authPreference.hasToken(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              return MainPage();
            } else {
              return SignInScreen();
            }
          } else {
            return Scaffold();
          }
        },
      ),
    );
  }
}
