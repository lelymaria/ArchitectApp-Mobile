class LoginForm {
  String email;
  String password;
  String firebaseToken;

  LoginForm({this.email, this.password, this.firebaseToken});

  LoginForm.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    firebaseToken = json['firebaseToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['firebaseToken'] = this.firebaseToken;
    return data;
  }
}
