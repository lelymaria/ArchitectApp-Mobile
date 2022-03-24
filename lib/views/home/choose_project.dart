import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/forms/choose_project_form.dart';
import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/models/repositories/repository.dart';
import 'package:architect_app/models/responses/get_projects_response.dart';
import 'package:architect_app/models/responses/login_response.dart';
import 'package:architect_app/utils/generals.dart';
import 'package:architect_app/utils/validations.dart';
import 'package:architect_app/views/profile/projects_owner.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';

class ChooseProject extends StatefulWidget {
  final ChooseProjectForm form;
  final Project project;
  ChooseProject({this.form, this.project});

  @override
  _ChooseProjectState createState() => _ChooseProjectState();
}

class _ChooseProjectState extends State<ChooseProject> {
  List<Jasa> tmpJasa = [];
  List<Asset> images = <Asset>[];
  List<File> files = [];
  bool isCheck = false;
  bool isLoading = false;
  String _error = 'No Error Dectected';
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _luas = new TextEditingController();
  TextEditingController _panjang = new TextEditingController();
  TextEditingController _lebar = new TextEditingController();
  TextEditingController _lokasi = new TextEditingController();
  TextEditingController _telepon = new TextEditingController();
  AuthPreference _authPreference = AuthPreference();
  Repository _repository = Repository();
  User _user;
  int harga = 0;

  _initialize() async {
    try {
      var data = await _authPreference.getUserData();
      setState(() {
        _user = data;
      });
    } catch (e) {}
  }

