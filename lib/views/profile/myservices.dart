import 'package:architect_app/views/professional/all_consultant_lelang.dart';
import 'package:architect_app/views/professional/all_consultant_project.dart';
import 'package:architect_app/views/profile/auction.dart';
import 'package:architect_app/views/profile/projects_owner.dart';
import 'package:flutter/material.dart';

class Myservices extends StatefulWidget {
  @override
  _MyservicesState createState() => _MyservicesState();
}

class _MyservicesState extends State<Myservices> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(    
              "Project saya",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            bottom: TabBar(
              // indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.black,
              indicatorColor: Colors.amber,
              tabs: [
                Tab(text: "Project"),
                Tab(text: "Lelang"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              new AllConsultantProject(),
              new AllConsultantLelang(),
            ],
          ),
        ),
      ),
    );
  }
}
