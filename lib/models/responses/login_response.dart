class LoginResponse {
  bool success;
  UserData data;
  String message;

  LoginResponse({this.success, this.data, this.message});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
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

class UserData {
  String token;
  User user;

  UserData({this.token, this.user});

  UserData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

/* Backend User */
class User {
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
  Owner owner;
  Konsultan konsultan;
  Kontraktor kontraktor;

  User(
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
      this.updatedAt,
      this.owner,
      this.konsultan,
      this.kontraktor});

  User.fromJson(Map<String, dynamic> json) {
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
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    konsultan = json['konsultan'] != null
        ? new Konsultan.fromJson(json['konsultan'])
        : null;
    kontraktor = json['kontraktor'] != null
        ? new Kontraktor.fromJson(json['kontraktor'])
        : null;
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
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    if (this.konsultan != null) {
      data['konsultan'] = this.konsultan.toJson();
    }
    if (this.kontraktor != null) {
      data['kontraktor'] = this.kontraktor.toJson();
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

  Owner(
      {this.id,
      this.userId,
      this.telepon,
      this.alamat,
      this.createdAt,
      this.updatedAt});

  Owner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    telepon = json['telepon'];
    alamat = json['alamat'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['telepon'] = this.telepon;
    data['alamat'] = this.alamat;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Konsultan {
  int id;
  int userId;
  String telepon;
  String alamat;
  String website;
  String instagram;
  String about;
  String createdAt;
  String updatedAt;

  Konsultan(
      {this.id,
      this.userId,
      this.telepon,
      this.alamat,
      this.website,
      this.instagram,
      this.about,
      this.createdAt,
      this.updatedAt});

  Konsultan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    telepon = json['telepon'];
    alamat = json['alamat'];
    website = json['website'];
    instagram = json['instagram'];
    about = json['about'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['telepon'] = this.telepon;
    data['alamat'] = this.alamat;
    data['website'] = this.website;
    data['instagram'] = this.instagram;
    data['about'] = this.about;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Kontraktor {
  int id;
  int userId;
  String telepon;
  String website;
  String instagram;
  String about;
  String createdAt;
  String updatedAt;

  Kontraktor(
      {this.id,
      this.userId,
      this.telepon,
      this.website,
      this.instagram,
      this.about,
      this.createdAt,
      this.updatedAt});

  Kontraktor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    telepon = json['telepon'];
    website = json['website'];
    instagram = json['instagram'];
    about = json['about'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    return data;
  }
}
