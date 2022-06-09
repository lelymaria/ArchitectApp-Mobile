import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/responses/get_cabangs_response.dart';
import 'package:architect_app/models/responses/get_projects_response.dart';
import 'package:architect_app/widgets/rating.dart';
import 'package:flutter/material.dart';

class ContractorCabangDetail extends StatelessWidget {
  final Cabang cabang;
  ContractorCabangDetail({this.cabang});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          cabang.namaTim,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cabang.namaTim,
                          style: blackFontStyle3.copyWith(fontSize: 18),
                        ),
                        // SizedBox(height: 5),
                        // if (cabang.cabangOwn[0].ratings != null)
                        //   Rating(cabang.cabangOwn[0].ratings.rating),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                cabang.description,
                style: blackFontStyle1,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Client",
                      style: blackFontStyle1,
                    ),
                  ),
                  // Expanded(
                  //   flex: 1,
                  //   child: Text(
                  //     cabang.cabangOwn[0].owner.user.name,
                  //     style: blackFontStyle3,
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Jumlah Tim",
                      style: blackFontStyle1,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      cabang.jumlahTim.toString(),
                      style: blackFontStyle3,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ]),
    );
  }
}
