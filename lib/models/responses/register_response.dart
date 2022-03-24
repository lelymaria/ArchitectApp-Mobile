class RegisterResponse {
  bool success;
  RegisterData data;
  String message;

  RegisterResponse({this.success, this.data, this.message});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new RegisterData.fromJson(json['data']) : null;
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

class RegisterData {
  String name;
  String username;
  String email;
  String password;
  String avatar;
  String level;
  String updatedAt;
  String createdAt;
  String file;
  int id;

  RegisterData(
      {this.name,
      this.username,
      this.email,
      this.password,
      this.avatar,
      this.level,
      this.updatedAt,
      this.createdAt,
      this.file,
      this.id});

  RegisterData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    avatar = json['avatar'];
    level = json['level'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    file = json['file'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['avatar'] = this.avatar;
    data['level'] = this.level;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['file'] = this.file;
    data['id'] = this.id;
    return data;
  }
}