  @override
  void initState() {
    _initialize();
    _lebar.addListener(() {
      setState(() {
        var luas = int.parse(_panjang.text) * int.parse(_lebar.text);
        _luas.text = luas.toString();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _panjang.dispose();
    _lebar.dispose();
    super.dispose();
  }

  Map<String, bool> valueJasa = {
    "Desain": false,
    "Rencana Anggaran Biaya": false,
    // "Kontraktor": false,
  };

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 4,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Pilih Foto",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
      print(_error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(
            "Pilih Project",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ListView(
            shrinkWrap: true,
            children: [
              Row(
                children: [
                  Text("Jasa yang dibutuhkan  ", style: blackFontStyle3),
                  // GestureDetector(
                  //   onTap: () {
                  //     _popupHarga();
                  //   },
                  //   child:
                  //       Icon(Icons.info_outline, size: 18, color: Colors.amber),
                  // )
                ],
              ),
              ListView(
                shrinkWrap: true,
                children: valueJasa.keys.map((String key) {
                  return new CheckboxListTile(
                      title: new Text(key),
                      value: valueJasa[key],
                      onChanged: (bool value) {
                        setState(() {
                          valueJasa[key] = value;
                          tmpJasa.clear();
                          valueJasa.forEach((key, value) {
                            if (value) {
                              tmpJasa.add(Jasa('"$key"', value));
                            }
                          });
                        });
                      });
                }).toList(),
              ),
              if (isCheck == true)
                Text("Pilih minimal satu",
                    style: TextStyle(color: Colors.red, fontSize: 12)),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Panjang", style: blackFontStyle3),
                        TextFormField(
                          validator: Validations.emptyValidation,
                          controller: _panjang,
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Lebar", style: blackFontStyle3),
                        TextFormField(
                          validator: Validations.emptyValidation,
                          controller: _lebar,
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 15),
              Text("Luas Ruangan (m2)", style: blackFontStyle3),
              TextFormField(
                // validator: Validations.emptyValidation,
                controller: _luas,
                keyboardType: TextInputType.number,
                readOnly: true,
              ),
              if (_user.owner.alamat == null && _user.owner.telepon == null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    Text("Lokasi", style: blackFontStyle3),
                    TextFormField(
                      validator: Validations.emptyValidation,
                      controller: _lokasi,
                    ),
                    SizedBox(height: 15),
                    Text("Telepon", style: blackFontStyle3),
                    TextFormField(
                      validator: Validations.emptyValidation,
                      controller: _telepon,
                    ),
                  ],
                ),
              SizedBox(height: 15),
              Text("Foto Ruangan Saat Ini (Opsional)", style: blackFontStyle3),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: loadAssets,
                    icon: Icon(Icons.photo),
                    label: Text("Upload Foto"),
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                  ),
                ],
              ),
              if (images.length != 0)
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  children: List.generate(images.length, (index) {
                    Asset asset = images[index];
                    return AssetThumb(
                      asset: asset,
                      width: 300,
                      height: 300,
                    );
                  }),
                ),
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: isLoading
                ? loadingIndicator
                : ElevatedButton(
                    onPressed: () {
                      _onSubmit();
                    },
                    child: Text("Submit"),
                    style: ElevatedButton.styleFrom(primary: Colors.amber),
                  ),
          ),
        ),
      ),
    );
  }

  getImageFileFromAsset(String path) async {
    final file = File(path);
    return file;
  }

  _onSubmit() async {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      if (tmpJasa.length == 0) {
        setState(() {
          isCheck = true;
        });
      } else {
        _confirmationDialog();
      }
    }
  }

  _addProject() async {
    var checkbox = tmpJasa.toString();
    var desain = checkbox.contains("Desain") == true ? 1 : 0;
    var rab = checkbox.contains("Rencana Anggaran Biaya") == true ? 1 : 0;
    for (int i = 0; i < images.length; i++) {
      var path2 =
          await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);
      var file = await getImageFileFromAsset(path2);
      files.add(file);
    }
    widget.form.projectId = widget.project.id;
    widget.form.userId = widget.project.konsultan.userId;
    widget.form.desain = desain.toString();
    widget.form.rab = rab.toString();
    widget.form.panjang = double.parse(_panjang.text);
    widget.form.lebar = double.parse(_lebar.text);
    if (_telepon.text.isNotEmpty) {
      widget.form.telepon = _telepon.text;
    }
    if (_lokasi.text.isNotEmpty) {
      widget.form.alamat = _lokasi.text;
    }
    if (files.length > 0) {
      widget.form.image = files;
    }
    try {
      _repository.chooseProject(_authPreference, widget.form).then((value) {
        if (value.success == true) {
          setState(() {
            isLoading = false;
          });
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProjectsOwner()));
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Flushbar(
              flushbarStyle: FlushbarStyle.FLOATING,
              flushbarPosition: FlushbarPosition.TOP,
              backgroundColor: Colors.green,
              message: "Berhasil membeli desain",
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
            message: "Gagal membeli desain",
            icon: Icon(
              FontAwesomeIcons.infoCircle,
              size: 28.0,
              color: Colors.white,
            ),
            duration: Duration(seconds: 3),
          ).show(context);
        }
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Flushbar(
        flushbarStyle: FlushbarStyle.FLOATING,
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.red,
        message: "Gagal membeli desain",
        icon: Icon(
          FontAwesomeIcons.infoCircle,
          size: 28.0,
          color: Colors.white,
        ),
        duration: Duration(seconds: 3),
      ).show(context);
    }
  }

  _popupHarga() {
    showDialog(
      // barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Informasi Harga"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text("Desain", style: blackFontStyle1),
                  ),
                  Expanded(
                      flex: 1,
                      child: Text(
                          Generals.formatRupiah(widget.project.hargaDesain),
                          style: blackFontStyle3)),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text("RAB", style: blackFontStyle1),
                  ),
                  Expanded(
                      flex: 1,
                      child: Text(
                          Generals.formatRupiah(widget.project.hargaRab),
                          style: blackFontStyle3)),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  _confirmationDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        var checkbox = tmpJasa.toString();
        var desain = checkbox.contains("Desain") == true
            ? widget.project.hargaDesain
            : 0;
        var rab = checkbox.contains("Rencana Anggaran Biaya") == true
            ? widget.project.hargaRab
            : 0;
        var totalHarga = desain + rab;
        return AlertDialog(
          title: Text(
            "Konfirmasi Pembayaran",
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text("Total Bayar",
                        style: blackFontStyle1.copyWith(fontSize: 14)),
                  ),
                  Expanded(
                      flex: 1,
                      child: Text(Generals.formatRupiah(totalHarga),
                          style: blackFontStyle3.copyWith(fontSize: 14))),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white, onPrimary: Colors.black),
                        child: Text("Batal")),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          _addProject();
                          _showLoaderDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white, onPrimary: Colors.black),
                        child: Text("Ya")),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  _showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text("Mohon tunggu"),
          )
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class Jasa {
  String title;
  bool isCheck;

  Jasa(this.title, this.isCheck);

  @override
  String toString() {
    return '$title';
  }
}
