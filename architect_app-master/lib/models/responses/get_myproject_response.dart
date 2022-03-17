import 'package:architect_app/models/responses/get_projects_response.dart';
import 'package:architect_app/models/responses/login_response.dart';

class GetMyProjectResponse {
  bool success;
  List<MyProject> data;
  String message;

  GetMyProjectResponse({this.success, this.data, this.message});

  GetMyProjectResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<MyProject>();
      json['data'].forEach((v) {
        data.add(new MyProject.fromJson(v));
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

class MyProject {
  int id;
  int ownerId;
  int projectId;
  String hasilRab;
  String status;
  String createdAt;
  String updatedAt;
  ProjectOwner project;
  Kontrak kontrak;
  List<Hasil> hasil;
  Ratings ratings;
  ChooseProject chooseProject;

  MyProject(
      {this.id,
      this.ownerId,
      this.projectId,
      this.hasilRab,
      this.createdAt,
      this.updatedAt,
      this.project,
      this.kontrak,
      this.hasil,
      this.ratings,
      this.chooseProject});

  MyProject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerId = json['ownerId'];
    projectId = json['projectId'];
    hasilRab = json['hasil_rab'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    project = json['project'] != null
        ? new ProjectOwner.fromJson(json['project'])
        : null;
    kontrak =
        json['kontrak'] != null ? new Kontrak.fromJson(json['kontrak']) : null;
    if (json['hasil'] != null) {
      hasil = new List<Hasil>();
      json['hasil'].forEach((v) {
        hasil.add(new Hasil.fromJson(v));
      });
    }
    ratings =
        json['ratings'] != null ? new Ratings.fromJson(json['ratings']) : null;
    chooseProject = json['choose_project'] != null
        ? new ChooseProject.fromJson(json['choose_project'])
        : null;
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
    if (this.project != null) {
      data['project'] = this.project.toJson();
    }
    if (this.kontrak != null) {
      data['kontrak'] = this.kontrak.toJson();
    }
    if (this.hasil != null) {
      data['hasil'] = this.hasil.map((v) => v.toJson()).toList();
    }
    if (this.ratings != null) {
      data['ratings'] = this.ratings.toJson();
    }
    if (this.chooseProject != null) {
      data['choose_project'] = this.chooseProject.toJson();
    }
    return data;
  }
}

class ProjectOwner {
  int id;
  int konsultanId;
  String title;
  String slug;
  String description;
  String gayaDesain;
  int hargaDesain;
  int hargaRab;
  String status;
  String createdAt;
  String updatedAt;
  MyProjectKonsultan konsultan;

  ProjectOwner(
      {this.id,
      this.konsultanId,
      this.title,
      this.slug,
      this.description,
      this.gayaDesain,
      this.hargaDesain,
      this.hargaRab,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.konsultan});

  ProjectOwner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    konsultanId = json['konsultanId'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    gayaDesain = json['gayaDesain'];
    hargaDesain = json['harga_desain'];
    hargaRab = json['harga_rab'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    konsultan = json['konsultan'] != null
        ? new MyProjectKonsultan.fromJson(json['konsultan'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['konsultanId'] = this.konsultanId;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['gayaDesain'] = this.gayaDesain;
    data['harga_desain'] = this.hargaDesain;
    data['harga_rab'] = this.hargaRab;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.konsultan != null) {
      data['konsultan'] = this.konsultan.toJson();
    }
    return data;
  }
}

class Kontrak {
  int id;
  int tenderKonsultanId;
  int projectOwnerId;
  String kontrakKerja;
  String createdAt;
  String updatedAt;
  Payment payment;

  Kontrak(
      {this.id,
      this.tenderKonsultanId,
      this.projectOwnerId,
      this.kontrakKerja,
      this.createdAt,
      this.updatedAt,
      this.payment});

  Kontrak.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tenderKonsultanId = json['tenderKonsultanId'];
    projectOwnerId = json['projectOwnerId'];
    kontrakKerja = json['kontrakKerja'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    payment =
        json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tenderKonsultanId'] = this.tenderKonsultanId;
    data['projectOwnerId'] = this.projectOwnerId;
    data['kontrakKerja'] = this.kontrakKerja;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.payment != null) {
      data['payment'] = this.payment.toJson();
    }
    return data;
  }
}

class Payment {
  int id;
  int kontrakKonsultanId;
  String buktiBayar;
  int status;
  String createdAt;
  String updatedAt;

  Payment(
      {this.id,
      this.kontrakKonsultanId,
      this.buktiBayar,
      this.status,
      this.createdAt,
      this.updatedAt});

  Payment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kontrakKonsultanId = json['kontrakKonsultanId'];
    buktiBayar = json['buktiBayar'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kontrakKonsultanId'] = this.kontrakKonsultanId;
    data['buktiBayar'] = this.buktiBayar;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class MyProjectKonsultan {
  int id;
  int userId;
  Null telepon;
  Null website;
  Null instagram;
  Null about;
  Null alamat;
  String createdAt;
  String updatedAt;
  User user;

  MyProjectKonsultan(
      {this.id,
      this.userId,
      this.telepon,
      this.website,
      this.instagram,
      this.about,
      this.alamat,
      this.createdAt,
      this.updatedAt,
      this.user});

  MyProjectKonsultan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    telepon = json['telepon'];
    website = json['website'];
    instagram = json['instagram'];
    about = json['about'];
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
    data['website'] = this.website;
    data['instagram'] = this.instagram;
    data['about'] = this.about;
    data['alamat'] = this.alamat;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class Hasil {
  int id;
  int projectOwnerId;
  String softfile;
  String createdAt;
  String updatedAt;

  Hasil(
      {this.id,
      this.projectOwnerId,
      this.softfile,
      this.createdAt,
      this.updatedAt});

  Hasil.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectOwnerId = json['projectOwnerId'];
    softfile = json['softfile'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['projectOwnerId'] = this.projectOwnerId;
    data['softfile'] = this.softfile;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ChooseProject {
  int id;
  int projectOwnerId;
  String rAB;
  String desain;
  String luas;
  String createdAt;
  String updatedAt;

  ChooseProject(
      {this.id,
      this.projectOwnerId,
      this.rAB,
      this.desain,
      this.luas,
      this.createdAt,
      this.updatedAt});

  ChooseProject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectOwnerId = json['projectOwnerId'];
    rAB = json['RAB'];
    desain = json['desain'];
    luas = json['luas'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['projectOwnerId'] = this.projectOwnerId;
    data['RAB'] = this.rAB;
    data['desain'] = this.desain;
    data['luas'] = this.luas;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
