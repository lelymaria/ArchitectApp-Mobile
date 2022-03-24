import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/models/repositories/repository.dart';
import 'package:architect_app/views/main_page.dart';
import 'package:architect_app/views/profile/project_owner_detail.dart';
import 'package:flutter/material.dart';

class ProjectsOwner extends StatefulWidget {
  @override
  _ProjectsOwnerState createState() => _ProjectsOwnerState();
}

class _ProjectsOwnerState extends State<ProjectsOwner> {
  AuthPreference _authPreference = AuthPreference();
  Repository _repository = Repository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Project Saya",
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
          future: _repository.getMyProject(_authPreference),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var res = snapshot.data;
              if (res['data'].length > 0) {
                // List<MyProject> projects = snapshot.data;
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: res['data'].length,
                    itemBuilder: (context, index) {
                      var project = res['data'][index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProjectOwnerDetail(project: project)));
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
                                  Text(
                                    project['project']['title'],
                                    style:
                                        blackFontStyle3.copyWith(fontSize: 18),
                                  ),
                                  // SizedBox(height: 5),
                                  // Text(
                                  //   "Biaya: ${Generals.formatRupiah(total)}",
                                  //   style:
                                  //       blackFontStyle1.copyWith(fontSize: 13),
                                  // ),
                                  SizedBox(height: 15),
                                  Text(
                                    project['project']['description'],
                                    style: blackFontStyle2,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 20),
                                  project['choose_project'] == null ?
                                  Wrap(
                                    children: [
                                      if (project['project']['harga_desain'] != 0)
                                        Container(
                                            margin: EdgeInsets.only(
                                                right: 10, bottom: 10),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: Text("Desain")),
                                      if (project['project']['harga_rab'] != 0)
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
                                  ) :
                                  Wrap(
                                    children: [
                                      if (project['choose_project']['desain'] != "0")
                                        Container(
                                            margin: EdgeInsets.only(
                                                right: 10, bottom: 10),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: Text("Desain")),
                                      if (project['choose_project']['RAB'] != "0")
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
                                  // Wrap(
                                  //   children: project
                                  //       .category
                                  //       .map((item) => Container(
                                  //             margin: EdgeInsets.only(
                                  //                 right: 10, bottom: 10),
                                  //             padding: EdgeInsets.symmetric(
                                  //                 horizontal: 10, vertical: 5),
                                  //             decoration: BoxDecoration(
                                  //                 color: Colors.grey[300],
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(50)),
                                  //             child: Text(item),
                                  //           ))
                                  //       .toList(),
                                  // )
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
                return Center(child: Text("Belum ada project"));
              }
            } else {
              return Center(child: loadingIndicator);
            }
          }),
    );
  }
}
