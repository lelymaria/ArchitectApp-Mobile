import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/contractor_services.dart';
import 'package:architect_app/models/responses/login_response.dart';
import 'package:architect_app/utils/dimension.dart';
import 'package:architect_app/utils/generals.dart';
import 'package:architect_app/views/admin/image_view_screen.dart';
import 'package:architect_app/views/contractor/view_contractor_applicant.dart';
import 'package:architect_app/views/profile/submit_proposal.dart';
import 'package:architect_app/views/profile/view_applicants.dart';
import 'package:flutter/material.dart';

class FindProfesionalDetail extends StatefulWidget {
  final ContractorServices services;
  final User user;

  FindProfesionalDetail(this.services, this.user);

  @override
  _FindProfesionalDetailState createState() => _FindProfesionalDetailState();
}

class _FindProfesionalDetailState extends State<FindProfesionalDetail> {
  @override
  Widget build(BuildContext context) {
    Dimension().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Jasa saya",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: ListView(children: [
          Text(
            widget.services.title,
            style: blackFontStyle3.copyWith(fontSize: 20),
          ),
          SizedBox(height: 5),
          Text(
            "est. anggaran: ${Generals.formatRupiah(widget.services.budget)}",
            style: blackFontStyle1.copyWith(fontSize: 13),
          ),
          SizedBox(height: 10),
          Container(
            child: Text(widget.services.description),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              var ext = widget.services.desain.split(".")[1];
              if (Generals.listFormatImage.contains(ext)) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImageViewScreen(
                          imageUrl:
                              "${'assets/images/'}${widget.services.desain}")),
                );
              }
            },
            child: Row(
              children: [
                Text(
                  "Lihat rancangan desain",
                  style: blackFontStyle1.copyWith(color: Colors.green),
                  maxLines: 2,
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  size: Dimension.blockSizeVertical * 1.8,
                  color: Colors.green,
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              var ext = widget.services.rab.split(".")[1];
              if (Generals.listFormatImage.contains(ext)) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImageViewScreen(
                          imageUrl:
                              "${'assets/images/'}${widget.services.rab}")),
                );
              }
            },
            child: Row(
              children: [
                Text(
                  "Lihat rencana anggaran biaya",
                  style: blackFontStyle1.copyWith(color: Colors.green),
                  maxLines: 2,
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  size: Dimension.blockSizeVertical * 1.8,
                  color: Colors.green,
                )
              ],
            ),
          ),
        ]),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: widget.user.level == "konsultan"
              ? ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewContractorApplocant()));
                  },
                  child: Text("Lihat Pendaftar"),
                  style: ElevatedButton.styleFrom(primary: Colors.amber),
                )
              : ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SubmitProposal()));
                  },
                  child: Text("Submit Proposal"),
                  style: ElevatedButton.styleFrom(primary: Colors.amber),
                ),
        ),
      ),
    );
  }
}
