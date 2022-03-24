import 'package:architect_app/models/responses/add_lelang_response.dart';

class ChooseProjectResponse {
  bool success;
  List<ChooseProData> data;
  String message;

  ChooseProjectResponse({this.success, this.data, this.message});

  ChooseProjectResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<ChooseProData>();
      json['data'].forEach((v) {
        data.add(new ChooseProData.fromJson(v));
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

class ChooseProData {
  int id;
  int ownerId;
  int projectId;
  String hasilRab;
  String status;
  String createdAt;
  String updatedAt;
  OwnerLelang owner;

  ChooseProData(
      {this.id,
      this.ownerId,
      this.projectId,
      this.hasilRab,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.owner});

  ChooseProData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerId = json['ownerId'];
    projectId = json['projectId'];
    hasilRab = json['hasil_rab'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    owner = json['owner'] != null ? new OwnerLelang.fromJson(json['owner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ownerId'] = this.ownerId;
    data['projectId'] = this.projectId;
    data['hasil_rab'] = this.hasilRab;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    return data;
  }
}
