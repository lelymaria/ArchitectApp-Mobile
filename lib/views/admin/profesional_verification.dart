import 'package:architect_app/views/admin/consultant_verification.dart';
import 'package:architect_app/views/admin/contractor_verification.dart';
import 'package:flutter/material.dart';

class ProfesionalVerification extends StatefulWidget {
  @override
  _ProfesionalVerificationState createState() =>
      _ProfesionalVerificationState();
}

class _ProfesionalVerificationState extends State<ProfesionalVerification> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: Colors.black,
                  indicatorColor: Colors.amber,
                  tabs: [
                    Tab(text: "Konsultan"),
                    Tab(text: "Kontraktor"),
                  ],
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              new ConsultanVerification(),
              new ContractorVerification(),
            ],
          ),
        ),
      ),
    );
  }
}
