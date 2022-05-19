import 'package:another_flushbar/flushbar.dart';
import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/models/repositories/repository.dart';
import 'package:architect_app/models/responses/get_projects_response.dart';
import 'package:architect_app/utils/validations.dart';
import 'package:architect_app/views/admin/image_view_screen.dart';
import 'package:architect_app/views/profile/myservices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:architect_app/utils/generals.dart';

class AllConsultanLelangDetail extends StatefulWidget {
  final Project project;
  AllConsultanLelangDetail({this.project});

  @override
  _AllConsultanLelangDetailState createState() =>
      _AllConsultanLelangDetailState();
}

class _AllConsultanLelangDetailState extends State<AllConsultanLelangDetail> {
  TextEditingController _title = TextEditingController();
  TextEditingController _description = TextEditingController();
  bool isLoading = false;
  Repository _repository = Repository();
  AuthPreference _authPreference = AuthPreference();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    setState(() {
      _title.text = widget.project.title;
      _description.text = widget.project.description;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.project.title,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: ListView(children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Judul", style: blackFontStyle3),
                TextFormField(
                  validator: Validations.emptyValidation,
                  controller: _title,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                Text("Deskripsi", style: blackFontStyle3),
                TextFormField(
                  validator: Validations.emptyValidation,
                  controller: _description,
                  maxLines: 3,
                ),
                if (widget.project.projectOwn[0].hasil.length > 0)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text("Desain", style: blackFontStyle3),
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 4,
                        crossAxisSpacing: 5,
                        children: List.generate(
                            widget.project.projectOwn[0].hasil.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ImageViewScreen(
                                        imageUrl:
                                            "${'${Generals.baseUrl}/img/file hasil/image/'}${widget.project.projectOwn[0].hasil[index].softfile}")),
                              );
                            },
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "${'${Generals.baseUrl}/img/file hasil/image/'}${widget.project.projectOwn[0].hasil[index].softfile}"),
                                      fit: BoxFit.cover)),
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                if (widget.project.projectOwn[0].hasilRab != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text("Rencana Anggaran Biaya", style: blackFontStyle3),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () async {
                              // _downloadRAB(widget.project.hasilRab);
                              final status = await Permission.storage.request();

                              if (status.isGranted) {
                                final externalDir =
                                    await getExternalStorageDirectory();

                                final id = await FlutterDownloader.enqueue(
                                  url:
                                      "${Generals.baseUrl}/img/file hasil/rab/${widget.project.projectOwn[0].hasilRab}",
                                  savedDir: externalDir.path,
                                  fileName:
                                      widget.project.projectOwn[0].hasilRab,
                                  showNotification: true,
                                  openFileFromNotification: true,
                                );
                              } else {
                                print("Permission deined");
                              }
                            },
                            icon: Icon(Icons.file_copy),
                            label: Text("Download RAB"),
                            style:
                                ElevatedButton.styleFrom(primary: Colors.green),
                          ),
                        ],
                      )
                    ],
                  ),
              ],
            ),
          ),
        ]),
        bottomNavigationBar:
        widget.project.projectOwn[0].hasil.length > 0 ?
        SafeArea(
          child: Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: isLoading
                ? loadingIndicator
                : ElevatedButton(
                    onPressed: () {
                      _onSubmit();
                    },
                    child: Text("Upload Project"),
                    style: ElevatedButton.styleFrom(primary: Colors.amber),
                  ),
          ),
        ) : SizedBox()
      ),
    );
  }

  _onSubmit() {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      setState(() {
        isLoading = true;
      });
      try {
        _repository
            .uploadProject(
                authPreference: _authPreference,
                projectId: widget.project.id,
                title: _title.text != widget.project.title
                    ? _title.text
                    : widget.project.title,
                description: _description.text != widget.project.description
                    ? _description.text
                    : widget.project.description)
            .then((value) {
          if (value['success'] == true) {
            setState(() {
              isLoading = false;
            });
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Myservices()));
          } else {
            setState(() {
              isLoading = false;
            });
            Flushbar(
              flushbarStyle: FlushbarStyle.FLOATING,
              flushbarPosition: FlushbarPosition.TOP,
              backgroundColor: Colors.red,
              message: "Gagal mengupload project",
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
          message: "Gagal mengupload project",
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
