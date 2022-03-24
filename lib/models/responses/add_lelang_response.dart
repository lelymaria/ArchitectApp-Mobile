class AddLelangResponse {
  bool success;
  List<Lelang> data;
  String message;

  AddLelangResponse({this.success, this.data, this.message});

  AddLelangResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<Lelang>();
      json['data'].forEach((v) {
        data.add(new Lelang.fromJson(v));
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

class Lelang {
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
  String luas;
  String createdAt;
  String updatedAt;
  OwnerLelang owner;

  Lelang(
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
      this.luas,
      this.createdAt,
      this.updatedAt,
      this.owner});

  Lelang.fromJson(Map<String, dynamic> json) {
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
    luas = json['luas'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    owner = json['owner'] != null ? new OwnerLelang.fromJson(json['owner']) : null;
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
    data['luas'] = this.luas;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    return data;
  }
}

class OwnerLelang {
  int id;
  int userId;
  String telepon;
  String alamat;
  String createdAt;
  String updatedAt;
  UserLelang user;

  OwnerLelang(
      {this.id,
      this.userId,
      this.telepon,
      this.alamat,
      this.createdAt,
      this.updatedAt,
      this.user});

  OwnerLelang.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    telepon = json['telepon'];
    alamat = json['alamat'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new UserLelang.fromJson(json['user']) : null;
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

class UserLelang {
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
  Owners owner;

  UserLelang(
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
      this.owner});

  UserLelang.fromJson(Map<String, dynamic> json) {
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
    owner = json['owner'] != null ? new Owners.fromJson(json['owner']) : null;
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
    return data;
  }
}

class Owners {
  int id;
  int userId;
  String telepon;
  String alamat;
  String createdAt;
  String updatedAt;

  Owners(
      {this.id,
      this.userId,
      this.telepon,
      this.alamat,
      this.createdAt,
      this.updatedAt});

  Owners.fromJson(Map<String, dynamic> json) {
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
