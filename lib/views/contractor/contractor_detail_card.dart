import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/responses/get_cabangs_response.dart';
import 'package:architect_app/models/responses/get_projects_response.dart';
import 'package:architect_app/utils/dimension.dart';
import 'package:flutter/material.dart';
import 'package:architect_app/utils/generals.dart';

class ContractorDetailCard extends StatelessWidget {
  // final Architecture architecture;
  final Cabang cabang;

  ContractorDetailCard(this.cabang);

  @override
  Widget build(BuildContext context) {
    Dimension().init(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Container(
        width: Dimension.blockSizeHorizontal * 48,
        child: Column(
          children: [
            Container(
              height: Dimension.blockSizeVertical * 15,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        "${'${Generals.baseUrl}/img/cabang/profile/'}${cabang.images[0].image}"
                      ),
                      fit: BoxFit.cover)),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cabang.namaTim,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "${cabang.images.length} Foto",
                      style: blackFontStyle1.copyWith(
                          fontSize: Dimension.safeBlockHorizontal * 3),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
