import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/utils/dimension.dart';
import 'package:architect_app/views/profile/view_applicant_detail.dart';
import 'package:flutter/material.dart';

class ViewContractorApplocant extends StatefulWidget {
  @override
  _ViewContractorApplocantState createState() => _ViewContractorApplocantState();
}

class _ViewContractorApplocantState extends State<ViewContractorApplocant> {
  @override
  Widget build(BuildContext context) {
    Dimension().init(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: Dimension.safeBlockHorizontal * 1.5,
              vertical: Dimension.safeBlockVertical),
          child: ListView(
            children: [
              ApplicantCard(
                title: "Arya Contractor",
                description:
                    "Saya adalah konsultan berpengalaman untuk membangun rumah seperti ini",
              ),
              ApplicantCard(
                title: "Ilham Studio",
                description:
                    "Kami adalah konsultan berpengalaman untuk membangun rumah seperti ini",
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}

class ApplicantCard extends StatelessWidget {
  final String title;
  final String description;

  ApplicantCard({this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => ViewApplicantDetail(title, description)));
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: Dimension.safeBlockHorizontal * 2,
              vertical: Dimension.safeBlockHorizontal * 2),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: blackFontStyle3),
                        Text(
                          description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Pilih"),
                    style: ElevatedButton.styleFrom(primary: Colors.amber),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}