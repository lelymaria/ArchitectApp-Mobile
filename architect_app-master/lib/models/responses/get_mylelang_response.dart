import 'package:architect_app/models/responses/get_proposal_response.dart';
import 'package:architect_app/models/responses/login_response.dart';

class GetMyLelangResponse {
  bool success;
  List<MyLelang> data;
  String message;

  GetMyLelangResponse({this.success, this.data, this.message});

  GetMyLelangResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<MyLelang>();
      json['data'].forEach((v) {
        data.add(new MyLelang.fromJson(v));
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

class MyLelang {
  int id;
  int ownerId;
  String title;
  String description;
  int status;
  int budgetFrom;
  int budgetTo;
  String gayaDesain;
  String rAB;
  String desain;
  String kontraktor;
  String panjang;
  String lebar;
  String createdAt;
  String updatedAt;
  int proposalCount;
  Owner owner;
  List<ImageLelang> image;
  List<Inspirasi> inspirasi;
  List<DataProposal> proposal;

  MyLelang(
      {this.id,
      this.ownerId,
      this.title,
      this.description,
      this.status,
      this.budgetFrom,
      this.budgetTo,
      this.gayaDesain,
      this.rAB,
      this.desain,
      this.kontraktor,
      this.panjang,
      this.lebar,
      this.createdAt,
      this.updatedAt,
      this.proposalCount,
      this.owner,
      this.image,
      this.inspirasi,
      this.proposal});

  MyLelang.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerId = json['ownerId'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    budgetFrom = json['budgetFrom'];
    budgetTo = json['budgetTo'];
    gayaDesain = json['gayaDesain'];
    rAB = json['RAB'];
    desain = json['desain'];
    kontraktor = json['kontraktor'];
    panjang = json['panjang'];
    lebar = json['lebar'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    proposalCount = json['proposal_count'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    if (json['image'] != null) {
      image = new List<ImageLelang>();
      json['image'].forEach((v) {
        image.add(new ImageLelang.fromJson(v));
      });
    }
    if (json['inspirasi'] != null) {
      inspirasi = new List<Inspirasi>();
      json['inspirasi'].forEach((v) {
        inspirasi.add(new Inspirasi.fromJson(v));
      });
    }
    if (json['proposal'] != null) {
      proposal = new List<DataProposal>();
      json['proposal'].forEach((v) {
        proposal.add(new DataProposal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ownerId'] = this.ownerId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['status'] = this.status;
    data['budgetFrom'] = this.budgetFrom;
    data['budgetTo'] = this.budgetTo;
    data['gayaDesain'] = this.gayaDesain;
    data['RAB'] = this.rAB;
    data['desain'] = this.desain;
    data['kontraktor'] = this.kontraktor;
    data['panjang'] = this.panjang;
    data['lebar'] = this.lebar;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    if (this.image != null) {
      data['image'] = this.image.map((v) => v.toJson()).toList();
    }
    if (this.inspirasi != null) {
      data['inspirasi'] = this.inspirasi.map((v) => v.toJson()).toList();
    }
    if (this.proposal != null) {
      data['proposal'] = this.proposal.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Owner {
  int id;
  int userId;
  String telepon;
  String alamat;
  String createdAt;
  String updatedAt;
  User user;

  Owner(
      {this.id,
      this.userId,
      this.telepon,
      this.alamat,
      this.createdAt,
      this.updatedAt,
      this.user});

  Owner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    telepon = json['telepon'];
    alamat = json['alamat'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['telepon'] = this.telepon;
    data['alamat'] = this.alamat;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class ImageLelang {
  int id;
  int lelangOwnerId;
  String image;
  String createdAt;
  String updatedAt;

  ImageLelang(
      {this.id,
      this.lelangOwnerId,
      this.image,
      this.createdAt,
      this.updatedAt});

  ImageLelang.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lelangOwnerId = json['lelangOwnerId'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lelangOwnerId'] = this.lelangOwnerId;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Inspirasi {
  int id;
  int lelangOwnerId;
  String inspirasi;
  String createdAt;
  String updatedAt;

  Inspirasi(
      {this.id,
      this.lelangOwnerId,
      this.inspirasi,
      this.createdAt,
      this.updatedAt});

  Inspirasi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lelangOwnerId = json['lelangOwnerId'];
    inspirasi = json['inspirasi'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lelangOwnerId'] = this.lelangOwnerId;
    data['inspirasi'] = this.inspirasi;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}