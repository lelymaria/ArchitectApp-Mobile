import 'package:architect_app/models/responses/get_cabangs_response.dart';

class GetContractorResponse {
  bool success;
  List<DataContractor> data;
  String message;

  GetContractorResponse({this.success, this.data, this.message});

  GetContractorResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<DataContractor>();
      json['data'].forEach((v) {
        data.add(new DataContractor.fromJson(v));
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

class DataContractor {
  int id;
  int userId;
  String telepon;
  String website;
  String instagram;
  String about;
  String createdAt;
  String updatedAt;
  UserContractor user;
  List<FilesContractor> files;
  List<Cabang> cabangs;

  DataContractor(
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
      this.cabangs});

  DataContractor.fromJson(Map<String, dynamic> json) {
    // print(" data cabang :${json['cabang']}");
    // json['cabang'].forEach(
    //   (v){
    //     cabangs.add(
    //       Cabang.fromJson(v)
    //     );
    //   }
    // );
    id = json['id'];
    userId = json['userId'];
    telepon = json['telepon'];
    website = json['website'];
    instagram = json['instagram'];
    about = json['about'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user =
        json['user'] != null ? new UserContractor.fromJson(json['user']) : null;
    if (json['files'] != null) {
      files = new List<FilesContractor>();
      json['files'].forEach((v) {
        files.add(new FilesContractor.fromJson(v));
      });
    }
   
      cabangs = json['cabang'].forEach((v) {
        cabangs.add( Cabang.fromJson(v));
      }
      );
  
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
    if (this.cabangs != null) {
      data['cabang'] = this.cabangs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserContractor {
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

  UserContractor(
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

  UserContractor.fromJson(Map<String, dynamic> json) {
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

class FilesContractor {
  int id;
  int kontraktorId;
  String file;
  String createdAt;
  String updatedAt;

  FilesContractor(
      {this.id, this.kontraktorId, this.file, this.createdAt, this.updatedAt});

  FilesContractor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kontraktorId = json['kontraktorId'];
    file = json['file'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kontraktorId'] = this.kontraktorId;
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

class ImagesContractor {
  int id;
  int cabangKontraktorId;
  String image;
  String createdAt;
  String updatedAt;

  ImagesContractor({this.id, this.cabangKontraktorId, this.image, this.createdAt, this.updatedAt});

  ImagesContractor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cabangKontraktorId = json['cabangKontraktorId'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cabangKontraktorId'] = this.cabangKontraktorId;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}



// class GetContractorResponse {
//   bool success;
//   List<DataContractor> data;
//   String message;

//   GetContractorResponse({this.success, this.data, this.message});

//   GetContractorResponse.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     if (json['data'] != null) {
//       data = new List<DataContractor>();
//       json['data'].forEach((v) {
//         data.add(new DataContractor.fromJson(v));
//       });
//     }
//     message = json['message'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     if (this.data != null) {
//       data['data'] = this.data.map((v) => v.toJson()).toList();
//     }
//     data['message'] = this.message;
//     return data;
//   }
// }

// class DataContractor {
//   int id;
//   int userId;
//   Null telepon;
//   Null website;
//   Null instagram;
//   Null about;
//   String createdAt;
//   String updatedAt;
//   User user;
//   List<FilesContractor> files;

//   DataContractor(
//       {this.id,
//       this.userId,
//       this.telepon,
//       this.website,
//       this.instagram,
//       this.about,
//       this.createdAt,
//       this.updatedAt,
//       this.user,
//       this.files});

//   DataContractor.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['userId'];
//     telepon = json['telepon'];
//     website = json['website'];
//     instagram = json['instagram'];
//     about = json['about'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//     if (json['files'] != null) {
//       files = new List<FilesContractor>();
//       json['files'].forEach((v) {
//         files.add(new FilesContractor.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['userId'] = this.userId;
//     data['telepon'] = this.telepon;
//     data['website'] = this.website;
//     data['instagram'] = this.instagram;
//     data['about'] = this.about;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.user != null) {
//       data['user'] = this.user.toJson();
//     }
//     if (this.files != null) {
//       data['files'] = this.files.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class User {
//   int id;
//   String name;
//   String username;
//   String email;
//   String password;
//   String avatar;
//   int isActive;
//   String level;
//   String fireBaseToken;
//   Null lastLogin;
//   String createdAt;
//   String updatedAt;

//   User(
//       {this.id,
//       this.name,
//       this.username,
//       this.email,
//       this.password,
//       this.avatar,
//       this.isActive,
//       this.level,
//       this.fireBaseToken,
//       this.lastLogin,
//       this.createdAt,
//       this.updatedAt});

//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     username = json['username'];
//     email = json['email'];
//     password = json['password'];
//     avatar = json['avatar'];
//     isActive = json['is_active'];
//     level = json['level'];
//     fireBaseToken = json['fireBaseToken'];
//     lastLogin = json['last_login'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['username'] = this.username;
//     data['email'] = this.email;
//     data['password'] = this.password;
//     data['avatar'] = this.avatar;
//     data['is_active'] = this.isActive;
//     data['level'] = this.level;
//     data['fireBaseToken'] = this.fireBaseToken;
//     data['last_login'] = this.lastLogin;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }

// class FilesContractor {
//   int id;
//   int kontraktorId;
//   String file;
//   String createdAt;
//   String updatedAt;

//   FilesContractor(
//       {this.id, this.kontraktorId, this.file, this.createdAt, this.updatedAt});

//   FilesContractor.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     kontraktorId = json['kontraktorId'];
//     file = json['file'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['kontraktorId'] = this.kontraktorId;
//     data['file'] = this.file;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
