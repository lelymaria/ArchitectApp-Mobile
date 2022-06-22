import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/models/repositories/repository.dart';

import 'package:architect_app/models/responses/get_contractor_response.dart';
import 'package:architect_app/views/contractor/contractor_card.dart';
import 'package:architect_app/views/contractor/contractor_detail.dart';
import 'package:flutter/material.dart';

class ContractorScreen extends StatefulWidget {
  @override
  _ContractorScreenState createState() => _ContractorScreenState();
}

class _ContractorScreenState extends State<ContractorScreen> {
  Repository _repository = Repository();
  AuthPreference _authPreference = AuthPreference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: _repository.getContractorFromOwner(_authPreference),
            builder: (context, AsyncSnapshot snapshot) {
              // print(snapshot.data);
              if (snapshot.hasData) {
                List<DataContractor> contractors = snapshot.data;
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: ListView.builder(
                    itemCount: contractors.length,
                    itemBuilder: (context, index) {
                      DataContractor contractor = contractors[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ContractorDetail(
                                          contractor: contractor,
                                        )));
                          },
                          child: ContractorCard(contractor),
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
