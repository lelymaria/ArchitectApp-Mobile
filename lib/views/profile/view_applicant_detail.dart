import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/responses/get_proposal_response.dart';
import 'package:architect_app/utils/dimension.dart';
import 'package:architect_app/utils/generals.dart';
import 'package:architect_app/views/admin/doc_view_screen.dart';
import 'package:architect_app/views/admin/image_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ViewApplicantDetail extends StatefulWidget {
  final DataProposal proposal;

  ViewApplicantDetail({this.proposal});

  @override
  _ViewApplicantDetailState createState() => _ViewApplicantDetailState();
}

class _ViewApplicantDetailState extends State<ViewApplicantDetail> {
  @override
  Widget build(BuildContext context) {
    Dimension().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail pendaftar",
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
              Text(widget.proposal.konsultan.user.name,
                  style: blackFontStyle3.copyWith(fontSize: 20)),
              SizedBox(height: 10),
              Text(widget.proposal.coverLetter, style: blackFontStyle1),
              if (widget.proposal.tawaranHargaDesain != 0)
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
                        Generals.formatRupiah(widget.proposal.tawaranHargaDesain),
                        style: blackFontStyle3,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.proposal.tawaranHargaRab != 0)
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
                        Generals.formatRupiah(widget.proposal.tawaranHargaRab),
                        style: blackFontStyle3,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: () {
                  var ext = widget.proposal.cv.split(".")[1];
                  if (Generals.listFormatImage.contains(ext)) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImageViewScreen(
                              // imageUrl:
                              //     "${'http://1803010.web.ti.polindra.ac.id/index.php/img/tender/konsultan/cv/'}${widget.proposal.cv}")),
                              imageUrl:
                                  "${'${Generals.baseUrl}/img/tender/konsultan/cv/'}${widget.proposal.cv}")),
                    );
                  } else if (Generals.listFormatPdf.contains(ext)) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DocViewScreen(
                              // remotePDF:
                              //     "${'http://1803010.web.ti.polindra.ac.id/index.php/img/tender/konsultan/cv/'}${widget.proposal.cv}")),
                              remotePDF:
                                  "${'${Generals.baseUrl}/img/tender/konsultan/cv/'}${widget.proposal.cv}")),
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
