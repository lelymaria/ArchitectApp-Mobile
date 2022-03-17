import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/responses/get_mylelang_response.dart';
import 'package:architect_app/utils/generals.dart';
import 'package:architect_app/views/admin/image_view_screen.dart';
import 'package:architect_app/views/profile/view_applicants.dart';
import 'package:flutter/material.dart';

class AuctionDetail extends StatefulWidget {
  final MyLelang lelang;
  AuctionDetail(this.lelang);

  @override
  _AuctionDetailState createState() => _AuctionDetailState();
}

class _AuctionDetailState extends State<AuctionDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail lelang",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              widget.lelang.title,
              style: blackFontStyle3.copyWith(fontSize: 20),
            ),
            SizedBox(height: 10),
            Container(
              child: Text(widget.lelang.description),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Nama Pelelang",
                    style: blackFontStyle1,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    widget.lelang.owner.user.name,
                    style: blackFontStyle3,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Telepon",
                    style: blackFontStyle1,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    widget.lelang.owner.telepon,
                    style: blackFontStyle3,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Lokasi",
                    style: blackFontStyle1,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    widget.lelang.owner.alamat,
                    style: blackFontStyle3,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Estimasi Anggaran",
                    style: blackFontStyle1,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "${Generals.formatRupiah(widget.lelang.budgetFrom)} - ${widget.lelang.budgetTo}",
                    style: blackFontStyle3,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Gaya Desain",
                    style: blackFontStyle1,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    widget.lelang.gayaDesain,
                    style: blackFontStyle3,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Luas Ruangan",
                    style: blackFontStyle1,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "${widget.lelang.panjang} x ${widget.lelang.lebar}",
                    style: blackFontStyle3,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            if (widget.lelang.image.length > 0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Foto Ruangan Saat Ini", style: blackFontStyle1),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    crossAxisSpacing: 5,
                    children:
                        List.generate(widget.lelang.image.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImageViewScreen(
                                    imageUrl:
                                        "${'${Generals.baseUrl}/img/lelang/tkp/'}${widget.lelang.image[index].image}")),
                          );
                        },
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "${'${Generals.baseUrl}/img/lelang/tkp/'}${widget.lelang.image[index].image}"),
                                  fit: BoxFit.cover)),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 15),
                ],
              ),
            SizedBox(height: 15),
            if (widget.lelang.inspirasi.length > 0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Foto Inspirasi", style: blackFontStyle1),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    crossAxisSpacing: 5,
                    children:
                        List.generate(widget.lelang.inspirasi.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImageViewScreen(
                                    imageUrl:
                                        "${'${Generals.baseUrl}/img/lelang/tkp/'}${widget.lelang.inspirasi[index].inspirasi}")),
                          );
                        },
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "${'${Generals.baseUrl}/img/lelang/tkp/'}${widget.lelang.inspirasi[index].inspirasi}"),
                                  fit: BoxFit.cover)),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 15),
                ],
              ),
            Text("Jasa yang dibutuhkan", style: blackFontStyle1),
            SizedBox(height: 10),
            Wrap(children: [
              if (widget.lelang.desain == "1")
                Container(
                    margin: EdgeInsets.only(right: 10, bottom: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(50)),
                    child: Text("Desain")),
              if (widget.lelang.rAB == "1")
                Container(
                    margin: EdgeInsets.only(right: 10, bottom: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(50)),
                    child: Text("Rencana Anggaran Biaya")),
              if (widget.lelang.kontraktor == "1")
                Container(
                    margin: EdgeInsets.only(right: 10, bottom: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(50)),
                    child: Text("Kontraktor")),
            ]),
            SizedBox(height: 15),
            Text("Aktivitas", style: blackFontStyle1),
            widget.lelang.proposalCount == 0
                ? Text(
                    "Belum ada konsultan mendaftar",
                    style: blackFontStyle3,
                  )
                : Text(
                    "${widget.lelang.proposalCount} konsultan mendaftar",
                    style: blackFontStyle3,
                  ),
            SizedBox(height: 15),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
          child: widget.lelang.proposalCount > 0
              ? Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ViewApplicants(lelang: widget.lelang)));
                    },
                    child: Text("Lihat Pendaftar"),
                    style: ElevatedButton.styleFrom(primary: Colors.amber),
                  ))
              : SizedBox()),
    );
  }
}
