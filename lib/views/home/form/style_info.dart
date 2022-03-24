import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/utils/dimension.dart';
import 'package:flutter/material.dart';

class StyleInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Dimension().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Informasi Gaya Desain",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: Dimension.safeBlockHorizontal * 3,
                vertical: Dimension.safeBlockVertical * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: Dimension.blockSizeVertical * 30,
                  child: Image.asset("assets/images/minimalist1.jpg",
                      fit: BoxFit.cover),
                ),
                SizedBox(height: 5),
                Text("Minimalis",
                    style: blackFontStyle3.copyWith(fontSize: 16)),
                Text(
                    "Desain minimalis adalah desain yang dipreteli, menghapus bagian-bagian yang tidak perlu, hingga hanya meninggalkan elemen-elemen pentingnya saja.. Konsep desain ini bisa dicapai melalui penggunaan furniture fungsional dan benda-benda interior, bentuk geometris, serta kombinasi yang biasanya tidak lebih dari dua warna dasar.",
                    style: blackFontStyle1),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: Dimension.blockSizeVertical * 30,
                  child: Image.asset("assets/images/modern1.jpg",
                      fit: BoxFit.cover),
                ),
                SizedBox(height: 5),
                Text("Modern", style: blackFontStyle3.copyWith(fontSize: 16)),
                Text(
                    "Desain interior modern menganut tampilan yang efisien sehingga hanya ada sedikit atau bahkan tidak ada unsur hiasan atau dekorasi. Biasanya, dekorasi dipilih berdasarkan fungsi dan bukan berdasar pada unsur estetikanya. Gaya interior ini sangat cocok untuk yang ingin menciptakan kesan minimalis nan elegan pada hunian.",
                    style: blackFontStyle1),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: Dimension.blockSizeVertical * 30,
                  child: Image.asset("assets/images/traditional.jpg",
                      fit: BoxFit.cover),
                ),
                SizedBox(height: 5),
                Text("Tradisional",
                    style: blackFontStyle3.copyWith(fontSize: 16)),
                Text(
                    "Interior tradisional menunjukan karakter tenang dan teratur. Tidak ada sesuatu yang tampak “wow” dalam ruangan bergaya tradisional. Gaya interior ini banyak menggunakan berbagai perabotan model klasik dan sedikit menampilkan suasana yang old fashioned. Mampu menampilkan suasana nyaman, bersahaja, dan tidak menggetarkan.",
                    style: blackFontStyle1),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: Dimension.blockSizeVertical * 30,
                  child: Image.asset("assets/images/scandinavian.jpg",
                      fit: BoxFit.cover),
                ),
                SizedBox(height: 5),
                Text("Scandinavian",
                    style: blackFontStyle3.copyWith(fontSize: 16)),
                Text(
                    "Scandinavian  merupakan gaya desain yang menerapkan konsep sederhana sekaligus elegan. Desain ini terinspirasi dari alam dan iklim di bagian Eropa Utara atau yang dikenal dengan sebutan Nordik. Desain interior ini memfokuskan pada kesederhanaan, pemanfaatan tiap ruangan dengan tetap terlihat elegan dan indah",
                    style: blackFontStyle1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
