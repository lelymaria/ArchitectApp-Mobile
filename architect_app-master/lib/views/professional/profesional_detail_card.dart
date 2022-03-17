import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/responses/get_projects_response.dart';
import 'package:architect_app/utils/dimension.dart';
import 'package:flutter/material.dart';
import 'package:architect_app/utils/generals.dart';

class ProfesionalDetailCard extends StatelessWidget {
  // final Architecture architecture;
  final Project project;

  ProfesionalDetailCard(this.project);

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
                        // "${'http://1803010.web.ti.polindra.ac.id/index.php/img/project/'}${project.images[0].image}"
                        "${'${Generals.baseUrl}/img/project/'}${project.images[0].image}"
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
                      project.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "${project.images.length} Foto",
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
