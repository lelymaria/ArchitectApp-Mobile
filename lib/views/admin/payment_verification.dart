import 'package:another_flushbar/flushbar.dart';
import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/utils/generals.dart';
import 'package:architect_app/views/admin/doc_view_screen.dart';
import 'package:architect_app/views/admin/image_view_screen.dart';
import 'package:architect_app/views/admin/payment_verification_detail.dart';
import 'package:flutter/material.dart';
import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/models/repositories/repository.dart';
import 'package:architect_app/utils/dimension.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentVerification extends StatefulWidget {
  @override
  _PaymentVerificationState createState() => _PaymentVerificationState();
}

class _PaymentVerificationState extends State<PaymentVerification> {
  AuthPreference _authPreference = AuthPreference();
  Repository _repository = Repository();
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    Dimension().init(context);
    return FutureBuilder(
      future: _repository.getPaymentConsultant(_authPreference),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Load data gagal"));
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
                    var payment = res['data'][index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PaymentVerificationDetail(data: payment['kontrak']['project_owner'])));
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              payment['kontrak']['project_owner']
                                                  ['owner']['user']['email'],
                                              style: blackFontStyle3),
                                          SizedBox(height: 5),
                                          GestureDetector(
                                            onTap: () {
                                              var ext = payment['buktiBayar']
                                                  .split(".")[1];
                                              if (Generals.listFormatImage
                                                  .contains(ext)) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ImageViewScreen(
                                                              // imageUrl:
                                                              //     "${'http://1803010.web.ti.polindra.ac.id/index.php/img/bukti/'}${payment['buktiBayar']}")),
                                                              imageUrl:
                                                                  "${'${Generals.baseUrl}/img/bukti/'}${payment['buktiBayar']}")),
                                                );
                                              } else if (Generals.listFormatPdf
                                                  .contains(ext)) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DocViewScreen(
                                                              // remotePDF:
                                                              //     "${'http://1803010.web.ti.polindra.ac.id/index.php/img/bukti/'}${payment['buktiBayar']}")),
                                                              remotePDF:
                                                                  "${'${Generals.baseUrl}/img/bukti/'}${payment['buktiBayar']}")),
                                                );
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Bukti Pembayaran",
                                                  style:
                                                      blackFontStyle1.copyWith(
                                                          color: Colors.green),
                                                  maxLines: 2,
                                                ),
                                                SizedBox(width: 5),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: Dimension
                                                          .blockSizeVertical *
                                                      1.8,
                                                  color: Colors.green,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    payment['status'] == 0
                                        ? ElevatedButton(
                                            onPressed: () {
                                              _confirmationDialog(
                                                  payment['id']);
                                            },
                                            child: Text("Verifikasi"),
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.amber),
                                          )
                                        : payment['status'] == 1
                                            ? Container(
                                                padding: EdgeInsets.all(Dimension
                                                        .safeBlockHorizontal *
                                                    1),
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(Dimension
                                                              .safeBlockHorizontal *
                                                          2)),
                                                ),
                                                child: Text(
                                                  "Diterima",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: Dimension
                                                            .safeBlockHorizontal *
                                                        2.5,
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                padding: EdgeInsets.all(Dimension
                                                        .safeBlockHorizontal *
                                                    1),
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(Dimension
                                                              .safeBlockHorizontal *
                                                          2)),
                                                ),
                                                child: Text(
                                                  "Ditolak",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: Dimension
                                                            .safeBlockHorizontal *
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
                      _onVerification(id: id);
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

  _onVerification({int id}) {
    try {
      _repository
          .verifPayment(paymentId: id, authPreference: _authPreference)
          .then((value) {
        if (value['success'] == true) {
          setState(() {});
          Flushbar(
            flushbarStyle: FlushbarStyle.FLOATING,
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: Colors.green,
            message: "Berhasil memverifikasi pembayaran",
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
            message: "Gagal memverifikasi pembayaran",
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
      setState(() {});
      Flushbar(
        flushbarStyle: FlushbarStyle.FLOATING,
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.red,
        message: "Gagal memverifikasi pembayaran",
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
