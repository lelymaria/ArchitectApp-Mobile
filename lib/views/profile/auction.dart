import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/models/repositories/repository.dart';
import 'package:architect_app/models/responses/get_mylelang_response.dart';
import 'package:architect_app/utils/generals.dart';
import 'package:architect_app/views/main_page.dart';
import 'package:architect_app/views/profile/auction_detail.dart';
import 'package:flutter/material.dart';

class Auction extends StatefulWidget {
  @override
  _AuctionState createState() => _AuctionState();
}

class _AuctionState extends State<Auction> {
  AuthPreference _authPreference = AuthPreference();
  Repository _repository = Repository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Lelang Saya",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MainPage(initialPage: 3)),
              );
            },
          ),
          backgroundColor: Colors.white,
        ),
        body: FutureBuilder(
            future: _repository.getMyLelang(_authPreference),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length > 0) {
                  List<MyLelang> lelangs = snapshot.data;
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: lelangs.length,
                      itemBuilder: (context, index) {
                        MyLelang lelang = lelangs[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AuctionDetail(lelang)));
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
                                      lelang.title,
                                      style: blackFontStyle3.copyWith(
                                          fontSize: 18),
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
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 20),
                                    Wrap(
                                      children: [
                                        if (lelang.desain == "1")
                                          Container(
                                              margin: EdgeInsets.only(
                                                  right: 10, bottom: 10),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 5),
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child: Text("Desain")),
                                        if (lelang.rAB == "1")
                                          Container(
                                              margin: EdgeInsets.only(
                                                  right: 10, bottom: 10),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 5),
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child: Text(
                                                  "Rencana Anggaran Biaya")),
                                        if (lelang.kontraktor == "1")
                                          Container(
                                              margin: EdgeInsets.only(
                                                  right: 10, bottom: 10),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 5),
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child: Text("Kontraktor")),
                                      ],
                                    )
                                    // Wrap(
                                    //   children: lelang
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
                  return Center(child: Text("Belum ada lelang"));
                }
              } else {
                return Center(child: loadingIndicator);
              }
            }));
  }
}
