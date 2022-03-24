import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/forms/lelang_form.dart';
import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/models/repositories/repository.dart';
import 'package:architect_app/utils/validations.dart';
import 'package:architect_app/views/profile/auction.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';

class SecondScreen extends StatefulWidget {
  final LelangForm form;
  final String alamat;
  final String telepon;

  SecondScreen({this.form, this.alamat, this.telepon});

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _title = new TextEditingController();
  TextEditingController _description = new TextEditingController();
  TextEditingController _lokasi = new TextEditingController();
  TextEditingController _telepon = new TextEditingController();
  // File _image;
  DateTime selectedDate = DateTime.now();
  bool isLoading = false;
  Repository _repository = Repository();
  AuthPreference _authPreference = AuthPreference();
  List<Asset> images = <Asset>[];
  List<Asset> inspirasi = <Asset>[];
  List<File> files = [];
  List<File> filesInspirasi = [];
  String _error = 'No Error Dectected';

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

    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
      print(_error);
    });
  }

  Future<void> loadAssetsInspirasi() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 4,
        enableCamera: true,
        selectedAssets: inspirasi,
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

    if (!mounted) return;

    setState(() {
      inspirasi = resultList;
      _error = error;
      print(_error);
    });
  }

  // Mengambil gambar dari kamera
  // _imgFromCamera() async {
  //   PickedFile image = await ImagePicker()
  //       .getImage(source: ImageSource.camera, imageQuality: 50);

  //   setState(() {
  //     _image = File(image.path);
  //   });
  // }

  // Mengambil gambar dari gallery
  // _imgFromGallery() async {
  //   PickedFile image = await ImagePicker()
  //       .getImage(source: ImageSource.gallery, imageQuality: 50);

  //   setState(() {
  //     _image = File(image.path);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(
            "Cari Jasa",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            shrinkWrap: true,
            children: [
              Text("Judul Proyek", style: blackFontStyle3),
              TextFormField(
                validator: Validations.emptyValidation,
                controller: _title,
                decoration: InputDecoration(hintText: "Desain Ruang Tamu"),
              ),
              SizedBox(height: 15),
              Text("Deskripsi", style: blackFontStyle3),
              TextFormField(
                validator: Validations.emptyValidation,
                controller: _description,
                maxLines: 3,
                decoration: InputDecoration(
                    hintText:
                        "Saya membutuhkan desain ruang tamu yang nyaman dengan desain yang minimalist"),
              ),
              if (widget.alamat == null && widget.telepon == null)
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
              Text("Ruangan Saat Ini (Opsional)", style: blackFontStyle3),
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
              SizedBox(height: 15),
              Text("Inspirasi Ruangan / Bangunan (Opsional)", style: blackFontStyle3),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: loadAssetsInspirasi,
                    icon: Icon(Icons.photo),
                    label: Text("Upload Foto"),
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                  ),
                ],
              ),
              if (inspirasi.length != 0)
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  children: List.generate(inspirasi.length, (index) {
                    Asset assetinspi = inspirasi[index];
                    return AssetThumb(
                      asset: assetinspi,
                      width: 300,
                      height: 300,
                    );
                  }),
                ),
              // Text("Waktu Mulai Pengerjaan", style: blackFontStyle3),
              // Container(
              //   height: 40,
              //   child: TextField(
              //     onTap: () {
              //       _selectDate(context);
              //     },
              //     controller: _lokasi,
              //     decoration: InputDecoration(
              //       hintText: "dd/mm/yyyy",
              //       contentPadding: EdgeInsets.all(10),
              //       focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide(color: Colors.black26),
              //       ),
              //       enabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide(color: Colors.black26),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(height: 15),
              // Text("Unggah Foto (Opsional)", style: blackFontStyle3),
              // SizedBox(height: 5),
              // Row(
              //   children: [
              //     GestureDetector(
              //       onTap: () async {
              //         _imageDialog();
              //       },
              //       child: Container(
              //         height: 60,
              //         width: 60,
              //         decoration: BoxDecoration(
              //             border: Border.all(color: Colors.black12),
              //             borderRadius: BorderRadius.circular(5)),
              //         child: _image != null
              //             ? Image.file(_image, width: 60, height: 50)
              //             : Icon(
              //                 Icons.add_circle_rounded,
              //                 color: Colors.amber,
              //               ),
              //       ),
              //     ),
              //     SizedBox(width: 10),
              //     Container(
              //       height: 60,
              //       width: 60,
              //       decoration: BoxDecoration(
              //           border: Border.all(color: Colors.black12),
              //           borderRadius: BorderRadius.circular(5)),
              //       child: Icon(
              //         Icons.add_circle_rounded,
              //         color: Colors.amber,
              //       ),
              //     ),
              //     SizedBox(width: 10),
              //     Container(
              //       height: 60,
              //       width: 60,
              //       decoration: BoxDecoration(
              //           border: Border.all(color: Colors.black12),
              //           borderRadius: BorderRadius.circular(5)),
              //       child: Icon(
              //         Icons.add_circle_rounded,
              //         color: Colors.amber,
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(height: 10),
              // _image != null ? Text(_image.path.split("/").last) : SizedBox()
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
      setState(() {
        isLoading = true;
      });
      for (int i = 0; i < images.length; i++) {
        var path2 =
            await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);
        var file = await getImageFileFromAsset(path2);
        // var base64Image = base64Encode(file.readAsBytesSync());
        files.add(file);
      }
      for (int i = 0; i < inspirasi.length; i++) {
        var pathins =
            await FlutterAbsolutePath.getAbsolutePath(inspirasi[i].identifier);
        var fileins = await getImageFileFromAsset(pathins);
        filesInspirasi.add(fileins);
      }
      widget.form.title = _title.text;
      widget.form.description = _description.text;
      if (_telepon.text.isNotEmpty) {
        widget.form.telepon = _telepon.text;
      }
      if (_lokasi.text.isNotEmpty) {
        widget.form.alamat = _lokasi.text;
      }
      if (files.length > 0) {
        widget.form.image = files;
      }
      if (filesInspirasi.length > 0) {
        widget.form.inspirasi = filesInspirasi;
      }
      try {
        _repository.addLelang(_authPreference, widget.form).then((value) {
          if (value['success'] == true) {
            setState(() {
              isLoading = false;
            });
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Auction()),
                (Route<dynamic> route) => false);
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Flushbar(
                flushbarStyle: FlushbarStyle.FLOATING,
                flushbarPosition: FlushbarPosition.TOP,
                backgroundColor: Colors.green,
                message: "Berhasil mengusulkan desain custom",
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
              message: "Gagal mengusulkan desain custom",
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
          message: "Gagal mengusulkan desain custom",
          icon: Icon(
            FontAwesomeIcons.infoCircle,
            size: 28.0,
            color: Colors.white,
          ),
          duration: Duration(seconds: 3),
        ).show(context);
      }
    }
  }

  // bool _decideWhichDayToEnable(DateTime day) {
  //   if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))))) {
  //     return true;
  //   }
  //   return false;
  // }

  // _selectDate(BuildContext context) async {
  //   final DateTime picked = await showDatePicker(
  //       context: context,
  //       initialDate: selectedDate, // Refer step 1
  //       firstDate: DateTime(2000),
  //       lastDate: DateTime(2025),
  //       selectableDayPredicate: _decideWhichDayToEnable);
  //   if (picked != null && picked != selectedDate)
  //     setState(() {
  //       selectedDate = picked;
  //       _lokasi.text = selectedDate.toLocal().toString().split(' ')[0];
  //     });
  // }

  // _imageDialog() {
  //   showDialog(
  //     barrierDismissible: true,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(
  //           "Unggah Foto",
  //           style: TextStyle(fontSize: 14),
  //         ),
  //         content: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             GestureDetector(
  //               onTap: () {
  //                 _imgFromCamera();
  //                 Navigator.pop(context);
  //               },
  //               child: Text("Kamera"),
  //             ),
  //             SizedBox(height: 15),
  //             GestureDetector(
  //               onTap: () {
  //                 _imgFromGallery();
  //                 Navigator.pop(context);
  //               },
  //               child: Text("Album Foto"),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}
