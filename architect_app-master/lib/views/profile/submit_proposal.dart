import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/forms/add_proposal_form.dart';
import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/models/repositories/repository.dart';
import 'package:architect_app/models/responses/get_mylelang_response.dart';
import 'package:architect_app/utils/generals.dart';
import 'package:architect_app/utils/validations.dart';
import 'package:architect_app/views/professional/proposal_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SubmitProposal extends StatefulWidget {
  final MyLelang lelang;
  final String telepon;
  final String alamat;
  SubmitProposal({this.lelang, this.telepon, this.alamat});

  @override
  _SubmitProposalState createState() => _SubmitProposalState();
}

class _SubmitProposalState extends State<SubmitProposal> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _coverLetter = TextEditingController();
  TextEditingController _tawaranDesain = TextEditingController();
  TextEditingController _tawaranRab = TextEditingController();
  TextEditingController _alamat = TextEditingController();
  TextEditingController _telepon = TextEditingController();
  Repository _repository = Repository();
  AuthPreference _authPreference = AuthPreference();
  File _file;
  bool isUpload = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(
            "Submit Proposal",
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
              Text("Cover Letter", style: blackFontStyle3),
              TextFormField(
                controller: _coverLetter,
                validator: Validations.emptyValidation,
                maxLines: 8,
                decoration: InputDecoration(
                  hintText:
                      "Saya adalah konsultan berpengalaman untuk membuat dan merancang desain seperti ini",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black26,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26),
                  ),
                ),
              ),
              if (widget.alamat == null && widget.telepon == null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    Text("Alamat", style: blackFontStyle3),
                    TextFormField(
                      validator: Validations.emptyValidation,
                      controller: _alamat,
                    ),
                    SizedBox(height: 15),
                    Text("Telepon", style: blackFontStyle3),
                    TextFormField(
                      validator: Validations.emptyValidation,
                      controller: _telepon,
                    ),
                  ],
                ),
              if (widget.lelang.desain == "1")
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    Text("Tawaran Harga Desain", style: blackFontStyle3),
                    Row(
                      children: [
                        Text("Rp  "),
                        Expanded(
                          child: TextFormField(
                            validator: Validations.emptyValidation,
                            controller: _tawaranDesain,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              if (widget.lelang.rAB == "1")
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    Text("Tawaran Harga RAB", style: blackFontStyle3),
                    Row(
                      children: [
                        Text("Rp  "),
                        Expanded(
                          child: TextFormField(
                            validator: Validations.emptyValidation,
                            controller: _tawaranRab,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              SizedBox(height: 15),
              Text("Upload CV", style: blackFontStyle3),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      _filePicker();
                    },
                    icon: Icon(Icons.file_copy),
                    label: Text("Upload"),
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                  ),
                  SizedBox(width: 20),
                  _file != null
                      ? Expanded(child: Text(_file.path.split('/').last))
                      : SizedBox()
                ],
              ),
              if (isUpload == true)
                Text("Harap upload CV",
                    style: TextStyle(color: Colors.red, fontSize: 12))
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

  _onSubmit() {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      if (_file == null) {
        setState(() {
          isUpload = true;
        });
      } else {
        setState(() {
          isLoading = true;
        });
        try {
          _repository
              .postProposal(
                  _authPreference,
                  AddProposalForm(
                      lelangId: widget.lelang.id,
                      coverLetter: _coverLetter.text,
                      tawaranDesain: _tawaranDesain.text.isNotEmpty
                          ? int.parse(_tawaranDesain.text)
                          : 0,
                      tawaranRab: _tawaranRab.text.isNotEmpty
                          ? int.parse(_tawaranRab.text)
                          : 0,
                      cv: _file,
                      telepon: _telepon.text.isNotEmpty ? _telepon.text : null,
                      alamat: _alamat.text.isNotEmpty ? _alamat.text : null))
              .then((value) {
            if (value['success'] == true) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProposalScreen()));
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Flushbar(
                  flushbarStyle: FlushbarStyle.FLOATING,
                  flushbarPosition: FlushbarPosition.TOP,
                  backgroundColor: Colors.green,
                  message: "Berhasil mengirimkan proposal",
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
                message: value['message'],
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
            message: "Gagal mengirimkan proposal",
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

  _filePicker() async {
    try {
      FilePickerResult file = await FilePicker.platform.pickFiles(
          type: FileType.custom, allowedExtensions: Generals.listFormatFile);
      setState(() {
        _file = File(file.files.single.path);
      });
    } on PlatformException catch (e) {
      throw ("Unsupported operation" + e.toString());
    }
  }
}
