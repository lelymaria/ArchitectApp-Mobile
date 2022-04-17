import 'dart:convert';

import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/models/repositories/repository.dart';
import 'package:architect_app/models/responses/get_projects_response.dart';
import 'package:architect_app/utils/dimension.dart';
import 'package:architect_app/views/main_page.dart';
import 'package:architect_app/views/professional/all_consultant_project_detail.dart';
import 'package:architect_app/views/professional/upload_desain.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:architect_app/utils/generals.dart';
import 'package:http/http.dart' as http;

class AllConsultantProject extends StatefulWidget {
  @override
  _AllConsultantProjectState createState() => _AllConsultantProjectState();
}


class _AllConsultantProjectState extends State<AllConsultantProject> {

  final String url = 'http://192.168.42.231:8000/api/destroyproject';

  Repository _repository = Repository();
  AuthPreference _authPreference = AuthPreference();

  Future deleteProject(String konsultanId) async {
    String url = 'http://192.168.42.231:8000/api/destroyproject/' + konsultanId;

    var response = await http.delete(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    Dimension().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Desain Saya",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainPage(initialPage: 3)),
            );
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
          future: _repository.getAllProjectCons(_authPreference, "0"),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Project> projects = snapshot.data;
              if (projects.length > 0) {
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UploadDesain()));
                        },
                        child: Text("Unggah Desain"),
                        style: ElevatedButton.styleFrom(primary: Colors.amber),
                      ),
                      Expanded(
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
                                            AllConsultanProjectDetail(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (project.images.length > 0)
                                          Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            height:
                                                Dimension.blockSizeVertical *
                                                    25,
                                            width: double.infinity,
                                            child: Carousel(
                                              boxFit: BoxFit.cover,
                                              autoplay: false,
                                              dotSize: 3.0,
                                              dotBgColor: Colors.transparent,
                                              showIndicator: true,
                                              images: project.images
                                                  .map((e) => NetworkImage(
                                                      // "${'http://1803010.web.ti.polindra.ac.id/index.php/img/project/'}${e.image}"))
                                                      "${'${Generals.baseUrl}/img/project/'}${e.image}"))
                                                  .toList(),
                                            ),
                                          ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                project.title,
                                                style: blackFontStyle3.copyWith(
                                                    fontSize: 18),
                                              ),
                                            ),
                                            Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                        // onTap: (){
                                        // Navigator.push(context, MaterialPageRoute(builder: (contex) => EditProject(project: snapshot.data
                                        // ['data']
                                        // [index],)));
                                        // },
                                          child: const Icon(Icons.edit)),
                                        GestureDetector(
                                          onTap: (){
                                            deleteProject(snapshot.data['data'][index]['id'].toString()).then((value)
                                            {
                                              setState(() {});
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Product berhasil di hapus")));
                                            });
                                        },
                                          child: const Icon(Icons.delete)),
                                          ]
                                        ),
                                  ],
                                ),
                                            // if (project.isLelang == "0")
                                            //   Container(
                                            //       margin: EdgeInsets.only(
                                            //           right: 10, bottom: 10),
                                            //       padding: EdgeInsets.symmetric(
                                            //           horizontal: 10, vertical: 2),
                                            //       decoration: BoxDecoration(
                                            //           color: Colors.green,
                                            //           borderRadius:
                                            //               BorderRadius.circular(50)),
                                            //       child: Text(
                                            //         "Project",
                                            //         style: TextStyle(
                                            //             color: Colors.white,
                                            //             fontSize: 12),
                                            //       )),
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
                                        // Wrap(
                                        //   children: [
                                        //     if (project.hargaDesain != 0)
                                        //       Container(
                                        //           margin: EdgeInsets.only(
                                        //               right: 10, bottom: 10),
                                        //           padding: EdgeInsets.symmetric(
                                        //               horizontal: 10, vertical: 5),
                                        //           decoration: BoxDecoration(
                                        //               color: Colors.grey[300],
                                        //               borderRadius:
                                        //                   BorderRadius.circular(50)),
                                        //           child: Text("Desain 2D / 3D")),
                                        //     if (project.hargaRab != 0)
                                        //       Container(
                                        //           margin: EdgeInsets.only(
                                        //               right: 10, bottom: 10),
                                        //           padding: EdgeInsets.symmetric(
                                        //               horizontal: 10, vertical: 5),
                                        //           decoration: BoxDecoration(
                                        //               color: Colors.grey[300],
                                        //               borderRadius:
                                        //                   BorderRadius.circular(50)),
                                        //           child:
                                        //               Text("Rencana Anggaran Biaya")),
                                        //   ],
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                    child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UploadDesain()));
                  },
                  child: Text("Unggah Desain"),
                  style: ElevatedButton.styleFrom(primary: Colors.amber),
                ));
              }
            } else {
              return Center(child: loadingIndicator);
            }
          }),
    );
  }
}
