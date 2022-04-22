import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/responses/get_projects_response.dart';
// import 'package:architect_app/views/admin/image_view_screen.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:architect_app/utils/generals.dart';

class AllConsultanProjectDetail extends StatelessWidget {
  final Project project;
  AllConsultanProjectDetail({this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          project.title,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: Colors.amber[300],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(children: [
        Column(children: [
          if (project.images.length > 0)
            Container(
              height: 250,
              width: double.infinity,
              child: Carousel(
                boxFit: BoxFit.cover,
                autoplay: false,
                dotSize: 3.0,
                dotBgColor: Colors.transparent,
                showIndicator: true,
                images: project.images.map((e) => NetworkImage(
                    // "${'http://1803010.web.ti.polindra.ac.id/index.php/img/project/'}${e.image}")).toList()
                    "${'${Generals.baseUrl}/img/project/'}${e.image}")).toList(),
              ),
            ),
          SizedBox(height: 5),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.title,
                  style: blackFontStyle3.copyWith(fontSize: 18),
                ),
                SizedBox(height: 20),
                Text(
                  project.description,
                  style: blackFontStyle1,
                ),
              ],
            ),
          ),
        ]),
      ]),
    );
  }
}
