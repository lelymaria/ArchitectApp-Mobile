import 'dart:io';

class ChooseProjectForm {
  int projectId;
  int userId;
  double panjang;
  double lebar;
  String desain;
  String rab;
  String telepon;
  String alamat;
  List<File> image;

  ChooseProjectForm(this.projectId, this.userId, this.panjang, this.lebar, this.desain, this.rab, this.telepon, this.alamat);

  ChooseProjectForm.fromJson(Map<String, dynamic> json) {
    projectId = json['projectId'];
    userId = json['userId'];
    panjang = json['panjang'];
    lebar = json['lebar'];
    desain = json['desain'];
    rab = json['rab'];
    telepon = json['telepon'];
    alamat = json['alamat'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['projectId'] = this.projectId;
    data['userId'] = this.userId;
    data['panjang'] = this.panjang;
    data['lebar'] = this.lebar;
    data['desain'] = this.desain;
    data['rab'] = this.rab;
    data['telepon'] = this.telepon;
    data['alamat'] = this.alamat;
    data['image'] = this.image;
    return data;
  }
}