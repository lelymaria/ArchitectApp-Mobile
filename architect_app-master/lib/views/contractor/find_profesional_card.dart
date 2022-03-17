import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/contractor_services.dart';
import 'package:flutter/material.dart';
import 'package:architect_app/utils/generals.dart';

class FindProfesionalCard extends StatelessWidget {
  final ContractorServices services;

  FindProfesionalCard(this.services);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              services.title,
              style: blackFontStyle3.copyWith(fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              "est. anggaran: ${Generals.formatRupiah(services.budget)}",
              style: blackFontStyle1.copyWith(fontSize: 13),
            ),
            SizedBox(height: 15),
            Text(
              services.description,
              style: blackFontStyle2,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}