import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/contractor_services.dart';
import 'package:architect_app/utils/dimension.dart';
import 'package:architect_app/utils/generals.dart';
import 'package:flutter/material.dart';

class ContractorProject extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Dimension().init(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimension.safeBlockHorizontal),
                child: Text("Proyek Saya",
                    style: blackFontStyle3.copyWith(fontSize: 20)),
              ),
              SizedBox(height: Dimension.safeBlockVertical * 2),
              Expanded(
                child: ListView(children: [
                  Card(
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mockContractorServices[0].title,
                            style: blackFontStyle3.copyWith(fontSize: 16),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "est. anggaran: ${Generals.formatRupiah(mockContractorServices[0].budget)}",
                            style: blackFontStyle1.copyWith(fontSize: 13),
                          ),
                          SizedBox(height: 15),
                          Text(
                            mockContractorServices[0].description,
                            style: blackFontStyle2,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
