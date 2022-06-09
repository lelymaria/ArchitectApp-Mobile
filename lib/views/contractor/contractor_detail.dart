import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/models/responses/get_cabangs_response.dart';
import 'package:architect_app/models/responses/get_contractor_response.dart';
import 'package:architect_app/models/responses/get_contractor_response.dart';
import 'package:architect_app/models/responses/get_projects_response.dart';
import 'package:architect_app/models/responses/login_response.dart';
import 'package:architect_app/utils/dimension.dart';
import 'package:architect_app/views/chat/chat_screen.dart';
import 'package:architect_app/views/contractor/contractor_cabang_detail.dart';
import 'package:architect_app/views/contractor/contractor_detail_card.dart';
import 'package:architect_app/views/home/cabang_detail.dart';
import 'package:architect_app/views/home/desain_detail.dart';
import 'package:architect_app/views/professional/profesional_detail_card.dart';
import 'package:architect_app/views/professional/profesional_project_detail.dart';
import 'package:architect_app/views/professional/profesional_projects.dart';
import 'package:architect_app/widgets/rating.dart';
import 'package:flutter/material.dart';
import 'package:architect_app/utils/generals.dart';

class ContractorDetail extends StatefulWidget {
  // final Profesional profesional;
  final DataContractor contractor;

  ContractorDetail({this.contractor});

  @override
  _ContractorDetailState createState() => _ContractorDetailState();
}

class _ContractorDetailState extends State<ContractorDetail> {
  User _user;
  AuthPreference _authPreference = AuthPreference();

  _initialize() async {
    var user = await _authPreference.getUserData();
    setState(() {
      _user = user;
    });
  }

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  @override

