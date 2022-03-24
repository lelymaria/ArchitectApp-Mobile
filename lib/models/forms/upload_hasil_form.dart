import 'dart:io';

class UploadHasilForm {
  int projectOwnerId;
  File rab;
  List<File> softfile;

  UploadHasilForm({this.projectOwnerId, this.rab, this.softfile});

  UploadHasilForm.fromJson(Map<String, dynamic> json) {
    projectOwnerId = json['projectOwnerId'];
    rab = json['rab'];
    softfile = json['softfile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['projectOwnerId'] = this.projectOwnerId;
    data['rab'] = this.rab;
    data['softfile'] = this.softfile;
    return data;
  }
}