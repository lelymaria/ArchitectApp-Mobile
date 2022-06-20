import 'package:architect_app/views/guest/home_screen_guest.dart';
import 'package:architect_app/views/guest/profesional_screen_guest.dart';
import 'package:architect_app/views/guest/profile_screen_guest.dart';
import 'package:architect_app/views/home/home_screen.dart';
import 'package:architect_app/views/professional/consultant_projects.dart';
import 'package:architect_app/views/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class GuestHome extends StatefulWidget {
  @override
  State<GuestHome> createState() => _GuestHomeState();
}

class _GuestHomeState extends State<GuestHome> {
  int selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            // BottomNavigationBarItem(icon: Icon(Icons.architecture), label: "Profesional"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
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
        ),
        body: _buildContent(selectedPage));
  }
}

Widget _buildContent(int selectedPage) {
  switch (selectedPage) {
    case 0:
      return HomeScreenGuest();
    // case 1:
    //   return ProfesionalScreenGuest();
    case 1:
      return ProfileScreenGuest();
    default:
      return HomeScreenGuest();
  }
}
