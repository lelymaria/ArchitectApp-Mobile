import 'dart:io';

class UploadPaymentForm {
  int kontrakId;
  File bukti;

  UploadPaymentForm({this.kontrakId, this.bukti});

  UploadPaymentForm.fromJson(Map<String, dynamic> json) {
    kontrakId = json['kontrakId'];
    bukti = json['bukti'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kontrakId'] = this.kontrakId;
    data['bukti'] = this.bukti;
    return data;
  }
}