import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/utils/generals.dart';
import 'package:flutter/material.dart';

class PaymentVerificationDetail extends StatelessWidget {
  final dynamic data;
  PaymentVerificationDetail({this.data});
  
  @override
  Widget build(BuildContext context) {
    int total = data['project']['harga_desain'] + data['project']['harga_rab'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Pembayaran",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Project",
                    style: blackFontStyle1,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    data['project']['title'],
                    style: blackFontStyle3,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Owner",
                    style: blackFontStyle1,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    data['owner']['user']['name'],
                    style: blackFontStyle3,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Konsultan",
                    style: blackFontStyle1,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    data['project']['konsultan']['user']['name'],
                    style: blackFontStyle3,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Total Bayar",
                    style: blackFontStyle1,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "${Generals.formatRupiah(total)}",
                    style: blackFontStyle3,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
