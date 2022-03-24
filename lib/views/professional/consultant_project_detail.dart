import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/forms/upload_hasil_form.dart';
import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/models/repositories/repository.dart';
import 'package:architect_app/models/responses/login_response.dart';
import 'package:architect_app/utils/dimension.dart';
import 'package:architect_app/utils/generals.dart';
import 'package:architect_app/views/admin/doc_view_screen.dart';
import 'package:architect_app/views/admin/image_view_screen.dart';
import 'package:architect_app/views/chat/chat_screen.dart';
import 'package:architect_app/views/main_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter/material.dart';

class ConsultantProjectDetail extends StatefulWidget {
  final dynamic data;
  ConsultantProjectDetail({this.data});

  @override
  _ConsultantProjectDetailState createState() =>
      _ConsultantProjectDetailState();
}

class _ConsultantProjectDetailState extends State<ConsultantProjectDetail> {
  User _user;
  AuthPreference _authPreference = AuthPreference();
  Repository _repository = Repository();
  List<Asset> images = <Asset>[];
  List<File> files = [];
  File _file;
  String _error = 'No Error Dectected';
  bool isLoading = false;
  bool isDesainUpload = false;
  bool isRabUpload = false;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  _initialize() async {
    var user = await _authPreference.getUserData();
    setState(() {
      _user = user;
    });
  }

