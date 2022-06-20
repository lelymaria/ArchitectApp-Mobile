import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/forms/lelang_form.dart';
import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/models/repositories/repository.dart';
import 'package:architect_app/models/responses/get_project_guest.dart';
import 'package:architect_app/models/responses/get_projects_response.dart';
import 'package:architect_app/utils/dimension.dart';
import 'package:architect_app/views/auth/sign_in_screen.dart';
import 'package:architect_app/views/home/desain_card.dart';
import 'package:architect_app/views/home/desain_guest_card.dart';
import 'package:architect_app/views/home/form/first_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreenGuest extends StatefulWidget {
  @override
  State<HomeScreenGuest> createState() => _HomeScreenGuestState();
}

class _HomeScreenGuestState extends State<HomeScreenGuest> {
  Repository _repository = Repository();
  List<Project> _listProject;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Dimension().init(context);
    return Scaffold(
        body: FutureBuilder<List<Project>>(
            future: _repository.getProject(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _listProject = snapshot.data;
                return _buildContent(context, _listProject);
              } else {
                return Center(child: loadingIndicator);
              }
            }));
  }

  Widget _buildContent(BuildContext context, _listProject) {
    final lelangForm = new LelangForm(null, null, null, null, null, null, null,
        null, null, null, null, null, null);
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(right: 12, left: 12),
        child: Column(
          children: [
            
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Cari desain sesuai dengan kebutuhan anda",
                            style: blackFontStyle3.copyWith(fontSize: 20),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SignInScreen()));
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(fontSize: 18),
                            ),
                            style:
                                ElevatedButton.styleFrom(primary: Colors.amber),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  _listProject.length > 0
                      ? StaggeredGridView.countBuilder(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 20,
                          itemCount: _listProject.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            Project projects = _listProject[index];
                            return DesainGuestCard(
                                project: projects,
                                height: index % 4 == 0
                                    ? Dimension.blockSizeVertical * 43
                                    : Dimension.blockSizeVertical * 30);
                          },
                          staggeredTileBuilder: (index) {
                            // return new StaggeredTile.count(1, index.isEven ? 1.2 : 1.5);
                            return new StaggeredTile.fit(1);
                          },
                        )
                      : Padding(
                          padding: EdgeInsets.only(
                              top: Dimension.safeBlockVertical * 25),
                          child: Center(
                            child: Text("Tidak ada data"),
                          ),
                        )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
