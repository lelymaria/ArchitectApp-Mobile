import 'dart:convert';

import 'package:architect_app/models/forms/add_desain_form.dart';
import 'package:architect_app/models/forms/add_proposal_form.dart';
import 'package:architect_app/models/forms/change_password_form.dart';
import 'package:architect_app/models/forms/choose_project_form.dart';
import 'package:architect_app/models/forms/edit_profile_form.dart';
import 'package:architect_app/models/forms/lelang_form.dart';
import 'package:architect_app/models/forms/login_form.dart';
import 'package:architect_app/models/forms/register_form.dart';
import 'package:architect_app/models/forms/upload_hasil_form.dart';
import 'package:architect_app/models/forms/upload_payment_form.dart';
import 'package:architect_app/models/preferences/auth_preference.dart';
// import 'package:architect_app/models/responses/add_lelang_response.dart';
import 'package:architect_app/models/responses/change_password_response.dart';
import 'package:architect_app/models/responses/choose_project_response.dart';
import 'package:architect_app/models/responses/choose_proposal.dart';
import 'package:architect_app/models/responses/get_cabangs_response.dart';
// import 'package:architect_app/models/responses/edit_profile_response.dart';
import 'package:architect_app/models/responses/get_consultant_response.dart';
import 'package:architect_app/models/responses/get_contractor_response.dart';
import 'package:architect_app/models/responses/get_mylelang_response.dart';
import 'package:architect_app/models/responses/get_project_guest.dart';
// import 'package:architect_app/models/responses/get_myproject_response.dart';
import 'package:architect_app/models/responses/get_projects_response.dart';
import 'package:architect_app/models/responses/get_proposal_response.dart';
import 'package:architect_app/models/responses/login_response.dart';
import 'package:architect_app/utils/http_headers.dart';
import 'package:http/http.dart' as http;

class Repository {
  final String baseUrl = "http://arsitekco.proyek.ti.polindra.ac.id/api";
  // final String baseUrl = "http://192.168.42.231:8000/api";
  // final String baseUrl = "http://127.0.0.1:8888/api";
  // final String baseUrl = "http://192.168.18.58:8000/api";

  // final String baseUrl = "http://192.168.100.75:8000/api";

  // final String baseUrl = "http://192.168.123.58:8000/api";
  // final String baseUrl = "http://192.168.43.163:8000/api";

  Future<LoginResponse> postLogin(LoginForm loginData) async {
    final response = await http
        .post(Uri.parse("$baseUrl/login"),
            headers: await HttpHeaders.headers(), body: jsonEncode(loginData))
        .timeout(Duration(seconds: 120));

    final data = jsonDecode(response.body);
    LoginResponse record = LoginResponse.fromJson(data);

    if (response.statusCode == 200) {
      return record;
    } else {
      return record;
    }
  }

  Future<dynamic> postRegister(RegisterForm registerData) async {
    final response = await http
        .post(Uri.parse("$baseUrl/register"),
            headers: await HttpHeaders.headers(),
            body: jsonEncode(registerData))
        .timeout(Duration(seconds: 120));

    final data = jsonDecode(response.body);
    // RegisterResponse record = RegisterResponse.fromJson(data);

    if (response.statusCode == 200) {
      return data;
    } else {
      return data;
    }
  }

  Future<dynamic> postRegisterPro(RegisterForm registerData) async {
    var uri = registerData.level == "konsultan"
        ? Uri.parse("$baseUrl/regiskonsultan")
        : Uri.parse("$baseUrl/regiskontraktor");
    var request = http.MultipartRequest('POST', uri);
    if (registerData.file != null) {
      request.files.add(
          await http.MultipartFile.fromPath('file', registerData.file.path));
    }
    request.fields["name"] = registerData.name;
    request.fields["username"] = registerData.username;
    request.fields["email"] = registerData.email;
    request.fields["password"] = registerData.password;
    request.fields["isActive"] = registerData.isActive.toString();

    request.headers.addAll(await HttpHeaders.headers());
    var response = await request.send();
    var result = await response.stream.bytesToString();

    final data = jsonDecode(result);

    if (response.statusCode == 200) {
      return data;
    } else {
      return data;
    }
  }

