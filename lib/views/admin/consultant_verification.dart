import 'package:another_flushbar/flushbar.dart';
import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/models/repositories/repository.dart';
import 'package:architect_app/models/responses/get_consultant_response.dart';
import 'package:architect_app/utils/dimension.dart';
import 'package:architect_app/utils/generals.dart';
import 'package:architect_app/views/admin/doc_view_screen.dart';
import 'package:architect_app/views/admin/image_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConsultanVerification extends StatefulWidget {
  @override
  _ConsultanVerificationState createState() => _ConsultanVerificationState();
}

class _ConsultanVerificationState extends State<ConsultanVerification> {
  AuthPreference _authPreference = AuthPreference();
  Repository _repository = Repository();
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    Dimension().init(context);
    return FutureBuilder(
      future: _repository.getConsultant(_authPreference),
      builder: (BuildContext context, AsyncSnapshot<List<DataConsultant>> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Load data gagal"));
        } else if (snapshot.connectionState == ConnectionState.done) {
          List<DataConsultant> profesionals = snapshot.data;
          return SafeArea(child: _buildContent(profesionals));
        } else {
          return Center(child: loadingIndicator);
        }
      },
    );
  }

  Widget _buildContent(List<DataConsultant> profesionals) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Dimension.safeBlockHorizontal * 2,
          vertical: Dimension.safeBlockVertical * 2),
      child: ListView.builder(
          itemCount: profesionals.length,
          itemBuilder: (context, index) {
            DataConsultant profesional = profesionals[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
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
                                Text(profesional.user.email, style: blackFontStyle3),
                                SizedBox(height: 5),
                                GestureDetector(
                                  onTap: () {
                                    var ext = profesional.files[0].file.split(".")[1];
                                    print(profesional.files[0].file);
                                    if (Generals.listFormatImage
                                        .contains(ext)) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ImageViewScreen(
                                                // imageUrl:
                                                //     "${'http://1803010.web.ti.polindra.ac.id/index.php/img/persyaratan/konsultan/'}${profesional.files[0].file}")),
                                                imageUrl:
                                                    "${'${Generals.baseUrl}/img/persyaratan/konsultan/'}${profesional.files[0].file}")),
                                      );
                                    } else if (Generals.listFormatPdf
                                        .contains(ext)) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DocViewScreen(
                                                // remotePDF:
                                                //     "${'http://1803010.web.ti.polindra.ac.id/index.php/img/persyaratan/konsultan/'}${profesional.files[0].file}")),
                                                remotePDF:
                                                    "${'${Generals.baseUrl}/img/persyaratan/konsultan/'}${profesional.files[0].file}")),
                                      );
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "Sertifikat Keahlian (SKA)",
                                        style: blackFontStyle1.copyWith(
                                            color: Colors.green),
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
                              ],
                            ),
                          ),
                          profesional.user.isActive == 0
                              ? ElevatedButton(
                                  onPressed: () {
                                    _confirmationDialog(profesional.user.id);
                                  },
                                  child: Text("Verifikasi"),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.amber),
                                )
                              : profesional.user.isActive == 1
                                  ? Container(
                                      padding: EdgeInsets.all(
                                          Dimension.safeBlockHorizontal * 1),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                Dimension.safeBlockHorizontal *
                                                    2)),
                                      ),
                                      child: Text(
                                        "Diterima",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              Dimension.safeBlockHorizontal *
                                                  2.5,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      padding: EdgeInsets.all(
                                          Dimension.safeBlockHorizontal * 1),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                Dimension.safeBlockHorizontal *
                                                    2)),
                                      ),
                                      child: Text(
                                        "Ditolak",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              Dimension.safeBlockHorizontal *
                                                  2.5,
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
    );
  }

  _confirmationDialog(int id) {
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
                    "Verifikasi",
                    style: TextStyle(fontSize: 14),
                  ),
                )
              ]),
          content: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      _onVerification(id: id, isActive: 2);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white, onPrimary: Colors.black),
                    child: Text("Tolak")),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                    onPressed: () async {
                      _onVerification(id: id, isActive: 1);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white, onPrimary: Colors.black),
                    child: Text("Terima")),
              ),
            ],
          ),
        );
      },
    );
  }

  _onVerification({int id, int isActive}) {
    try {
      _repository
          .verifPro(id: id, isActive: isActive, authPreference: _authPreference)
          .then((value) {
        if (value.success == true) {
          setState(() {});
          Flushbar(
            flushbarStyle: FlushbarStyle.FLOATING,
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: Colors.green,
            message: value.message,
            icon: Icon(
              FontAwesomeIcons.checkCircle,
              size: 28.0,
              color: Colors.white,
            ),
            duration: Duration(seconds: 3),
          ).show(this.context);
        } else {
          setState(() {});
          Flushbar(
            flushbarStyle: FlushbarStyle.FLOATING,
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: Colors.red,
            message: value.message,
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
        message: "Gagal memverifikasi data",
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
