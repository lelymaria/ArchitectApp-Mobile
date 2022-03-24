import 'package:another_flushbar/flushbar.dart';
import 'package:architect_app/models/forms/edit_profile_form.dart';
import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/models/repositories/repository.dart';
import 'package:architect_app/models/responses/login_response.dart';
import 'package:architect_app/utils/validations.dart';
import 'package:architect_app/views/main_page.dart';
import 'package:flutter/material.dart';
import 'package:architect_app/constants/theme.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditProfileConsultant extends StatefulWidget {
  final AuthPreference authPreference;
  final User user;

  EditProfileConsultant(this.authPreference, this.user);

  @override
  _EditProfileConsultantState createState() => _EditProfileConsultantState();
}

class _EditProfileConsultantState extends State<EditProfileConsultant> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _telepon = TextEditingController();
  final _alamat = TextEditingController();
  final _about = TextEditingController();
  final _website = TextEditingController();
  final _instagram = TextEditingController();
  final Repository _repository = Repository();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  String imageUrl;
  int _userId;
  bool isLoading = false;

  _initialize() async {
    try {
      // var data = await widget.authPreference.getUserData();
      setState(() {
        _name.text = widget.user.name;
        _telepon.text = widget.user.konsultan.telepon;
        _alamat.text = widget.user.konsultan.alamat;
        _instagram.text = widget.user.konsultan.instagram;
        _website.text = widget.user.konsultan.website;
        _about.text = widget.user.konsultan.about;
        imageUrl = widget.user.avatar;
        _userId = widget.user.id;
      });
    } catch (e) {}
  }

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(
            "Edit Profile",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: SafeArea(child: _buildContent(context)),
        bottomNavigationBar: SafeArea(
          child: Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: isLoading
                ? loadingIndicator
                : ElevatedButton(
                    onPressed: () {
                      _onEditClicked();
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.amber),
                    child: Text("Edit Profile"),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: defaultMargin),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nama",
                    style: blackFontStyle3.copyWith(fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: _name,
                    validator: Validations.emptyValidation,
                    decoration: InputDecoration(
                      hintStyle: greyFontStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Telepon",
                    style: blackFontStyle2.copyWith(fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: _telepon,
                    keyboardType: TextInputType.number,
                    validator: Validations.emptyValidation,
                    decoration: InputDecoration(
                      hintStyle: greyFontStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Alamat",
                    style: blackFontStyle2.copyWith(fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: _alamat,
                    validator: Validations.emptyValidation,
                    decoration: InputDecoration(
                      hintStyle: greyFontStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Tentang",
                    style: blackFontStyle2.copyWith(fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: _about,
                    maxLines: 5,
                    validator: Validations.emptyValidation,
                    decoration: InputDecoration(
                      hintStyle: greyFontStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Instagram",
                    style: blackFontStyle2.copyWith(fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: _instagram,
                    // validator: Validations.emptyValidation,
                    decoration: InputDecoration(
                      hintStyle: greyFontStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Website",
                    style: blackFontStyle2.copyWith(fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: _website,
                    // validator: Validations.emptyValidation,
                    decoration: InputDecoration(
                      hintStyle: greyFontStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _onEditClicked() {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      setState(() {
        isLoading = true;
      });
      try {
        _repository
            .editProfileConsultant(
                EditProfileForm(
                  userId: _userId,
                  name: _name.text,
                  telepon: _telepon.text != widget.user.konsultan.telepon
                      ? _telepon.text
                      : null,
                  alamat: _alamat.text != widget.user.konsultan.alamat
                      ? _alamat.text
                      : null,
                  about: _about.text != widget.user.konsultan.about
                      ? _about.text
                      : null,
                  instagram: _instagram.text != widget.user.konsultan.instagram
                      ? _instagram.text
                      : null,
                  website: _website.text != widget.user.konsultan.website
                      ? _website.text
                      : null,
                ),
                widget.authPreference)
            .then((value) {
          if (value['success'] == true) {
            setState(() {
              isLoading = false;
            });
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MainPage(initialPage: 3)));
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Flushbar(
                flushbarStyle: FlushbarStyle.FLOATING,
                flushbarPosition: FlushbarPosition.TOP,
                backgroundColor: Colors.green,
                message: "Berhasil mengedit profile",
                icon: Icon(
                  FontAwesomeIcons.checkCircle,
                  size: 28.0,
                  color: Colors.white,
                ),
                duration: Duration(seconds: 3),
              )..show(scaffoldKey.currentState.context);
            });
          } else {
            setState(() {
              isLoading = false;
            });
            Flushbar(
              flushbarStyle: FlushbarStyle.FLOATING,
              flushbarPosition: FlushbarPosition.TOP,
              backgroundColor: Colors.red,
              message: "Gagal mengedit profile",
              icon: Icon(
                FontAwesomeIcons.infoCircle,
                size: 28.0,
                color: Colors.white,
              ),
              duration: Duration(seconds: 3),
            ).show(context);
          }
        });
      } catch (e) {}
    }
  }
}
