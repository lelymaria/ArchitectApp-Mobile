import 'dart:io';

class AddProposalForm {
  int lelangId;
  String coverLetter;
  File cv;
  int tawaranDesain;
  int tawaranRab;
  String telepon;
  String alamat;

  AddProposalForm({this.lelangId, this.coverLetter, this.cv, this.tawaranDesain, this.tawaranRab, this.telepon, this.alamat});

  AddProposalForm.fromJson(Map<String, dynamic> json) {
    lelangId = json['lelangId'];
    coverLetter = json['coverLetter'];
    cv = json['cv'];
    tawaranDesain = json['tawaranDesain'];
    tawaranRab = json['tawaranRab'];
    telepon = json['telepon'];
    alamat = json['alamat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lelangId'] = this.lelangId;
    data['coverLetter'] = this.coverLetter;
    data['cv'] = this.cv;
    data['tawaranDesain'] = this.tawaranDesain;
    data['tawaranRab'] = this.tawaranRab;
    data['telepon'] = this.telepon;
    data['alamat'] = this.alamat;
    return data;
  }
}