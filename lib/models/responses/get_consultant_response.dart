import 'package:architect_app/models/responses/get_projects_response.dart';

class GetConsultantResponse {
  bool success;
  List<DataConsultant> data;
  String message;

  GetConsultantResponse({this.success, this.data, this.message});

  GetConsultantResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<DataConsultant>();
      json['data'].forEach((v) {
        data.add(new DataConsultant.fromJson(v));
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

class DataConsultant {
  int id;
  int userId;
  String telepon;
  String website;
  String instagram;
  String about;
  String createdAt;
  String updatedAt;
  UserConsultant user;
  List<FilesConsultant> files;
  List<Project> projects;

  DataConsultant(
      {this.id,
      this.userId,
      this.telepon,
      this.website,
      this.instagram,
      this.about,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.files,
      this.projects});

  DataConsultant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    telepon = json['telepon'];
    website = json['website'];
    instagram = json['instagram'];
    about = json['about'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user =
        json['user'] != null ? new UserConsultant.fromJson(json['user']) : null;
    if (json['files'] != null) {
      files = new List<FilesConsultant>();
      json['files'].forEach((v) {
        files.add(new FilesConsultant.fromJson(v));
      });
    }
    if (json['projects'] != null) {
      projects = new List<Project>();
      json['projects'].forEach((v) {
        projects.add(new Project.fromJson(v));
      });
    }
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
    if (this.files != null) {
      data['files'] = this.files.map((v) => v.toJson()).toList();
    }
    if (this.projects != null) {
      data['projects'] = this.projects.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserConsultant {
  int id;
  String name;
  String username;
  String email;
  String password;
  String avatar;
  int isActive;
  String level;
  String fireBaseToken;
  String lastLogin;
  String createdAt;
  String updatedAt;

  UserConsultant(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.password,
      this.avatar,
      this.isActive,
      this.level,
      this.fireBaseToken,
      this.lastLogin,
      this.createdAt,
      this.updatedAt});

  UserConsultant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    avatar = json['avatar'];
    isActive = json['is_active'];
    level = json['level'];
    fireBaseToken = json['fireBaseToken'];
    lastLogin = json['last_login'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['avatar'] = this.avatar;
    data['is_active'] = this.isActive;
    data['level'] = this.level;
    data['fireBaseToken'] = this.fireBaseToken;
    data['last_login'] = this.lastLogin;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class FilesConsultant {
  int id;
  int konsultanId;
  String file;
  String createdAt;
  String updatedAt;

  FilesConsultant(
      {this.id, this.konsultanId, this.file, this.createdAt, this.updatedAt});

  FilesConsultant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    konsultanId = json['konsultanId'];
    file = json['file'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['konsultanId'] = this.konsultanId;
    data['file'] = this.file;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

// class Projects {
//   int id;
//   int konsultanId;
//   String title;
//   String slug;
//   String description;
//   String createdAt;
//   String updatedAt;
//   List<Images> images;

//   Projects(
//       {this.id,
//       this.konsultanId,
//       this.title,
//       this.slug,
//       this.description,
//       this.createdAt,
//       this.updatedAt,
//       this.images});

//   Projects.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     konsultanId = json['konsultanId'];
//     title = json['title'];
//     slug = json['slug'];
//     description = json['description'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     if (json['images'] != null) {
//       images = new List<Images>();
//       json['images'].forEach((v) {
//         images.add(new Images.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['konsultanId'] = this.konsultanId;
//     data['title'] = this.title;
//     data['slug'] = this.slug;
//     data['description'] = this.description;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.images != null) {
//       data['images'] = this.images.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

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
