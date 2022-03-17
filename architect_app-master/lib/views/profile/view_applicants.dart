import 'package:another_flushbar/flushbar.dart';
import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/models/repositories/repository.dart';
import 'package:architect_app/models/responses/get_mylelang_response.dart';
import 'package:architect_app/models/responses/get_proposal_response.dart';
import 'package:architect_app/models/responses/login_response.dart';
import 'package:architect_app/utils/dimension.dart';
import 'package:architect_app/views/profile/projects_owner.dart';
import 'package:architect_app/views/profile/view_applicant_detail.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ViewApplicants extends StatefulWidget {
  final MyLelang lelang;
  ViewApplicants({this.lelang});

  @override
  _ViewApplicantsState createState() => _ViewApplicantsState();
}

class _ViewApplicantsState extends State<ViewApplicants> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  BuildContext context;
  Repository _repository = Repository();
  AuthPreference _authPreference = AuthPreference();
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
    this.context = context;
    Dimension().init(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Lihat pendaftar",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: Dimension.safeBlockHorizontal * 1.5,
              vertical: Dimension.safeBlockVertical),
          child: ListView.builder(
              itemCount: widget.lelang.proposalCount,
              itemBuilder: (context, index) {
                DataProposal proposal = widget.lelang.proposal[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ViewApplicantDetail(proposal: proposal)));
                  },
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimension.safeBlockHorizontal * 2,
                          vertical: Dimension.safeBlockHorizontal * 2),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(proposal.konsultan.user.name,
                                        style: blackFontStyle3.copyWith(
                                            fontSize: 17)),
                                    Text(
                                      proposal.coverLetter,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              if (proposal.status == 0)
                                ElevatedButton(
                                  onPressed: () {
                                    _confirmationDialog(
                                        proposal.id, proposal.lelangOwnerId);
                                    // _onVerification(
                                    //     proposal.id, proposal.lelangOwnerId);
                                  },
                                  child: Text("Pilih"),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.amber),
                                ),
                              if (proposal.status == 1 || proposal.status == 2)
                                Container(
                                  padding: EdgeInsets.all(
                                      Dimension.safeBlockHorizontal * 1),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            Dimension.safeBlockHorizontal * 2)),
                                  ),
                                  child: Text(
                                    "Dipilih",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          Dimension.safeBlockHorizontal * 2.5,
                                    ),
                                  ),
                                ),
                              if (proposal.status == 3)
                                Container(
                                  padding: EdgeInsets.all(
                                      Dimension.safeBlockHorizontal * 1),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            Dimension.safeBlockHorizontal * 2)),
                                  ),
                                  child: Text(
                                    "Ditolak",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          Dimension.safeBlockHorizontal * 2.5,
                                    ),
                                  ),
                                )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }

  _confirmationDialog(int id, int lelangOwnerId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Icon(Icons.info_outline_rounded),
                ),
                Expanded(
                  child: Text(
                    "Apakah anda yakin ?",
                    style: TextStyle(fontSize: 14),
                  ),
                )
              ]),
          content: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white, onPrimary: Colors.black),
                    child: Text("Tidak")),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                    onPressed: () async {
                      _onVerification(id, lelangOwnerId);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white, onPrimary: Colors.black),
                    child: Text("Ya")),
              ),
            ],
          ),
        );
      },
    );
  }

  _onVerification(int id, int lelangOwnerId) {
    try {
      _repository
          .chooseProposal(_authPreference, id, lelangOwnerId)
          .then((value) {
        if (value.success = true) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProjectsOwner()));
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Flushbar(
              flushbarStyle: FlushbarStyle.FLOATING,
              flushbarPosition: FlushbarPosition.TOP,
              backgroundColor: Colors.green,
              message: "Berhasil memilih konsultan",
              icon: Icon(
                FontAwesomeIcons.checkCircle,
                size: 28.0,
                color: Colors.white,
              ),
              duration: Duration(seconds: 3),
            )..show(scaffoldKey.currentState.context);
          });
        } else {
          setState(() {});
          Flushbar(
            flushbarStyle: FlushbarStyle.FLOATING,
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: Colors.red,
            message: "Gagal memilih konsultan",
            icon: Icon(
              FontAwesomeIcons.infoCircle,
              size: 28.0,
              color: Colors.white,
            ),
            duration: Duration(seconds: 3),
          ).show(context);
        }
      });
    } catch (e) {
      Flushbar(
        flushbarStyle: FlushbarStyle.FLOATING,
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.red,
        message: "Gagal memilih konsultan",
        icon: Icon(
          FontAwesomeIcons.infoCircle,
          size: 28.0,
          color: Colors.white,
        ),
        duration: Duration(seconds: 3),
      ).show(context);
    }
  }
}