  Widget build(BuildContext context) {
    var listCabang =
        widget.contractor.cabangs.where((element) => element.isLelang == "0");
    var listProject =
        widget.contractor.cabangs.where((element) => element.isLelang == "1");
    // var ratingLength = listProject
    //     .where((element) => element.cabangOwn[0].ratings != null)
    //     .length;
    Dimension().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.contractor.user.name,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Stack(children: [
        // Container(color: Colors.white),
        // SafeArea(
        //     child: Container(
        //   color: Colors.white,
        // )),
        SafeArea(
          child: Container(
            width: double.infinity,
            height: Dimension.blockSizeVertical * 35,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      widget.contractor.cabangs.length > 0 &&
                              widget.contractor.cabangs[0].images.length > 0
                          // ? "${'http://1803010.web.ti.polindra.ac.id/index.php/img/project/'}${widget.contractor.cabang[0].images[0].image}"
                          // : "http://1803010.web.ti.polindra.ac.id/index.php/img/project/desain1.jpg",
                          ? "${'${Generals.baseUrl}/img/cabang/profile/'}${widget.contractor.cabangs[0].images[0].image}"
                          : "${Generals.baseUrl}/img/cabang/profile/desain1.jpg",
                    ),
                    fit: BoxFit.cover)),
          ),
        ),
        SafeArea(
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    margin:
                        EdgeInsets.only(top: Dimension.blockSizeVertical * 30),
                    padding: EdgeInsets.all(Dimension.safeBlockHorizontal * 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12)),
                        color: Colors.white),
                    child: Column(children: [
                      Row(
                        children: [
                          Container(
                            width: Dimension.blockSizeHorizontal * 12,
                            height: Dimension.blockSizeHorizontal * 12,
                            decoration: BoxDecoration(
                                // shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        // "${'http://1803010.web.ti.polindra.ac.id/index.php/img/avatar/'}${widget.contractor.user.avatar}"),
                                        "${'${Generals.baseUrl}/img/avatar/'}${widget.contractor.user.avatar}"),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(100)),
                          ),
                          SizedBox(width: Dimension.safeBlockHorizontal * 5),
                          // Expanded(
                          //   child: Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         Text(
                          //           widget.contractor.user.name,
                          //           style: blackFontStyle2,
                          //         ),
                          //         if (listCabang.length > 0 &&
                          //             ratingLength > 0)
                          //           Column(
                          //             children: [
                          //               SizedBox(
                          //                   height:
                          //                       Dimension.safeBlockVertical),
                          //               _rating()
                          //             ],
                          //           ),
                          //       ]),
                          // ),
                          GestureDetector(
                            onTap: () {
                              _createRoomAndStartConversation(
                                  widget.contractor.user.username);
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.amber[100]),
                              child: Icon(
                                Icons.messenger_rounded,
                                color: Colors.amber,
                                size: Dimension.safeBlockHorizontal * 5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (widget.contractor.cabangs.length > 0)
                        // widget.contractor.cabang[0].images.length > 0),
                        Column(
                          children: [
                            SizedBox(height: Dimension.safeBlockVertical * 4),
                            Container(
                              // padding: EdgeInsets.symmetric(
                              //     horizontal:
                              //         Dimension.safeBlockHorizontal * 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("${listCabang.length} Cabang"),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //             builder: (context) => Profesionalcabang(
                                  //                 cabang: widget.contractor.cabang.where((element) => element.isLelang == "0").toList())));
                                  //   },
                                  //   child: Text(
                                  //     "Lihat Semua",
                                  //     style: TextStyle(color: Colors.amber),
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                            SizedBox(height: Dimension.safeBlockVertical),
                            Container(
                              width: double.infinity,
                              height: Dimension.blockSizeVertical * 30,
                              // padding: EdgeInsets.symmetric(
                              //     horizontal:
                              //         Dimension.safeBlockHorizontal * 3),
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: listCabang.length,
                                  itemBuilder: (context, index) {
                                    Cabang cabang =
                                        listCabang.toList()[index];
                                    // Project project = widget.contractor.cabang[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CabangDetail(
                                                        cabang: cabang)));
                                      },
                                      child: ContractorDetailCard(cabang),
                                    );
                                  }),
                            ),
                            if (listCabang.length > 0)
                              Column(
                                children: [
                                  SizedBox(
                                      height: Dimension.safeBlockVertical * 2),
                                  Container(
                                    // padding: EdgeInsets.symmetric(
                                    //     horizontal:
                                    //         Dimension.safeBlockHorizontal * 4),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("${listCabang.length} Cabang"),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: Dimension.safeBlockVertical),
                                  Container(
                                    width: double.infinity,
                                    height: Dimension.blockSizeVertical * 25,
                                    // padding: EdgeInsets.symmetric(
                                    //     horizontal:
                                    //         Dimension.safeBlockHorizontal * 3),
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: listCabang.length,
                                        itemBuilder: (context, index) {
                                          Cabang cabang =
                                              listCabang.toList()[index];
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ContractorCabangDetail(
                                                            cabang: cabang,
                                                          )));
                                            },
                                            child: Card(
                                              clipBehavior: Clip.antiAlias,
                                              child: Container(
                                                width: Dimension
                                                        .blockSizeHorizontal *
                                                    48,
                                                padding: EdgeInsets.all(10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(cabang.namaTim,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: blackFontStyle3),
                                                    // SizedBox(
                                                    //     height: Dimension
                                                    //         .safeBlockVertical),
                                                    // if (cabang.cabangOwn[0]
                                                    //         .ratings !=
                                                    //     null)
                                                    //   Rating(cabang
                                                    //       .cabangOwn[0]
                                                    //       .ratings
                                                    //       .rating),
                                                    SizedBox(
                                                        height: Dimension
                                                            .safeBlockVertical),
                                                    Text(cabang.description,
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: blackFontStyle1
                                                            .copyWith(
                                                                fontSize: Dimension
                                                                        .safeBlockHorizontal *
                                                                    3)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              )
                          ],
                        ),
                      Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Tentang",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 10),
                            Text(widget.contractor.about ?? "-"),
                            SizedBox(height: 15),
                            Text("Website",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 10),
                            Text(widget.contractor.website ?? "-"),
                            SizedBox(height: 15),
                            Text("Telepon",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 10),
                            Text(widget.contractor.telepon ?? "-")
                          ],
                        ),
                      )
                    ]
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
  


  _createRoomAndStartConversation(String username) {
    String chatRoomId = _getChatRoomId(_user.username, username);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ChatScreen(chatRoomId, widget.contractor.user.username)));
  }

  _getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  // _rating() {
  //   var nilai = 0;
  //   var listCabang =
  //       widget.contractor.cabangs.where((element) => element.isLelang == "1");
  //   var ratings =
  //       listCabang.where((element) => element.cabangOwn[0].ratings != null);
  //   int ratingLength = ratings.length;
  //   ratings.forEach((e) {
  //     nilai += e.cabangOwn[0].ratings.rating;
  //   });
  //   double nilairata = nilai / ratingLength;
  //   int average = nilairata.toInt();
  //   print(average);
  //   return Rating(average);
  // }

}