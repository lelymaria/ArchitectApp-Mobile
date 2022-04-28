import 'dart:io';

/* Menambahkan Desain */
class AddDesainForm {
  String title;
  String desc;
  String gayaDesain;
  int hargaDesain;
  int hargaRab;
  List<File> image;

  AddDesainForm({this.title, this.desc, this.gayaDesain, this.hargaRab, this.hargaDesain, this.image});

  AddDesainForm.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    desc = json['desc'];
    gayaDesain = json['gayaDesain'];
    hargaRab = json['hargaRab'];
    hargaDesain = json['hargaDesain'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['gayaDesain'] = this.gayaDesain;
    data['hargaRab'] = this.hargaRab;
    data['hargaDesain'] = this.hargaDesain;
    data['image'] = this.image;
    return data;
  }
}