import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/models/repositories/repository.dart';
import 'package:architect_app/models/responses/get_consultant_response.dart';
import 'package:architect_app/views/home/professional_guest_card.dart';
import 'package:architect_app/views/professional/profesional_card.dart';
import 'package:architect_app/views/professional/profesional_detail.dart';
import 'package:flutter/material.dart';

class ProfesionalScreenGuest extends StatefulWidget {
  @override
  _ProfesionalScreenGuestState createState() => _ProfesionalScreenGuestState();
}

class _ProfesionalScreenGuestState extends State<ProfesionalScreenGuest> {
  Repository _repository = Repository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: _repository.getConsultantFromGuest(),
            builder: (context, AsyncSnapshot snapshot) {
              // print(snapshot.hasData);
              print(snapshot.data);
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
                                    ))
                                    );
                          },
                          child: ProfesionalGuestCard(consultant),
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
