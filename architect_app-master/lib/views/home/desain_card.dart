import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/responses/get_projects_response.dart';
import 'package:architect_app/utils/generals.dart';
import 'package:architect_app/views/home/desain_detail.dart';
import 'package:architect_app/widgets/rating.dart';
import 'package:flutter/material.dart';

class DesainCard extends StatelessWidget {
  final Project project;
  final double height;

  const DesainCard({@required this.project, this.height, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int lengthRating = project.projectOwn.where((element) => element.ratings != null).length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DesainDetail(
                          project: project,
                        )));
          },
          // child: ClipRRect(
          //   borderRadius: BorderRadius.circular(5),
          //   child: FadeInImage.memoryNetwork(
          //     placeholder: kTransparentImage,
          //     image: project.images[0],
          //     fit: BoxFit.cover,
          //     height: height,
          //     width: double.infinity,
          //   ),
          // ),
          child: Container(
            width: double.infinity,
            height: height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      // "${'http://1803010.web.ti.polindra.ac.id/index.php/img/project/'}${project.images[0].image}",
                      "${'${Generals.baseUrl}/img/project/'}${project.images[0].image}",
                    ),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(5)),
          ),
        ),
        // buildInfo(context)
        SizedBox(height: 4),
        Text(
          project.title,
          style: blackFontStyle2,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        // SizedBox(height: 4),
        Text(
          project.konsultan.user.name,
          style: blackFontStyle1.copyWith(fontSize: 12),
        ),
        if (project.projectOwn.length > 0 &&
            lengthRating > 0)
          _rating()
      ],
    );
  }

  _rating() {
    var nilai = 0;
    int lengthRating = project.projectOwn.where((element) => element.ratings != null).length;
    project.projectOwn.where((element) => element.ratings != null).forEach((e) {
        nilai += e.ratings.rating;
    });
    double nilairata = nilai / lengthRating;
    int average = nilairata.toInt();
    return Row(
      children: [
        Rating(average),
        Text(" $average ($lengthRating)", style: blackFontStyle1.copyWith(fontSize: 12))
      ],
    );
  }

//   Widget buildInfo(BuildContext context) => Container(
//         margin: EdgeInsets.symmetric(horizontal: 8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 4),
//             Text(
//               project.title,
//               style: blackFontStyle2,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//             // SizedBox(height: 4),
//             Text(
//               project.konsultan.user.name,
//               style: blackFontStyle1.copyWith(fontSize: 12),
//             ),
//             if (project.projectOwn.length > 0 &&
//                 project.projectOwn[0].ratings != null)
//               Rating(average)
//           ],
//         ),
//       );
}
