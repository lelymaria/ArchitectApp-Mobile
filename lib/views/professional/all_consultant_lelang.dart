import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/models/repositories/repository.dart';
import 'package:architect_app/models/responses/get_projects_response.dart';
import 'package:architect_app/utils/dimension.dart';
import 'package:architect_app/views/professional/all_consultant_lelang_detail.dart';
import 'package:architect_app/views/professional/all_consultant_project_detail.dart';
import 'package:flutter/material.dart';

class AllConsultantLelang extends StatefulWidget {
  @override
  _AllConsultantLelangState createState() => _AllConsultantLelangState();
}

class _AllConsultantLelangState extends State<AllConsultantLelang> {
  Repository _repository = Repository();
  AuthPreference _authPreference = AuthPreference();

  @override
  Widget build(BuildContext context) {
    Dimension().init(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Project Saya",
      //     style: TextStyle(color: Colors.black, fontSize: 16),
      //   ),
      //   leading: new IconButton(
      //     icon: new Icon(Icons.arrow_back, color: Colors.black),
      //     onPressed: () {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => MainPage(initialPage: 3)),
      //       );
      //     },
      //   ),
      //   backgroundColor: Colors.white,
      // ),
      body: FutureBuilder(
          future: _repository.getAllProjectCons(_authPreference, "1"),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Project> projects = snapshot.data;
              if (projects.length > 0) {
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: projects.length,
                    itemBuilder: (context, index) {
                      Project project = projects[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AllConsultanLelangDetail(
                                          project: project)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            elevation: 2,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          project.title,
                                          style: blackFontStyle3.copyWith(
                                              fontSize: 18),
                                        ),
                                      ),
                                      if (project.isLelang == "0")
                                        Container(
                                            margin: EdgeInsets.only(
                                                right: 10, bottom: 10),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 2),
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: Text(
                                              "Project",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            )),
                                    ],
                                  ),
                                  // SizedBox(height: 5),
                                  // Text(
                                  //   "Biaya: ${Generals.formatRupiah(total)}",
                                  //   style:
                                  //       blackFontStyle1.copyWith(fontSize: 13),
                                  // ),
                                  SizedBox(height: 15),
                                  Text(
                                    project.description,
                                    style: blackFontStyle2,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 15),
                                  Wrap(
                                    children: [
                                      if (project.hargaDesain != 0)
                                        Container(
                                            margin: EdgeInsets.only(
                                                right: 10, bottom: 10),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: Text("Desain 2D / 3D")),
                                      if (project.hargaRab != 0)
                                        Container(
                                            margin: EdgeInsets.only(
                                                right: 10, bottom: 10),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child:
                                                Text("Rencana Anggaran Biaya")),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Center(child: Text("Belum ada lelang"));
              }
            } else {
              return Center(child: loadingIndicator);
            }
          }),
    );
  }
}
