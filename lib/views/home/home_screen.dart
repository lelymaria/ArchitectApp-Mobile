import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/forms/lelang_form.dart';
import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/models/repositories/repository.dart';
import 'package:architect_app/models/responses/get_projects_response.dart';
import 'package:architect_app/utils/dimension.dart';
import 'package:architect_app/views/home/desain_card.dart';
import 'package:architect_app/views/home/form/first_screen.dart';
// import 'package:architect_app/widgets/select_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Repository _repository = Repository();
  AuthPreference _authPreference = AuthPreference();
  List<Project> _listProject;

  // static List<String> _style = [
  //   "Minimalist",
  //   "Modern",
  //   "Traditional",
  //   "Scandinavian"
  // ];
  // static Map<String, int> _styleId = {
  //   "Minimalist": 1,
  //   "Modern": 2,
  //   "Traditional": 3,
  //   "Scandinavian": 4,
  // };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Dimension().init(context);
    return Scaffold(
        body: FutureBuilder(
            future: _repository.getProjects(_authPreference),
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
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Text("Home",
            //         style: blackFontStyle2.copyWith(
            //             fontSize: Dimension.blockSizeVertical * 3)),
            //     Container(
            //       height: Dimension.blockSizeVertical * 5.5,
            //       margin: EdgeInsets.only(top: Dimension.blockSizeVertical),
            //       child: Directionality(
            //         textDirection: TextDirection.ltr,
            //         child: ElevatedButton.icon(
            //           onPressed: () {
            //             _showFilter();
            //           },
            //           icon: Icon(Icons.sort_outlined),
            //           label: Text("Filter"),
            //           style: ElevatedButton.styleFrom(
            //               primary: Colors.white,
            //               onPrimary: Colors.amber,
            //               side: BorderSide(color: Colors.amber)),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
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
                                          FirstScreen(form: lelangForm)));
                            },
                            child: Text(
                              "Mulai",
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
                            return DesainCard(
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

  // _showFilter() {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (builder) {
  //       var screenHeight = MediaQuery.of(context).size.height;
  //       return Stack(
  //         children: [
  //           Container(
  //             height: screenHeight * 0.8,
  //             color: Colors.white,
  //             padding: EdgeInsets.all(Dimension.safeBlockHorizontal * 4),
  //             child: Column(
  //               children: [
  //                 Expanded(
  //                   child: ListView(
  //                     shrinkWrap: true,
  //                     children: [
  //                       Text("Gaya Desain",
  //                           style: blackFontStyle3.copyWith(fontSize: 16)),
  //                       SelectChip(
  //                         _style,
  //                         selectedChoice: param.style != null
  //                             ? _style[param.style - 1]
  //                             : null,
  //                         onSelectionChanged: (selectedList) {
  //                           setState(() {
  //                             param.style = _styleId[selectedList];
  //                           });
  //                         },
  //                       ),
  //                       SizedBox(height: 10),
  //                       Text("Tipe Property",
  //                           style: blackFontStyle3.copyWith(fontSize: 16)),
  //                       SelectChip(
  //                         _property,
  //                         selectedChoice: param.property != null
  //                             ? _property[param.property - 1]
  //                             : null,
  //                         onSelectionChanged: (selectedList) {
  //                           setState(() {
  //                             param.property = _propertyId[selectedList];
  //                           });
  //                         },
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Align(
  //             alignment: Alignment.bottomCenter,
  //             child: Container(
  //               padding: EdgeInsets.symmetric(
  //                   horizontal: Dimension.safeBlockHorizontal * 4),
  //               child: Row(
  //                 children: [
  //                   Expanded(
  //                     child: ElevatedButton(
  //                       onPressed: () {},
  //                       child: Text("Reset"),
  //                       style: ElevatedButton.styleFrom(
  //                           primary: Colors.white, onPrimary: Colors.black),
  //                     ),
  //                   ),
  //                   SizedBox(width: Dimension.safeBlockHorizontal * 2),
  //                   Expanded(
  //                     child: ElevatedButton(
  //                       onPressed: () {
  //                         Navigator.pop(context, true);
  //                         _onFilterClicked();
  //                       },
  //                       child: Text("Terapkan Filter"),
  //                       style: ElevatedButton.styleFrom(primary: Colors.amber),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // _onFilterClicked() {
  //   _listDesain.clear();
  //   _desainBloc.add(DesainLoad(param: param));
  // }
}
