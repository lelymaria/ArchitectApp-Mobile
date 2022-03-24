import 'package:architect_app/models/responses/login_response.dart';

class GetProposalResponse {
  bool success;
  List<DataProposal> data;
  String message;

  GetProposalResponse({this.success, this.data, this.message});

  GetProposalResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<DataProposal>();
      json['data'].forEach((v) {
        data.add(new DataProposal.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class DataProposal {
  int id;
  int lelangOwnerId;
  int konsultanId;
  String coverLetter;
  String cv;
  int tawaranHargaDesain;
  int tawaranHargaRab;
  int status;
  String createdAt;
  String updatedAt;
  ProposalKonsultan konsultan;

  DataProposal(
      {this.id,
      this.lelangOwnerId,
      this.konsultanId,
      this.coverLetter,
      this.cv,
      this.tawaranHargaDesain,
      this.tawaranHargaRab,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.konsultan});

  DataProposal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lelangOwnerId = json['lelangOwnerId'];
    konsultanId = json['konsultanId'];
    coverLetter = json['coverLetter'];
    cv = json['cv'];
    tawaranHargaDesain = json['tawaranHargaDesain'];
    tawaranHargaRab = json['tawaranHargaRab'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    konsultan = json['konsultan'] != null
        ? new ProposalKonsultan.fromJson(json['konsultan'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lelangOwnerId'] = this.lelangOwnerId;
    data['konsultanId'] = this.konsultanId;
    data['coverLetter'] = this.coverLetter;
    data['cv'] = this.cv;
    data['tawaranHargaDesain'] = this.tawaranHargaDesain;
    data['tawaranHargaRab'] = this.tawaranHargaRab;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.konsultan != null) {
      data['konsultan'] = this.konsultan.toJson();
    }
    return data;
  }
}

class ProposalKonsultan {
  int id;
  int userId;
  String telepon;
  String website;
  String instagram;
  String about;
  String createdAt;
  String updatedAt;
  User user;

  ProposalKonsultan(
      {this.id,
      this.userId,
      this.telepon,
      this.website,
      this.instagram,
      this.about,
      this.createdAt,
      this.updatedAt,
      this.user});

  ProposalKonsultan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    telepon = json['telepon'];
    website = json['website'];
    instagram = json['instagram'];
    about = json['about'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['telepon'] = this.telepon;
    data['website'] = this.website;
    data['instagram'] = this.instagram;
    data['about'] = this.about;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}
