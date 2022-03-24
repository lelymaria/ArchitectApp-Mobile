import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/contractor_services.dart';
import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/utils/dimension.dart';
import 'package:architect_app/views/contractor/find_profesional_card.dart';
import 'package:architect_app/views/contractor/find_profesional_detail.dart';
import 'package:flutter/material.dart';

class FindProfesional extends StatefulWidget {
  @override
  _FindProfesionalState createState() => _FindProfesionalState();
}

class _FindProfesionalState extends State<FindProfesional> {
  AuthPreference _authPreference = AuthPreference();
  @override
  Widget build(BuildContext context) {
    Dimension().init(context);
    return Scaffold(
        body: FutureBuilder(
            future: _authPreference.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SafeArea(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimension.safeBlockHorizontal * 2,
                        vertical: Dimension.safeBlockVertical * 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: Dimension.safeBlockHorizontal),
                          child: Text("Lelang Konsultan",
                              style: blackFontStyle3.copyWith(fontSize: 20)),
                        ),
                        SizedBox(height: Dimension.safeBlockVertical * 2),
                        Expanded(
                          child: ListView(
                            children: mockContractorServices
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FindProfesionalDetail(
                                                        e, snapshot.data)));
                                      },
                                      child: FindProfesionalCard(e),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Center(child: loadingIndicator);
              }
            }));
  }
}
