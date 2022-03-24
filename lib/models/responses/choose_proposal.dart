class ChooseProposalResponse {
  bool success;
  ChooseProposal data;
  String message;

  ChooseProposalResponse({this.success, this.data, this.message});

  ChooseProposalResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new ChooseProposal.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class ChooseProposal {
  int id;
  int lelangOwnerId;
  int konsultanId;
  String coverLetter;
  String cv;
  int tawaranHarga;
  int status;
  String createdAt;
  String updatedAt;

  ChooseProposal(
      {this.id,
      this.lelangOwnerId,
      this.konsultanId,
      this.coverLetter,
      this.cv,
      this.tawaranHarga,
      this.status,
      this.createdAt,
      this.updatedAt});

  ChooseProposal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lelangOwnerId = json['lelangOwnerId'];
    konsultanId = json['konsultanId'];
    coverLetter = json['coverLetter'];
    cv = json['cv'];
    tawaranHarga = json['tawaranHarga'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lelangOwnerId'] = this.lelangOwnerId;
    data['konsultanId'] = this.konsultanId;
    data['coverLetter'] = this.coverLetter;
    data['cv'] = this.cv;
    data['tawaranHarga'] = this.tawaranHarga;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