  @override
  void initState() {
    _initialize();
    super.initState();
  }

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
    var hargaLelang = widget.data['project']['harga_desain'] +
        widget.data['project']['harga_rab'];
    var hargaDesain = widget.data['choose_project'] != null
        ? widget.data['choose_project']['desain'] == "1"
            ? widget.data['project']['harga_desain']
            : 0
        : 0;
    var hargaRAB = widget.data['choose_project'] != null
        ? widget.data['choose_project']['RAB'] == "1"
            ? widget.data['project']['harga_rab']
            : 0
        : 0;
    var hargaProject = hargaDesain + hargaRAB;
    Dimension().init(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Detail Project",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(shrinkWrap: true, children: [
        Column(children: [
          Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.data['project']['title'],
                              style: blackFontStyle3.copyWith(fontSize: 18),
                            ),
                            SizedBox(height: 5),
                            Text(
                              widget.data['owner']['user']['name'],
                              style: blackFontStyle2,
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton.icon(
                        label: Text("Pesan"),
                        icon: Icon(Icons.message),
                        onPressed: () {
                          _createRoomAndStartConversation(
                              widget.data['owner']['user']['username']);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.amber,
                            side: BorderSide(color: Colors.amber)),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Biaya",
                          style: blackFontStyle1,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          Generals.formatRupiah(
                              widget.data['choose_project'] == null
                                  ? hargaLelang
                                  : hargaProject),
                          style: blackFontStyle3,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Status",
                          style: blackFontStyle1,
                        ),
                      ),
                      widget.data['kontrak']['payment'] == null
                          ? Expanded(
                              flex: 1,
                              child: Text(
                                "Belum Bayar",
                                style: blackFontStyle3,
                              ),
                            )
                          : widget.data['kontrak']['payment']['status'] == 0
                              ? Expanded(
                                  flex: 1,
                                  child: Text(
                                    "Menunggu Verifikasi Admin",
                                    style: blackFontStyle3,
                                  ),
                                )
                              : Expanded(
                                  flex: 1,
                                  child: Text(
                                    "Sudah Bayar",
                                    style: blackFontStyle3,
                                  ),
                                )
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Luas Ruangan",
                          style: blackFontStyle1,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          widget.data['choose_project'] != null
                              ? "${widget.data['choose_project']['panjang']} x ${widget.data['choose_project']['lebar']}"
                              : "${widget.data['owner']['lelang'][0]['panjang']} x ${widget.data['owner']['lelang'][0]['lebar']}",
                          style: blackFontStyle3,
                        ),
                      ),
                    ],
                  ),
                  widget.data['choose_project'] != null
                      ? widget.data['choose_project']['image_owner'].length > 0
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15),
                                Text("Foto Ruangan", style: blackFontStyle1),
                                SizedBox(height: 5),
                                GridView.count(
                                  shrinkWrap: true,
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 5,
                                  children: List.generate(
                                      widget
                                          .data['choose_project']['image_owner']
                                          .length, (index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ImageViewScreen(
                                                  imageUrl:
                                                      "${'${Generals.baseUrl}/img/owner/'}${widget.data['choose_project']['image_owner'][index]['image']}")),
                                        );
                                      },
                                      child: Container(
                                        height: 200,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    "${'${Generals.baseUrl}/img/owner/'}${widget.data['choose_project']['image_owner'][index]['image']}"),
                                                fit: BoxFit.cover)),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            )
                          : SizedBox()
                      : widget.data['owner']['lelang'][0]['image'].length > 0
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15),
                                Text("Foto Ruangan", style: blackFontStyle1),
                                SizedBox(height: 5),
                                GridView.count(
                                  shrinkWrap: true,
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 5,
                                  children: List.generate(
                                      widget.data['owner']['lelang'][0]['image']
                                          .length, (index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ImageViewScreen(
                                                  imageUrl:
                                                      "${'${Generals.baseUrl}/img/lelang/tkp/'}${widget.data['owner']['lelang'][0]['image'][index]['image']}")),
                                        );
                                      },
                                      child: Container(
                                        height: 200,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    "${'${Generals.baseUrl}/img/lelang/tkp/'}${widget.data['owner']['lelang'][0]['image'][index]['image']}"),
                                                fit: BoxFit.cover)),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            )
                          : SizedBox(),
                  // SizedBox(height: 20),
                  // Text("Foto Ruangan", style: blackFontStyle1),
                  // SizedBox(height: 20),
                  // Wrap(
                  //   children: project.foto
                  //       .map((e) => (Container(
                  //             margin: EdgeInsets.only(right: 10, bottom: 10),
                  //             width: Dimension.blockSizeHorizontal * 20,
                  //             height: Dimension.blockSizeHorizontal * 20,
                  //             decoration: BoxDecoration(
                  //                 image: DecorationImage(
                  //                     image: AssetImage('assets/images/$e'),
                  //                     fit: BoxFit.cover),
                  //                 borderRadius: BorderRadius.circular(5)),
                  //           )))
                  //       .toList(),
                  // ),
                  // SizedBox(height: 10),
                  // Text("Jasa yang dibutuhkan", style: blackFontStyle1),
                  // SizedBox(height: 10),
                  // Wrap(
                  //   children: project.category
                  //       .map((item) => Container(
                  //             margin: EdgeInsets.only(right: 10, bottom: 10),
                  //             padding: EdgeInsets.symmetric(
                  //                 horizontal: 10, vertical: 5),
                  //             decoration: BoxDecoration(
                  //                 color: Colors.grey[300],
                  //                 borderRadius: BorderRadius.circular(50)),
                  //             child: Text(item),
                  //           ))
                  //       .toList(),
                  // ),

                  // if (widget.data['project_own'][0]['kontrak']['payment']
                  //         ['status'] ==
                  //     1)
                  //   Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       SizedBox(height: 20),
                  //       Text("Bukti pembayaran", style: blackFontStyle1),
                  //       Row(
                  //         children: [
                  //           ElevatedButton.icon(
                  //             onPressed: () {
                  //               var ext = widget.data['project_own'][0]
                  //                       ['kontrak']['payment']['buktiBayar']
                  //                   .split(".")[1];
                  //               if (Generals.listFormatImage.contains(ext)) {
                  //                 Navigator.push(
                  //                   context,
                  //                   MaterialPageRoute(
                  //                       builder: (context) => ImageViewScreen(
                  //                           // imageUrl:
                  //                           //     "${'http://1803010.web.ti.polindra.ac.id/index.php/img/bukti/'}${widget.project['kontrak']['payment']['buktiBayar']}")),
                  //                           imageUrl:
                  //                               "${'${Generals.baseUrl}/img/bukti/'}${widget.data['project_own'][0]['kontrak']['payment']['buktiBayar']}")),
                  //                 );
                  //               } else if (Generals.listFormatPdf
                  //                   .contains(ext)) {
                  //                 Navigator.push(
                  //                   context,
                  //                   MaterialPageRoute(
                  //                       builder: (context) => DocViewScreen(
                  //                           // remotePDF:
                  //                           //     "${'http://1803010.web.ti.polindra.ac.id/index.php/img/bukti/'}${widget.project['kontrak']['payment']['buktiBayar']}")),
                  //                           remotePDF:
                  //                               "${'${Generals.baseUrl}/img/bukti/'}${widget.data['project_own'][0]['kontrak']['payment']['buktiBayar']}")),
                  //                 );
                  //               }
                  //             },
                  //             icon: Icon(Icons.file_copy),
                  //             label: Text("Lihat Bukti"),
                  //             style: ElevatedButton.styleFrom(
                  //                 primary: Colors.blue),
                  //           ),
                  //         ],
                  //       )
                  //     ],
                  //   ),
                  SizedBox(height: 15),
                  Text("Surat Perjanjian Kerja", style: blackFontStyle1),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DocViewScreen(
                                      remotePDF:
                                          "${'${Generals.baseUrl}/kontrak/'}${widget.data['kontrak']['kontrakKerja']}")));
                        },
                        icon: Icon(Icons.file_copy),
                        label: Text("Lihat Surat"),
                        style: ElevatedButton.styleFrom(primary: Colors.cyan),
                      ),
                    ],
                  ),
                  widget.data['choose_project'] == null
                      ? widget.data['project']['harga_rab'] != 0
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15),
                                Text("Rencana Anggaran Biaya",
                                    style: blackFontStyle1),
                                Row(
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        _filePicker();
                                      },
                                      icon: Icon(Icons.file_copy),
                                      label: Text("Upload RAB"),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.red),
                                    ),
                                    SizedBox(width: 20),
                                    if (_file != null)
                                      Expanded(
                                          child:
                                              Text(_file.path.split('/').last))
                                  ],
                                ),
                                if (isRabUpload == true)
                                  Text("Harap upload RAB",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12))
                              ],
                            )
                          : SizedBox()
                      : widget.data['choose_project']['RAB'] != "0"
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15),
                                Text("Rencana Anggaran Biaya",
                                    style: blackFontStyle1),
                                Row(
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        _filePicker();
                                      },
                                      icon: Icon(Icons.file_copy),
                                      label: Text("Upload RAB"),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.red),
                                    ),
                                    SizedBox(width: 20),
                                    if (_file != null)
                                      Expanded(
                                          child:
                                              Text(_file.path.split('/').last))
                                  ],
                                ),
                                if (isRabUpload == true)
                                  Text("Harap upload RAB",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12))
                              ],
                            )
                          : SizedBox(),
                  widget.data['choose_project'] == null
                      ? widget.data['project']['harga_desain'] != 0
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15),
                                Text("Desain 2D / 3D", style: blackFontStyle1),
                                Row(
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: loadAssets,
                                      icon: Icon(Icons.photo),
                                      label: Text("Upload Desain"),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.red),
                                    ),
                                  ],
                                ),
                                if (isDesainUpload == true)
                                  Text("Harap upload Desain",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12)),
                                GridView.count(
                                  shrinkWrap: true,
                                  crossAxisCount: 3,
                                  children:
                                      List.generate(images.length, (index) {
                                    Asset asset = images[index];
                                    return AssetThumb(
                                      asset: asset,
                                      width: 300,
                                      height: 300,
                                    );
                                  }),
                                ),
                              ],
                            )
                          : SizedBox()
                      : widget.data['choose_project']['desain'] != "0"
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15),
                                Text("Desain 2D / 3D", style: blackFontStyle1),
                                Row(
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: loadAssets,
                                      icon: Icon(Icons.photo),
                                      label: Text("Upload Desain"),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.red),
                                    ),
                                  ],
                                ),
                                if (isDesainUpload == true)
                                  Text("Harap upload Desain",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12)),
                                GridView.count(
                                  shrinkWrap: true,
                                  crossAxisCount: 3,
                                  children:
                                      List.generate(images.length, (index) {
                                    Asset asset = images[index];
                                    return AssetThumb(
                                      asset: asset,
                                      width: 300,
                                      height: 300,
                                    );
                                  }),
                                ),
                              ],
                            )
                          : SizedBox()
                ],
              ))
        ]),
      ]),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: isLoading
              ? loadingIndicator
              : ElevatedButton(
                  onPressed: widget.data['status'] == "1"
                      ? null
                      : () {
                          _onSend();
                        },
                  child: Text("Kirim Desain / RAB"),
                  style: ElevatedButton.styleFrom(primary: Colors.amber),
                ),
        ),
      ),
    );
  }

  _createRoomAndStartConversation(String username) {
    String chatRoomId = _getChatRoomId(_user.username, username);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatScreen(
                chatRoomId, widget.data['owner']['user']['username'])));
  }

  _getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  _filePicker() async {
    try {
      FilePickerResult file = await FilePicker.platform.pickFiles(
          type: FileType.any);
          // type: FileType.custom, allowedExtensions: Generals.listFormatFile);
      setState(() {
        _file = File(file.files.single.path);
      });
    } on PlatformException catch (e) {
      throw ("Unsupported operation" + e.toString());
    }
  }

  getImageFileFromAsset(String path) async {
    final file = File(path);
    return file;
  }

  _onSend() async {
    setState(() {
      isLoading = true;
    });
    for (int i = 0; i < images.length; i++) {
      var path2 =
          await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);
      var file = await getImageFileFromAsset(path2);
      files.add(file);
    }
    try {
      _repository
          .uploadHasil(
              _authPreference,
              UploadHasilForm(
                  projectOwnerId: widget.data['id'],
                  rab: _file,
                  softfile: files))
          .then((value) {
        if (value['success'] == true) {
          setState(() {
            isLoading = false;
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MainPage(initialPage: 1)));
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Flushbar(
              flushbarStyle: FlushbarStyle.FLOATING,
              flushbarPosition: FlushbarPosition.TOP,
              backgroundColor: Colors.green,
              message: "Berhasil mengirim hasil",
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
            message: "Gagal mengirim hasil",
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
        message: "Gagal mengirim hasil",
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
