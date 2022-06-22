import 'package:architect_app/models/responses/login_response.dart';

class GetCabangResponse {
  bool success;
  List<Cabang> data;
  String message;

  GetCabangResponse({this.success, this.data, this.message});

  GetCabangResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<Cabang>();
      json['data'].forEach((v) {
        data.add(new Cabang.fromJson(v));
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

class Cabang {
  int id;
  int kontraktorId;
  String namaTim;
  String slug;
  String description;
  String alamatCabang;
  int jumlahTim;
  int hargaKontrak;
  String isLelang;
  String createdAt;
  String updatedAt;
  List<Images> images;
  Kontraktor kontraktor;
  List<CabangOwn> cabangOwn;

  Cabang(
      {this.id,
      this.kontraktorId,
      this.namaTim,
      this.slug,
      this.description,
      this.alamatCabang,
      this.jumlahTim,
      this.hargaKontrak,
      this.isLelang,
      this.createdAt,
      this.updatedAt,
      this.images,
      this.kontraktor,
      this.cabangOwn});

  Cabang.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kontraktorId = json['kontraktorId'];
    namaTim = json['nama_tim'];
    slug = json['slug'];
    description = json['description'];
    alamatCabang = json['alamat_cabang'];
    jumlahTim = json['jumlah_tim'];
    hargaKontrak = json['harga_kontrak'];
    isLelang = json['isLelang'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    kontraktor = json['kontraktor'] != null
        ? new Kontraktor.fromJson(json['kontraktor'])
        : null;
    if (json['cabang_own'] != null) {
      // cabangOwn = new List<CabangOwn>();
      json['cabang_own'].forEach((v) {
        cabangOwn.add(new CabangOwn.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kontraktorId'] = this.kontraktorId;
    data['nama_tim'] = this.namaTim;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['isLelang'] = this.isLelang;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    if (this.kontraktor != null) {
      data['kontraktor'] = this.kontraktor.toJson();
    }
    if (this.cabangOwn != null) {
      data['cabang_own'] = this.cabangOwn.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  int id;
  int cabangKontraktorId;
  String image;
  String createdAt;
  String updatedAt;

  Images(
      {this.id,
      this.cabangKontraktorId,
      this.image,
      this.createdAt,
      this.updatedAt});

  Images.fromJson(Map<String, dynamic> json) {
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

class Kontraktor {
  int id;
  int userId;
  String telepon;
  String website;
  String instagram;
  String about;
  String createdAt;
  String updatedAt;
  User user;

  Kontraktor(
      {this.id,
      this.userId,
      this.telepon,
      this.website,
      this.instagram,
      this.about,
      this.createdAt,
      this.updatedAt,
      this.user});

  Kontraktor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    telepon = json['telepon'];
    website = json['website'];
    instagram = json['instagram'];
    about = json['about'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
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
    return data;
  }
}

class CabangOwn {
  int id;
  int ownerId;
  int konstruksiId;
  String konfirmasi;
  String createdAt;
  String updatedAt;
  // Ratings ratings;
  OwnerCabangs owner;
  // List<Hasil> hasil;

  CabangOwn({
    this.id,
    this.ownerId,
    this.konstruksiId,
    this.konfirmasi,
    this.createdAt,
    this.updatedAt,
    // this.ratings,
    this.owner,
    // this.hasil
  });

  CabangOwn.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerId = json['ownerId'];
    konstruksiId = json['konstruksiId'];
    konfirmasi = json['konfirmasi'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    // ratings =
    //     json['ratings'] != null ? new Ratings.fromJson(json['ratings']) : null;
    owner =
        json['owner'] != null ? new OwnerCabangs.fromJson(json['owner']) : null;
    // if (json['hasil'] != null) {
    //   hasil = new List<Hasil>();
    //   json['hasil'].forEach((v) {
    //     hasil.add(new Hasil.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ownerId'] = this.ownerId;
    data['konstruksiId'] = this.konstruksiId;
    data['konfirmasi'] = this.konfirmasi;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    // if (this.ratings != null) {
    //   data['ratings'] = this.ratings.toJson();
    // }
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    // if (this.hasil != null) {
    //   data['hasil'] = this.hasil.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

// class Ratings {
//   int id;
//   int cabangOwnerId;
//   int rating;
//   String createdAt;
//   String updatedAt;

//   Ratings(
//       {this.id,
//       this.cabangOwnerId,
//       this.rating,
//       this.createdAt,
//       this.updatedAt});

//   Ratings.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     cabangOwnerId = json['CabangOwnerId'];
//     rating = json['rating'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['CabangOwnerId'] = this.cabangOwnerId;
//     data['rating'] = this.rating;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }

class OwnerCabangs {
  int id;
  int userId;
  String telepon;
  String alamat;
  String createdAt;
  String updatedAt;
  User user;

  OwnerCabangs(
      {this.id,
      this.userId,
      this.telepon,
      this.alamat,
      this.createdAt,
      this.updatedAt,
      this.user});

  OwnerCabangs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    telepon = json['telepon'];
    alamat = json['alamat'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
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