  Future<dynamic> logout(AuthPreference authPreference) async {
    String token = await authPreference.getToken();
    final response = await http
        .post(Uri.parse("$baseUrl/logout"),
            headers: await HttpHeaders.headers(token: token))
        .timeout(Duration(seconds: 120));

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    } else {
      return data;
    }
  }

  Future<List<Project>> getProject() async {
    // String token = await authPreference.getToken();
    final response = await http
        .get(
          Uri.parse("$baseUrl/project"),
        )
        .timeout(Duration(seconds: 120));
    print("getProjek ${response.statusCode}");
    final data = jsonDecode(response.body);
    print(data);
    GetProjectResponse record = GetProjectResponse.fromJson(data);

    if (response.statusCode == 200) {
      return record.data;
    } else {
      return record.data;
    }
  }

  Future<List<DataConsultant>> getConsultantFromGuest() async {
    // String token = await authPreference.getToken();
    final response = await http
        .get(
          Uri.parse("$baseUrl/all-konsultan"),
          // headers: await HttpHeaders.headers(token: token)
        )
        .timeout(Duration(seconds: 120));
    print("Konsul ${response.statusCode}");
    final data = jsonDecode(response.body);
    print(data);
    GetConsultantResponse record = GetConsultantResponse.fromJson(data);

    if (response.statusCode == 200) {
      return record.data;
    } else {
      return record.data;
    }
  }

  Future<dynamic> setFirebase(
      AuthPreference authPreference, String firebaseToken) async {
    String token = await authPreference.getToken();
    final response = await http
        .post(Uri.parse("$baseUrl/setfirebase"),
            headers: await HttpHeaders.headers(token: token),
            body: jsonEncode(<String, String>{'firebaseToken': firebaseToken}))
        .timeout(Duration(seconds: 120));

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    } else {
      return data;
    }
  }

  Future<dynamic> editProfile(
      EditProfileForm param, AuthPreference authPreference) async {
    int id = param.userId;
    String token = await authPreference.getToken();
    final response = await http
        .put(Uri.parse("$baseUrl/update-profile/$id"),
            headers: await HttpHeaders.headers(token: token),
            body: jsonEncode(param))
        .timeout(Duration(seconds: 120));

    final data = jsonDecode(response.body);
    // EditProfileResponse record = EditProfileResponse.fromJson(data);

    if (response.statusCode == 200) {
      return data;
    } else {
      return data;
    }
  }

  Future<dynamic> editProfileConsultant(
      EditProfileForm param, AuthPreference authPreference) async {
    int id = param.userId;
    String token = await authPreference.getToken();
    final response = await http
        .put(Uri.parse("$baseUrl/update-profilecons/$id"),
            headers: await HttpHeaders.headers(token: token),
            body: jsonEncode(param))
        .timeout(Duration(seconds: 120));

    final data = jsonDecode(response.body);
    // EditProfileResponse record = EditProfileResponse.fromJson(data);

    if (response.statusCode == 200) {
      return data;
    } else {
      return data;
    }
  }

  Future<ChangePasswordResponse> changePassword(
      ChangePasswordForm param, String token) async {
    int id = param.userId;
    final response = await http
        .put(Uri.parse("$baseUrl/gantipass/$id"),
            headers: await HttpHeaders.headers(token: token),
            body: jsonEncode(param))
        .timeout(Duration(seconds: 120));

    final data = jsonDecode(response.body);
    ChangePasswordResponse record = ChangePasswordResponse.fromJson(data);

    if (response.statusCode == 200) {
      return record;
    } else {
      return record;
    }
  }

  Future<List<DataConsultant>> getConsultant(
      AuthPreference authPreference) async {
    String token = await authPreference.getToken();
    final response = await http
        .get(Uri.parse("$baseUrl/admin/allkonsultan"),
            headers: await HttpHeaders.headers(token: token))
        .timeout(Duration(seconds: 120));

    final data = jsonDecode(response.body);
    GetConsultantResponse record = GetConsultantResponse.fromJson(data);

    if (response.statusCode == 200) {
      return record.data;
    } else {
      return record.data;
    }
  }

  Future<List<DataConsultant>> getConsultantFromOwner(
      AuthPreference authPreference) async {
    String token = await authPreference.getToken();
    final response = await http
        .get(Uri.parse("$baseUrl/owner/allkonsultan"),
            headers: await HttpHeaders.headers(token: token))
        .timeout(Duration(seconds: 120));

    final data = jsonDecode(response.body);
    GetConsultantResponse record = GetConsultantResponse.fromJson(data);

    if (response.statusCode == 200) {
      return record.data;
    } else {
      return record.data;
    }
  }

  Future<List<DataContractor>> getContractor(
      AuthPreference authPreference) async {
    String token = await authPreference.getToken();
    final response = await http
        .get(Uri.parse("$baseUrl/admin/allkontraktor"),
            headers: await HttpHeaders.headers(token: token))
        .timeout(Duration(seconds: 120));

    final data = jsonDecode(response.body);
    GetContractorResponse record = GetContractorResponse.fromJson(data);

    if (response.statusCode == 200) {
      return record.data;
    } else {
      return record.data;
    }
  }

  Future<ChangePasswordResponse> verifPro(
      {int id, int isActive, AuthPreference authPreference}) async {
    String token = await authPreference.getToken();
    final response = await http
        .put(
          Uri.parse("$baseUrl/admin/verificationpro/$id'}"),
          headers: await HttpHeaders.headers(token: token),
          body: jsonEncode(<String, String>{'isActive': isActive.toString()}),
        )
        .timeout(Duration(seconds: 120));

    final data = jsonDecode(response.body);
    ChangePasswordResponse record = ChangePasswordResponse.fromJson(data);

    if (response.statusCode == 200) {
      return record;
    } else {
      return record;
    }
  }

  Future<List<Project>> getProjects(AuthPreference authPreference) async {
    String token = await authPreference.getToken();
    final response = await http
        .get(Uri.parse("$baseUrl/owner/allproject"),
            headers: await HttpHeaders.headers(token: token))
        .timeout(Duration(seconds: 120));

    final data = jsonDecode(response.body);
    GetProjectResponse record = GetProjectResponse.fromJson(data);

    if (response.statusCode == 200) {
      return record.data;
    } else {
      return record.data;
    }
  }

  Future<dynamic> addLelang(
      AuthPreference authPreference, LelangForm form) async {
    String token = await authPreference.getToken();
    var uri = Uri.parse("$baseUrl/owner/postlelang");
    var request = http.MultipartRequest('POST', uri);
    if (form.image != null) {
      for (int i = 0; i < form.image.length; i++) {
        request.files.add(
            await http.MultipartFile.fromPath('image[]', form.image[i].path));
      }
    }
    if (form.inspirasi != null) {
      for (int i = 0; i < form.inspirasi.length; i++) {
        request.files.add(await http.MultipartFile.fromPath(
            'inspirasi[]', form.inspirasi[i].path));
      }
    }
    if (form.telepon != null) {
      request.fields["telepon"] = form.telepon;
    }
    if (form.alamat != null) {
      request.fields["alamat"] = form.alamat;
    }
    request.fields["title"] = form.title;
    request.fields["description"] = form.description;
    request.fields["desain"] = form.desain;
    request.fields["rab"] = form.rab;
    request.fields["budgetFrom"] = form.budgetFrom.toString();
    request.fields["budgetTo"] = form.budgetTo.toString();
    request.fields["panjang"] = form.panjang.toString();
    request.fields["lebar"] = form.lebar.toString();
    request.fields["style"] = form.style;

    request.headers.addAll(await HttpHeaders.headers(token: token));
    var response = await request.send();
    var result = await response.stream.bytesToString();

    final data = jsonDecode(result);
    // AddLelangResponse record = AddLelangResponse.fromJson(data);

    if (response.statusCode == 200) {
      return data;
    } else {
      return data;
    }
  }

  Future<dynamic> addDesain(
      AuthPreference authPreference, AddDesainForm form) async {
    String token = await authPreference.getToken();
    var uri = Uri.parse("$baseUrl/konsultan/addproject");
    var request = http.MultipartRequest('POST', uri);
    if (form.image != null) {
      for (int i = 0; i < form.image.length; i++) {
        request.files.add(
            await http.MultipartFile.fromPath('images[]', form.image[i].path));
      }
    }
    request.fields["title"] = form.title;
    request.fields["desc"] = form.desc;
    request.fields["harga_desain"] = form.hargaDesain.toString();
    request.fields["harga_rab"] = form.hargaRab.toString();
    request.fields["gayaDesain"] = form.gayaDesain;

    request.headers.addAll(await HttpHeaders.headers(token: token));
    var response = await request.send();
    var result = await response.stream.bytesToString();

    final data = jsonDecode(result);
    // AddLelangResponse record = AddLelangResponse.fromJson(data);

    if (response.statusCode == 200) {
      return data;
    } else {
      return data;
    }
  }

  Future<dynamic> getMyLelang(AuthPreference authPreference) async {
    String token = await authPreference.getToken();
    final response = await http
        .get(Uri.parse("$baseUrl/owner/mylelang"),
            headers: await HttpHeaders.headers(token: token))
        .timeout(Duration(seconds: 120));

    final data = jsonDecode(response.body);
    GetMyLelangResponse record = GetMyLelangResponse.fromJson(data);

    if (response.statusCode == 200) {
      return record.data;
    } else {
      return record.data;
    }
  }

  // Future<dynamic> getMyProject(AuthPreference authPreference) async {
  //   String token = await authPreference.getToken();
  //   final response = await http
  //       .get(Uri.parse("$baseUrl/owner/project"),
  //           headers: await HttpHeaders.headers(token: token))
  //       .timeout(Duration(seconds: 120));

  //   final data = jsonDecode(response.body);

  //   if (response.statusCode == 200) {
  //     return data;
  //   } else {
  //     return data;
  //   }
  // }

  Future<dynamic> getMyProject(AuthPreference authPreference) async {
    String token = await authPreference.getToken();
    final response = await http
        .get(Uri.parse("$baseUrl/owner/project"),
            headers: await HttpHeaders.headers(token: token))
        .timeout(Duration(seconds: 120));

    final data = jsonDecode(response.body);
    // GetMyProjectResponse record = GetMyProjectResponse.fromJson(data);

    if (response.statusCode == 200) {
      return data;
    } else {
      return data;
    }
  }

  Future<List<MyLelang>> getLelangOwner(AuthPreference authPreference) async {
    String token = await authPreference.getToken();
    final response = await http
        .get(Uri.parse("$baseUrl/konsultan/alllelang"),
            headers: await HttpHeaders.headers(token: token))
        .timeout(Duration(seconds: 120));

    final data = jsonDecode(response.body);
    GetMyLelangResponse record = GetMyLelangResponse.fromJson(data);

    if (response.statusCode == 200) {
      return record.data;
    } else {
      return record.data;
    }
  }

  Future<dynamic> postProposal(
      AuthPreference authPreference, AddProposalForm form) async {
    String token = await authPreference.getToken();
    var uri = Uri.parse("$baseUrl/konsultan/addproposal");
    var request = http.MultipartRequest('POST', uri);
    if (form.cv != null) {
      request.files.add(await http.MultipartFile.fromPath('cv', form.cv.path));
    }
    if (form.alamat != null) {
      request.fields["alamat"] = form.alamat;
    }
    request.fields["projectId"] = form.lelangId.toString();
    if (form.telepon != null) {
      request.fields["telepon"] = form.telepon;
    }
    request.fields["lelangId"] = form.lelangId.toString();
    request.fields["coverLetter"] = form.coverLetter;
    request.fields["tawaranDesain"] = form.tawaranDesain.toString();
    request.fields["tawaranRab"] = form.tawaranRab.toString();

    request.headers.addAll(await HttpHeaders.headers(token: token));
    var response = await request.send();
    var result = await response.stream.bytesToString();

    final data = jsonDecode(result);

    if (response.statusCode == 200) {
      return data;
    } else {
      return data;
    }
  }

  Future<List<DataProposal>> getProposalByOwner(
      AuthPreference authPreference, int lelangId) async {
    String token = await authPreference.getToken();
    final response = await http
        .post(Uri.parse("$baseUrl/owner/mylelang/proposal"),
            headers: await HttpHeaders.headers(token: token),
            body: jsonEncode(<String, String>{'lelangId': lelangId.toString()}))
        .timeout(Duration(seconds: 120));

    final res = jsonDecode(response.body);
    GetProposalResponse record = GetProposalResponse.fromJson(res);

    if (response.statusCode == 200) {
      return record.data;
    } else {
      return record.data;
    }
  }

  Future<ChooseProposalResponse> chooseProposal(
      AuthPreference authPreference, int proposalId, int lelangOwnerId) async {
    String token = await authPreference.getToken();
    final response = await http
        .post(Uri.parse("$baseUrl/owner/proposal/choose"),
            headers: await HttpHeaders.headers(token: token),
            body: jsonEncode(<String, String>{
              'proposalId': proposalId.toString(),
              'lelangId': lelangOwnerId.toString()
            }))
        .timeout(Duration(seconds: 120));

    final data = jsonDecode(response.body);
    ChooseProposalResponse record = ChooseProposalResponse.fromJson(data);

    if (response.statusCode == 200) {
      return record;
    } else {
      return record;
    }
  }

  Future<dynamic> uploadPayment(
      AuthPreference authPreference, UploadPaymentForm form) async {
    String token = await authPreference.getToken();
    var uri = Uri.parse("$baseUrl/owner/upload/payment");
    var request = http.MultipartRequest('POST', uri);
    if (form.bukti != null) {
      request.files
          .add(await http.MultipartFile.fromPath('bukti', form.bukti.path));
    }
    request.fields["kontrakId"] = form.kontrakId.toString();

    request.headers.addAll(await HttpHeaders.headers(token: token));
    var response = await request.send();
    var result = await response.stream.bytesToString();

    final data = jsonDecode(result);

    if (response.statusCode == 200) {
      return data;
    } else {
      return data;
    }
  }

  Future<dynamic> getPaymentConsultant(AuthPreference authPreference) async {
    String token = await authPreference.getToken();
    final response = await http
        .get(Uri.parse("$baseUrl/admin/paymentKonsultan"),
            headers: await HttpHeaders.headers(token: token))
        .timeout(Duration(seconds: 120));

    final res = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return res;
    } else {
      return res;
    }
  }

  Future<dynamic> verifPayment(
      {int paymentId, AuthPreference authPreference}) async {
    String token = await authPreference.getToken();
    final response = await http
        .post(Uri.parse("$baseUrl/admin/verifikasi/payment"),
            headers: await HttpHeaders.headers(token: token),
            body:
                jsonEncode(<String, String>{'paymentId': paymentId.toString()}))
        .timeout(Duration(seconds: 120));

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    } else {
      return data;
    }
  }

  Future<dynamic> getAllProposal(
      AuthPreference authPreference, int status) async {
    String token = await authPreference.getToken();
    final response = await http
        .post(Uri.parse("$baseUrl/konsultan/allproposal"),
            headers: await HttpHeaders.headers(token: token),
            body: jsonEncode(<String, String>{'status': status.toString()}))
        .timeout(Duration(seconds: 120));

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    } else {
      return data;
    }
  }

  /* Semua Project by Konsultan */
  Future<dynamic> getProjectCons(AuthPreference authPreference) async {
    String token = await authPreference.getToken();
    final response = await http
        .get(Uri.parse("$baseUrl/konsultan/myproject"),
            headers: await HttpHeaders.headers(token: token))
        .timeout(Duration(seconds: 120));

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    } else {
      return data;
    }
  }

  Future<List<Project>> getAllProjectCons(
      AuthPreference authPreference, String isLelang) async {
    String token = await authPreference.getToken();
    final response = await http
        .post(Uri.parse("$baseUrl/konsultan/allmyproject"),
            headers: await HttpHeaders.headers(token: token),
            body: jsonEncode(<String, String>{'isLelang': isLelang}))
        .timeout(Duration(seconds: 120));

    final data = jsonDecode(response.body);
    GetProjectResponse record = GetProjectResponse.fromJson(data);

    if (response.statusCode == 200) {
      return record.data;
    } else {
      return record.data;
    }
  }

  Future<dynamic> uploadHasil(
      AuthPreference authPreference, UploadHasilForm form) async {
    String token = await authPreference.getToken();
    var uri = Uri.parse("$baseUrl/konsultan/uploadHasil");
    var request = http.MultipartRequest('POST', uri);
    if (form.softfile != null) {
      for (int i = 0; i < form.softfile.length; i++) {
        request.files.add(await http.MultipartFile.fromPath(
            'softfile[]', form.softfile[i].path));
      }
    }
    if (form.rab != null) {
      request.files
          .add(await http.MultipartFile.fromPath('rab', form.rab.path));
    }
    request.fields["projectOwnerId"] = form.projectOwnerId.toString();

    request.headers.addAll(await HttpHeaders.headers(token: token));
    var response = await request.send();
    var result = await response.stream.bytesToString();

    final data = jsonDecode(result);

    if (response.statusCode == 200) {
      return data;
    } else {
      return data;
    }
  }

  Future<dynamic> rating(
      {int projectOwnerId, int rating, AuthPreference authPreference}) async {
    String token = await authPreference.getToken();
    final response = await http
        .post(Uri.parse("$baseUrl/owner/project/rating"),
            headers: await HttpHeaders.headers(token: token),
            body: rating != null
                ? jsonEncode(<String, String>{
                    'projectOwnerId': projectOwnerId.toString(),
                    'rating': rating.toString(),
                  })
                : jsonEncode(<String, String>{
                    'projectOwnerId': projectOwnerId.toString(),
                  }))
        .timeout(Duration(seconds: 120));

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    } else {
      return data;
    }
  }

  Future<ChooseProjectResponse> chooseProject(
      AuthPreference authPreference, ChooseProjectForm form) async {
    String token = await authPreference.getToken();
    var uri = Uri.parse("$baseUrl/owner/choose/project");
    var request = http.MultipartRequest('POST', uri);
    if (form.image != null) {
      for (int i = 0; i < form.image.length; i++) {
        request.files.add(
            await http.MultipartFile.fromPath('image[]', form.image[i].path));
      }
    }
    if (form.telepon != null) {
      request.fields["telepon"] = form.telepon;
    }
    if (form.alamat != null) {
      request.fields["alamat"] = form.alamat;
    }
    request.fields["projectId"] = form.projectId.toString();
    request.fields["userId"] = form.userId.toString();
    request.fields["desain"] = form.desain;
    request.fields["rab"] = form.rab;
    request.fields["panjang"] = form.panjang.toString();
    request.fields["lebar"] = form.lebar.toString();

    request.headers.addAll(await HttpHeaders.headers(token: token));
    var response = await request.send();
    var result = await response.stream.bytesToString();

    final data = jsonDecode(result);
    ChooseProjectResponse record = ChooseProjectResponse.fromJson(data);

    if (response.statusCode == 200) {
      // if (form.telepon != null || form.alamat != null) {
      //   await authPreference.setUserData(record.data[0].owner.user);
      // }
      return record;
    } else {
      return record;
    }
  }

  Future<dynamic> uploadProject(
      {AuthPreference authPreference,
      int projectId,
      String title,
      String description}) async {
    String token = await authPreference.getToken();
    final response = await http
        .post(Uri.parse("$baseUrl/konsultan/upload/hasil-project"),
            headers: await HttpHeaders.headers(token: token),
            body: jsonEncode(<String, String>{
              'projectId': projectId.toString(),
              'title': title,
              'description': description,
            }))
        .timeout(Duration(seconds: 120));

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    } else {
      return data;
    }
  }

  Future<dynamic> getDataOwner(AuthPreference authPreference) async {
    String token = await authPreference.getToken();
    final response = await http
        .get(Uri.parse("$baseUrl/owner/getdataowner"),
            headers: await HttpHeaders.headers(token: token))
        .timeout(Duration(seconds: 120));

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    } else {
      return data;
    }
  }

  Future<dynamic> getDataKonsultan(AuthPreference authPreference) async {
    String token = await authPreference.getToken();
    final response = await http
        .get(Uri.parse("$baseUrl/konsultan/getdatakonsultan"),
            headers: await HttpHeaders.headers(token: token))
        .timeout(Duration(seconds: 120));

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    } else {
      return data;
    }
  }

  Future<dynamic> saveFavorite(
      AuthPreference authPreference, int projectId) async {
    String token = await authPreference.getToken();
    final response = await http
        .post(Uri.parse("$baseUrl/owner/simpan/project"),
            headers: await HttpHeaders.headers(token: token),
            body:
                jsonEncode(<String, String>{'projectId': projectId.toString()}))
        .timeout(Duration(seconds: 120));

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    } else {
      return data;
    }
  }

  Future<List<DataContractor>> getContractorFromOwner(
      AuthPreference authPreference) async {
    String token = await authPreference.getToken();
    final response = await http
        .get(Uri.parse("$baseUrl/owner/allkontraktor"),
            headers: await HttpHeaders.headers(token: token))
        .timeout(Duration(seconds: 120));

    final data = jsonDecode(response.body);
    // print(data);
    GetContractorResponse record = GetContractorResponse.fromJson(data);

    if (response.statusCode == 200) {
      return record.data;
    } else {
      return record.data;
    }
  }

  Future<List<Cabang>> getCabangs(AuthPreference authPreference) async {
    String token = await authPreference.getToken();
    final response = await http
        .get(Uri.parse("$baseUrl/owner/allcabang"),
            headers: await HttpHeaders.headers(token: token))
        .timeout(Duration(seconds: 120));

    final data = jsonDecode(response.body);
    GetCabangResponse record = GetCabangResponse.fromJson(data);

    if (response.statusCode == 200) {
      return record.data;
    } else {
      return record.data;
    }
  }
}
