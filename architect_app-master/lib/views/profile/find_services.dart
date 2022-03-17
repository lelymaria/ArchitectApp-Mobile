import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/models/repositories/repository.dart';
import 'package:architect_app/models/responses/get_mylelang_response.dart';
import 'package:architect_app/models/responses/login_response.dart';
import 'package:architect_app/utils/dimension.dart';
import 'package:architect_app/utils/generals.dart';
import 'package:architect_app/views/profile/find_services_detail.dart';
import 'package:flutter/material.dart';

class FindServices extends StatefulWidget {
  @override
  _FindServicesState createState() => _FindServicesState();
}

class _FindServicesState extends State<FindServices> {
  AuthPreference _authPreference = AuthPreference();
  Repository _repository = Repository();
  User _user;

  _initialize() async {
    var data = await _authPreference.getUserData();
    setState(() {
      _user = data;
    });
  }

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Dimension().init(context);
    return Scaffold(
        body: SafeArea(
      child: FutureBuilder(
          future: Future.wait([
            _repository.getLelangOwner(_authPreference),
            _authPreference.getUserData()
          ]),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<MyLelang> lelangs = snapshot.data[0];
              _user = snapshot.data[1];
              return Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimension.safeBlockHorizontal * 2,
                    vertical: Dimension.safeBlockVertical * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimension.safeBlockHorizontal),
                      child: Text("Lelang Owner",
                          style: blackFontStyle3.copyWith(fontSize: 20)),
                    ),
                    SizedBox(height: Dimension.safeBlockVertical * 2),
                    lelangs.length > 0
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: lelangs.length,
                              physics: ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                MyLelang lelang = lelangs[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FindServicesDetail(lelang, _user)));
                                  },
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            lelang.title,
                                            style: blackFontStyle3.copyWith(
                                                fontSize: 16),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            "est. anggaran: ${Generals.formatRupiah(lelang.budgetFrom)} - ${lelang.budgetTo}",
                                            style: blackFontStyle1.copyWith(
                                                fontSize: 13),
                                          ),
                                          SizedBox(height: 15),
                                          Text(
                                            lelang.description,
                                            style: blackFontStyle2,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 20),
                                          Wrap(
                                            children: [
                                              if (lelang.desain == "1")
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        right: 10, bottom: 10),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 5),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[300],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)),
                                                    child:
                                                        Text("Desain")),
                                              if (lelang.rAB == "1")
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        right: 10, bottom: 10),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 5),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[300],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)),
                                                    child: Text(
                                                        "Rencana Anggaran Biaya")),
                                              if (lelang.kontraktor == "1")
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        right: 10, bottom: 10),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 5),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[300],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)),
                                                    child: Text("Kontraktor")),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(
                                top: Dimension.safeBlockVertical * 35),
                            child: Center(child: Text("Tidak ada lelang")),
                          ),
                  ],
                ),
              );
            } else {
              return Center(child: loadingIndicator);
            }
          }),
    ));
  }
}
