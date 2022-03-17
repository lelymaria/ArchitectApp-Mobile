import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/responses/get_projects_response.dart';
import 'package:architect_app/widgets/rating.dart';
import 'package:flutter/material.dart';

class ProfesionalProjectDetail extends StatelessWidget {
  final Project project;
  ProfesionalProjectDetail({this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          project.title,
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
                          project.title,
                          style: blackFontStyle3.copyWith(fontSize: 18),
                        ),
                        SizedBox(height: 5),
                        if (project.projectOwn[0].ratings != null)
                          Rating(project.projectOwn[0].ratings.rating),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                project.description,
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
                  Expanded(
                    flex: 1,
                    child: Text(
                      project.projectOwn[0].owner.user.name,
                      style: blackFontStyle3,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Gaya Desain",
                      style: blackFontStyle1,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      project.gayaDesain,
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
