import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/models/repositories/repository.dart';
import 'package:architect_app/models/responses/login_response.dart';
import 'package:architect_app/views/admin/consultant_verification.dart';
import 'package:architect_app/views/admin/payment_verification.dart';
import 'package:architect_app/views/admin/profesional_verification.dart';
import 'package:architect_app/views/chat/listchat_screen.dart';
import 'package:architect_app/views/contractor/contractor_project.dart';
import 'package:architect_app/views/contractor/find_profesional.dart';
import 'package:architect_app/views/home/home_screen.dart';
import 'package:architect_app/views/professional/consultant_projects.dart';
import 'package:architect_app/views/professional/profesional_screen.dart';
import 'package:architect_app/views/profile/find_services.dart';
import 'package:architect_app/views/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

class MainPage extends StatefulWidget {
  final int initialPage;

  MainPage({this.initialPage = 0});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedPage = 0;
  PageController pageController = PageController(initialPage: 0);
  FirebaseMessaging _firebaseMessaging;
  User _user;
  AuthPreference _authPreference = AuthPreference();
  Repository _repository = Repository();

  _initialize() async {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    _initializeFirebaseMessaging();
  }

  _initializeFirebaseMessaging() {
    _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging
        .getToken()
        .then((value) => {_repository.setFirebase(_authPreference, value)});

    // Mengirim pesan saat aplikasi sedang dibuka
    // if (_isLogin) {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message reveiced");
      RemoteNotification notification = event.notification;
      AndroidNotification android = event.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              playSound: true,
              color: Colors.blue,
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainPage()));
    });
    // }
  }

  @override
  void initState() {
    super.initState();
    _initialize();
    selectedPage = widget.initialPage;
    pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _authPreference.getUserData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            _user = snapshot.data;
            // Subscribe topik berdasarkan role
            FirebaseMessaging.instance.subscribeToTopic(_user.level == "owner"
                ? "owner"
                : _user.level == "konsultan"
                    ? "konsultan"
                    : "admin");
            return Scaffold(
                body: _buildContent(selectedPage, snapshot.data),
                bottomNavigationBar: _user.level != "admin"
                    ? BottomNavigationBar(
                        items: [
                          BottomNavigationBarItem(
                              icon: _user.level == "admin"
                                  ? Icon(Icons.verified_user)
                                  : Icon(Icons.home),
                              label: _user.level == "admin"
                                  ? "Verifikasi"
                                  : "Home"),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.architecture),
                              label: _user.level == "owner"
                                  ? "Konsultan"
                                  : "Project"),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.message), label: "Pesan"),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.person), label: "Profile"),
                        ],
                        currentIndex: selectedPage,
                        onTap: (index) {
                          setState(() {
                            selectedPage = index;
                          });
                        },
                        selectedItemColor: Colors.amber,
                        unselectedItemColor: Colors.black45,
                        showUnselectedLabels: true,
                      )
                    : BottomNavigationBar(
                        items: [
                          BottomNavigationBarItem(
                              icon: Icon(Icons.verified_user),
                              label: "Verifikasi"),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.payments), label: "Pembayaran"),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.person), label: "Profile"),
                        ],
                        currentIndex: selectedPage,
                        onTap: (index) {
                          setState(() {
                            selectedPage = index;
                          });
                        },
                        selectedItemColor: Colors.amber,
                        unselectedItemColor: Colors.black45,
                        showUnselectedLabels: true,
                      ));
          } else {
            return Scaffold();
          }
        });
  }

  Widget _buildContent(int index, User user) {
    if (user.level == "admin") {
      switch (index) {
        case 0:
          return ProfesionalVerification();
        case 1:
          return PaymentVerification();
        case 2:
          return ProfileScreen();
        default:
          return ProfesionalVerification();
      }
    } else {
      switch (index) {
        case 0:
          return user.level == "owner"
              ? HomeScreen()
              : user.level == "konsultan"
                  ? FindServices()
                  : FindProfesional();
        case 1:
          return user.level == "owner"
              ? ProfesionalScreen()
              : user.level == "konsultan"
                  ? ConsultanProjects()
                  : ContractorProject();
        case 2:
          return ListChatScreen();
        case 3:
          return ProfileScreen();
        default:
          return user.level == "owner"
              ? HomeScreen()
              : user.level == "konsultan"
                  ? FindServices()
                  : FindProfesional();
      }
    }
  }
}
