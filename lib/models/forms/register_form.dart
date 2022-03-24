import 'dart:io';

class RegisterForm {
  String name;
  String username;
  String email;
  String password;
  String level;
  int isActive;
  File file;

  RegisterForm({this.name, this.username, this.email, this.password, this.level, this.isActive, this.file});

  RegisterForm.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    level = json['level'];
    isActive = json['isActive'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['level'] = this.level;
    data['isActive'] = this.isActive;
    data['file'] = this.file;
    return data;
  }

}