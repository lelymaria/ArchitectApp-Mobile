import 'package:architect_app/models/responses/get_myproject_response.dart';
import 'package:architect_app/models/responses/login_response.dart';

class GetProjectResponse {
  bool success;
  List<Project> data;
  String message;

  GetProjectResponse({this.success, this.data, this.message});

  GetProjectResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<Project>();
      json['data'].forEach((v) {
        data.add(new Project.fromJson(v));
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

class Project {
  int id;
  int konsultanId;
  String title;
  String slug;
  String description;
  String gayaDesain;
  int hargaDesain;
  int hargaRab;
  String isLelang;
  String createdAt;
  String updatedAt;
  List<Images> images;
  Konsultan konsultan;
  List<ProjectOwn> projectOwn;

  Project(
      {this.id,
      this.konsultanId,
      this.title,
      this.slug,
      this.description,
      this.gayaDesain,
      this.hargaDesain,
      this.hargaRab,
      this.isLelang,
      this.createdAt,
      this.updatedAt,
      this.images,
      this.konsultan,
      this.projectOwn});

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    konsultanId = json['konsultanId'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    gayaDesain = json['gayaDesain'];
    hargaDesain = json['harga_desain'];
    hargaRab = json['harga_rab'];
    isLelang = json['isLelang'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    konsultan = json['konsultan'] != null
        ? new Konsultan.fromJson(json['konsultan'])
        : null;
    if (json['project_own'] != null) {
      projectOwn = new List<ProjectOwn>();
      json['project_own'].forEach((v) {
        projectOwn.add(new ProjectOwn.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['konsultanId'] = this.konsultanId;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['isLelang'] = this.isLelang;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    if (this.konsultan != null) {
      data['konsultan'] = this.konsultan.toJson();
    }
    if (this.projectOwn != null) {
      data['project_own'] = this.projectOwn.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  int id;
  int projectId;
  String image;
  String createdAt;
  String updatedAt;

  Images({this.id, this.projectId, this.image, this.createdAt, this.updatedAt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['projectId'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['projectId'] = this.projectId;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Konsultan {
  int id;
  int userId;
  String telepon;
  String website;
  String instagram;
  String about;
  String createdAt;
  String updatedAt;
  User user;

  Konsultan(
      {this.id,
      this.userId,
      this.telepon,
      this.website,
      this.instagram,
      this.about,
      this.createdAt,
      this.updatedAt,
      this.user});

  Konsultan.fromJson(Map<String, dynamic> json) {
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

class ProjectOwn {
  int id;
  int ownerId;
  int projectId;
  String hasilRab;
  String createdAt;
  String updatedAt;
  Ratings ratings;
  OwnerProjects owner;
  List<Hasil> hasil;

  ProjectOwn(
      {this.id,
      this.ownerId,
      this.projectId,
      this.hasilRab,
      this.createdAt,
      this.updatedAt,
      this.ratings,
      this.owner,
      this.hasil});

  ProjectOwn.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerId = json['ownerId'];
    projectId = json['projectId'];
    hasilRab = json['hasil_rab'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    ratings =
        json['ratings'] != null ? new Ratings.fromJson(json['ratings']) : null;
    owner = json['owner'] != null
        ? new OwnerProjects.fromJson(json['owner'])
        : null;
    if (json['hasil'] != null) {
      hasil = new List<Hasil>();
      json['hasil'].forEach((v) {
        hasil.add(new Hasil.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ownerId'] = this.ownerId;
    data['projectId'] = this.projectId;
    data['hasil_rab'] = this.hasilRab;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.ratings != null) {
      data['ratings'] = this.ratings.toJson();
    }
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    if (this.hasil != null) {
      data['hasil'] = this.hasil.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ratings {
  int id;
  int projectOwnerId;
  int rating;
  String createdAt;
  String updatedAt;

  Ratings(
      {this.id,
      this.projectOwnerId,
      this.rating,
      this.createdAt,
      this.updatedAt});

  Ratings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectOwnerId = json['projectOwnerId'];
    rating = json['rating'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['projectOwnerId'] = this.projectOwnerId;
    data['rating'] = this.rating;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class OwnerProjects {
  int id;
  int userId;
  String telepon;
  String alamat;
  String createdAt;
  String updatedAt;
  User user;

  OwnerProjects(
      {this.id,
      this.userId,
      this.telepon,
      this.alamat,
      this.createdAt,
      this.updatedAt,
      this.user});

  OwnerProjects.fromJson(Map<String, dynamic> json) {
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
