import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/models/repositories/repository.dart';
import 'package:architect_app/utils/dimension.dart';
import 'package:architect_app/utils/generals.dart';
import 'package:architect_app/views/professional/proposal_detail.dart';
import 'package:flutter/material.dart';

class ProposalRejected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthPreference _authPreference = AuthPreference();
    Repository _repository = Repository();
    Dimension().init(context);
    return FutureBuilder(
      future: _repository.getAllProposal(_authPreference, 2),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Memuat data gagal"));
        } else if (snapshot.connectionState == ConnectionState.done) {
          var res = snapshot.data;
          if (res['data'].length > 0) {
            return SafeArea(
                child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimension.safeBlockHorizontal * 2,
                  vertical: Dimension.safeBlockVertical * 2),
              child: ListView.builder(
                  itemCount: res['data'].length,
                  itemBuilder: (context, index) {
                    var prop = res['data'][index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProposalDetail(data: prop)));
                      },
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                prop['lelang']['title'],
                                style: blackFontStyle3.copyWith(fontSize: 16),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "est. anggaran: ${Generals.formatRupiah(prop['lelang']['budgetFrom'])} - ${prop['lelang']['budgetTo']}",
                                style: blackFontStyle1.copyWith(fontSize: 13),
                              ),
                              SizedBox(height: 15),
                              Text(
                                prop['lelang']['description'],
                                style: blackFontStyle2,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 20),
                              Wrap(
                                children: [
                                  if (prop['lelang']['desain'] == "1")
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
                                  if (prop['lelang']['RAB'] == "1")
                                    Container(
                                        margin: EdgeInsets.only(
                                            right: 10, bottom: 10),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Text("Rencana Anggaran Biaya")),
                                  if (prop['lelang']['kontraktor'] == "1")
                                    Container(
                                        margin: EdgeInsets.only(
                                            right: 10, bottom: 10),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Text("Kontraktor")),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ));
          } else {
            return Center(child: Text("Tidak ada data"));
          }
        } else {
          return Center(child: loadingIndicator);
        }
      },
    );
  }
}
