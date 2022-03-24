class ChangePasswordForm {
  int userId;
  String newpass;
  String newpassConfirm;

  ChangePasswordForm({this.userId, this.newpass, this.newpassConfirm});

  ChangePasswordForm.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    newpass = json['newpass'];
    newpassConfirm = json['newpass_confirmation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['newpass'] = this.newpass;
    data['newpass_confirmation'] = this.newpassConfirm;
    return data;
  }
}