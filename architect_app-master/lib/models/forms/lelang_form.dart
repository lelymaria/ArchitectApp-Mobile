import 'dart:io';

class LelangForm {
  String title;
  String description;
  String style;
  int budgetFrom;
  int budgetTo;
  double panjang;
  double lebar;
  String desain;
  String rab;
  String telepon;
  String alamat;
  List<File> image;
  List<File> inspirasi;

  LelangForm(this.title, this.description, this.style, this.budgetFrom, this.budgetTo, this.panjang, this.lebar, this.desain, this.rab, this.telepon, this.alamat, this.image, this.inspirasi);

  LelangForm.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    style = json['style'];
    budgetFrom = json['budgetFrom'];
    budgetTo = json['budgetTo'];
    panjang = json['panjang'];
    lebar = json['lebar'];
    desain = json['desain'];
    rab = json['rab'];
    telepon = json['telepon'];
    alamat = json['alamat'];
    image = json['image'];
    inspirasi = json['inspirasi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['style'] = this.style;
    data['budgetFrom'] = this.budgetFrom;
    data['budgetTo'] = this.budgetTo;
    data['panjang'] = this.panjang;
    data['lebar'] = this.lebar;
    data['desain'] = this.desain;
    data['rab'] = this.rab;
    data['telepon'] = this.telepon;
    data['alamat'] = this.alamat;
    data['image'] = this.image;
    data['inspirasi'] = this.inspirasi;
    return data;
  }
}