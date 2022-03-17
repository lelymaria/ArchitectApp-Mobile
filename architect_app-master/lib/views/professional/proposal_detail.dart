import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/utils/dimension.dart';
import 'package:architect_app/utils/generals.dart';
import 'package:architect_app/views/admin/doc_view_screen.dart';
import 'package:architect_app/views/admin/image_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProposalDetail extends StatelessWidget {
  final dynamic data;
  ProposalDetail({this.data});

  @override
  Widget build(BuildContext context) {
    Dimension().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Proposal Detail",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: Dimension.safeBlockVertical * 2,
              horizontal: Dimension.safeBlockHorizontal * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data['coverLetter'], style: blackFontStyle1),
              if (data['tawaranHargaDesain'] != 0)
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Tawaran Harga Desain",
                          style: blackFontStyle1,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          Generals.formatRupiah(data['tawaranHargaDesain']),
                          style: blackFontStyle3,
                        ),
                      ),
                    ],
                  ),
                ),
              if (data['tawaranHargaRab'] != 0)
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Tawaran Harga RAB",
                          style: blackFontStyle1,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          Generals.formatRupiah(data['tawaranHargaRab']),
                          style: blackFontStyle3,
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: () {
                  var ext = data['cv'].split(".")[1];
                  if (Generals.listFormatImage.contains(ext)) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImageViewScreen(
                              // imageUrl:
                              //     "${'http://1803010.web.ti.polindra.ac.id/index.php/img/tender/konsultan/cv/'}${data['cv']}")),
                              imageUrl:
                                  "${'${Generals.baseUrl}/img/tender/konsultan/cv/'}${data['cv']}")),
                    );
                  } else if (Generals.listFormatPdf.contains(ext)) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DocViewScreen(
                              // remotePDF:
                              //     "${'http://1803010.web.ti.polindra.ac.id/index.php/img/tender/konsultan/cv/'}${data['cv']}")),
                              remotePDF:
                                  "${'${Generals.baseUrl}/img/tender/konsultan/cv/'}${data['cv']}")),
                    );
                  }
                },
                icon: Icon(FontAwesomeIcons.book),
                label: Text("Lihat CV"),
                style: ElevatedButton.styleFrom(primary: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
