import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/models/repositories/repository.dart';
import 'package:architect_app/models/responses/get_consultant_response.dart';
import 'package:architect_app/views/professional/profesional_card.dart';
import 'package:architect_app/views/professional/profesional_detail.dart';
import 'package:flutter/material.dart';

class ProfesionalScreen extends StatefulWidget {
  @override
  _ProfesionalScreenState createState() => _ProfesionalScreenState();
}

class _ProfesionalScreenState extends State<ProfesionalScreen> {
  Repository _repository = Repository();
  AuthPreference _authPreference = AuthPreference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: _repository.getConsultantFromOwner(_authPreference),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List<DataConsultant> consultants = snapshot.data;
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: ListView.builder(
                    itemCount: consultants.length,
                    itemBuilder: (context, index) {
                      DataConsultant consultant = consultants[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfesionalDetail(
                                      consultant: consultant,
                                    )));
                          },
                          child: ProfesionalCard(consultant),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Center(child: loadingIndicator);
              }
            }),
      ),
    );
  }
}
