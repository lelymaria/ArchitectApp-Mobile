import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/responses/get_consultant_response.dart';
import 'package:architect_app/utils/dimension.dart';
import 'package:architect_app/widgets/rating.dart';
import 'package:flutter/material.dart';
import 'package:architect_app/utils/generals.dart';

class ProfesionalCard extends StatelessWidget {
  final DataConsultant consultant;

  ProfesionalCard(this.consultant);

  @override
  Widget build(BuildContext context) {
    var listProject = consultant.projects.where((element) => element.isLelang == "1");
    var ratingLength = listProject.where((element) => element.projectOwn[0].ratings != null).length;
    Dimension().init(context);
    return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Container(
              height: Dimension.blockSizeVertical * 30,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        consultant.projects.length > 0 &&
                                consultant.projects[0].images.length > 0
                            // ? "${'http://1803010.web.ti.polindra.ac.id/index.php/img/project/'}${consultant.projects[0].images[0].image}"
                            // : "http://1803010.web.ti.polindra.ac.id/index.php/img/project/desain1.jpg",
                            ? "${'${Generals.baseUrl}/img/project/'}${consultant.projects[0].images[0].image}"
                            : "${Generals.baseUrl}/img/project/desain1.jpg",
                      ),
                      fit: BoxFit.cover)),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: Dimension.blockSizeHorizontal * 12,
                      width: Dimension.blockSizeHorizontal * 12,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  // "${'http://1803010.web.ti.polindra.ac.id/index.php/img/avatar/'}${consultant.user.avatar}"),
                                  "${'${Generals.baseUrl}/img/avatar/'}${consultant.user.avatar}"),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    SizedBox(width: Dimension.safeBlockHorizontal * 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          consultant.user.name,
                          style: blackFontStyle2,
                        ),
                        if (listProject.length > 0 && ratingLength > 0)
                        Column(
                          children: [
                            SizedBox(height: 5),
                            _rating()
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ]),
            )
          ],
        ));
  }

  _rating() {
    var nilai = 0;
    var listProject = consultant.projects.where((element) => element.isLelang == "1");
    var ratings = listProject.where((element) => element.projectOwn[0].ratings != null);
    int ratingLength = ratings.length;
    ratings.forEach((e) {
        nilai += e.projectOwn[0].ratings.rating;
    });
    double nilairata = nilai / ratingLength;
    int average = nilairata.toInt();
    print(average);
    return Rating(average);
  }
}
