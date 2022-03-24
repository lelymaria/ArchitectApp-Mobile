class EditProfileForm {
  int userId;
  String name;
  String telepon;
  String alamat;
  String website;
  String about;
  String instagram;

  EditProfileForm({this.userId, this.telepon, this.name, this.alamat, this.about, this.website, this.instagram});

  EditProfileForm.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    telepon = json['telepon'];
    name = json['name'];
    alamat = json['alamat'];
    about = json['about'];
    instagram = json['instagram'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['telepon'] = this.telepon;
    data['name'] = this.name;
    data['alamat'] = this.alamat;
    data['about'] = this.about;
    data['instagram'] = this.instagram;
    data['website'] = this.website;
    return data;
  }
}