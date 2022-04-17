import 'package:architect_app/models/responses/get_projects_response.dart';
import 'package:architect_app/utils/dimension.dart';
import 'package:architect_app/views/home/desain_detail.dart';
import 'package:flutter/material.dart';
import 'package:architect_app/views/professional/profesional_detail_card.dart';

class ProfesionalProjects extends StatelessWidget {
  final List<Project> projects;
  ProfesionalProjects({this.projects});

  @override
  Widget build(BuildContext context) {
    Dimension().init(context);
    var size = MediaQuery.of(context).size;
    final double itemHeight = Dimension.blockSizeVertical * 33;
    final double itemWidth = size.width / 2;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Semua Project",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: itemWidth / itemHeight,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          children: projects
              .map(
                (e) => SafeArea(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DesainDetail(project: e)));
                    },
                    child: ProfesionalDetailCard(e),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
