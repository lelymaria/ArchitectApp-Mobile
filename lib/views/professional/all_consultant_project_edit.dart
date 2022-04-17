import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/forms/add_desain_form.dart';
import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/models/repositories/repository.dart';
import 'package:architect_app/utils/validations.dart';
import 'package:architect_app/views/home/form/style_info.dart';
import 'package:architect_app/views/professional/all_consultant_project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class EditProject extends StatefulWidget {
  @override
  _EditProjectState createState() => _EditProjectState(project: {});
}

class _EditProjectState extends State<EditProject> {

  final Map project;
    _EditProjectState({@required this.project});
  final _formKey = GlobalKey<FormState>();

    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  Repository _repository = Repository();
  AuthPreference _authPreference = AuthPreference();
  DesignStyle selectedDesign;
  TextEditingController _title = new TextEditingController();
  TextEditingController _description = new TextEditingController();
  TextEditingController _desainPrice = new TextEditingController();
  TextEditingController _rabPrice = new TextEditingController();
  List<Asset> images = <Asset>[];
  List<File> files = [];
  String _error = 'No Error Dectected';
  bool isLoading = false;
  bool isUpload = false;

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

  List<DesignStyle> designs = [
    DesignStyle("Minimalis"),
    DesignStyle("Modern"),
    DesignStyle("Tradisional"),
    DesignStyle("Scandinavian"),
  ];

  List<DropdownMenuItem> generatedDesigns(List<DesignStyle> properties) {
    List<DropdownMenuItem> items = [];
    for (var item in properties) {
      items.add(DropdownMenuItem(
        child: Text(item.designName),
        value: item,
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(
            "Unggah Desain",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ListView(
            children: [
              Text("Judul", style: blackFontStyle3),
              TextFormField(
                validator: Validations.emptyValidation,
                controller: _title,
                // decoration: InputDecoration(hintText: "Desain Ruang Tamu"),
              ),
              SizedBox(height: 15),
              Text("Deskripsi", style: blackFontStyle3),
              TextFormField(
                validator: Validations.emptyValidation,
                controller: _description,
                maxLines: 3,
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Text("Gaya Desain  ", style: blackFontStyle3),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => StyleInfo()));
                    },
                    child:
                        Icon(Icons.info_outline, size: 18, color: Colors.amber),
                  )
                ],
              ),
              Container(
                child: DropdownButtonFormField(
                    value: selectedDesign,
                    items: generatedDesigns(designs),
                    hint: Text("Pilih salah satu"),
                    isExpanded: true,
                    onChanged: (item) {
                      setState(() {
                        selectedDesign = item;
                      });
                    },
                    validator: (value) =>
                        value == null ? "Pilih salah satu" : null),
              ),
              SizedBox(height: 15),
              Text("Harga Desain", style: blackFontStyle3),
              Row(
                children: [
                  Text("Rp  "),
                  Expanded(
                    child: TextFormField(
                      validator: Validations.emptyValidation,
                      controller: _desainPrice,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text("Harga RAB", style: blackFontStyle3),
              Row(
                children: [
                  Text("Rp  "),
                  Expanded(
                    child: TextFormField(
                      validator: Validations.emptyValidation,
                      controller: _rabPrice,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text("Gambar", style: blackFontStyle3),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: loadAssets,
                    icon: Icon(Icons.photo),
                    label: Text("Upload Gambar"),
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                  ),
                ],
              ),
              if (isUpload == true)
                Text("Harap unggah gambar",
                    style: TextStyle(color: Colors.red, fontSize: 12)),
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
      if (images.length == 0) {
        setState(() {
          isUpload = true;
        });
      } else {
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
        try {
          _repository
              .addDesain(
                  _authPreference,
                  AddDesainForm(
                      title: _title.text,
                      desc: _description.text,
                      gayaDesain: selectedDesign.toString(),
                      hargaDesain: int.parse(_desainPrice.text),
                      hargaRab: int.parse(_rabPrice.text),
                      image: files,
                  ))
              .then((value) {
            if (value['success'] == true) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AllConsultantProject()));
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Flushbar(
                  flushbarStyle: FlushbarStyle.FLOATING,
                  flushbarPosition: FlushbarPosition.TOP,
                  backgroundColor: Colors.green,
                  message: "Berhasil mengunggah desain",
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
                message: "Gagal mengunggah desain",
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
            isUpload = false;
          });
          Flushbar(
            flushbarStyle: FlushbarStyle.FLOATING,
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: Colors.red,
            message: "Gagal mengunggah desain",
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
  }
}

class DesignStyle {
  String designName;
  DesignStyle(this.designName);

  @override
  String toString() {
    return '$designName';
  }
}
