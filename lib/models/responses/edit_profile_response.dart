class EditProfileResponse {
  bool success;
  Data data;
  String message;

  EditProfileResponse({this.success, this.data, this.message});

  EditProfileResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  int id;
  String name;
  String email;
  Null emailVerifiedAt;
  String password;
  String createdAt;
  String updatedAt;
  String username;
  String avatar;
  Null googleId;
  Null lastLogin;
  String level;

  Data(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.password,
      this.createdAt,
      this.updatedAt,
      this.username,
      this.avatar,
      this.googleId,
      this.lastLogin,
      this.level});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    password = json['password'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    username = json['username'];
    avatar = json['avatar'];
    googleId = json['google_id'];
    lastLogin = json['last_login'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['password'] = this.password;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['username'] = this.username;
    data['avatar'] = this.avatar;
    data['google_id'] = this.googleId;
    data['last_login'] = this.lastLogin;
    data['level'] = this.level;
    return data;
  }
}
