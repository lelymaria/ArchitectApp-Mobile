import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:another_flushbar/flushbar.dart';
import 'package:architect_app/constants/theme.dart';
import 'package:architect_app/models/forms/upload_payment_form.dart';
import 'package:architect_app/models/preferences/auth_preference.dart';
import 'package:architect_app/models/repositories/repository.dart';
// import 'package:architect_app/models/responses/get_myproject_response.dart';
import 'package:architect_app/models/responses/login_response.dart';
import 'package:architect_app/utils/dimension.dart';
import 'package:architect_app/utils/generals.dart';
import 'package:architect_app/views/admin/doc_view_screen.dart';
import 'package:architect_app/views/admin/image_view_screen.dart';
import 'package:architect_app/views/chat/chat_screen.dart';
import 'package:architect_app/views/profile/projects_owner.dart';
import 'package:dio/dio.dart';
// import 'package:carousel_pro/carousel_pro.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';

class ProjectOwnerDetail extends StatefulWidget {
  final dynamic project;

  ProjectOwnerDetail({this.project});

  @override
  _ProjectOwnerDetailState createState() => _ProjectOwnerDetailState();
}

class _ProjectOwnerDetailState extends State<ProjectOwnerDetail> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final Dio _dio = Dio();
  User _user;
  AuthPreference _authPreference = AuthPreference();
  Repository _repository = Repository();
  File _file;
  bool isLoading = false;
  bool isUpload = false;
  ReceivePort _port = ReceivePort();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  // String _progress = "-";

  _initialize() async {
    var user = await _authPreference.getUserData();
    setState(() {
      _user = user;
    });
  }

  @override
  void initState() {
    super.initState();
    _initialize();

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = IOSInitializationSettings();
    final initSettings = InitializationSettings(android: android, iOS: iOS);

    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: _onSelectNotification);
    // IsolateNameServer.registerPortWithName(
    //     _port.sendPort, 'downloader_send_port');
    // _port.listen((dynamic data) {
    //   String id = data[0];
    //   DownloadTaskStatus status = data[1];
    //   int progress = data[2];
    //   setState(() {});
    // });

    // FlutterDownloader.registerCallback(downloadCallback);
  }

  // @override
  // void dispose() {
  //   IsolateNameServer.removePortNameMapping('downloader_send_port');
  //   super.dispose();
  // }

  // static void downloadCallback(
  //     String id, DownloadTaskStatus status, int progress) {
  //   final SendPort send =
  //       IsolateNameServer.lookupPortByName('downloader_send_port');
  //   send.send([id, status, progress]);
  // }

  // void _download(String url) async {
  //   final status = await Permission.storage.request();

  //   if (status.isGranted) {
  //     final externalDir = await getExternalStorageDirectory();

  //     final id = await FlutterDownloader.enqueue(
  //       url: url,
  //       savedDir: externalDir.path,
  //       showNotification: true,
  //       openFileFromNotification: true,
  //     );
  //   } else {
  //     print('Permission Denied');
  //   }
  // }

  Future<void> _startDownload(String savePath, url) async {
    Map<String, dynamic> result = {
      'isSuccess': false,
      'filePath': null,
      'error': null,
    };
    try {
      final response = await _dio.download(
        url,
        savePath,
        // onReceiveProgress: _onReceiveProgress
      );
      result['isSuccess'] = response.statusCode == 200;
      result['filePath'] = savePath;
    } catch (ex) {
      result['error'] = ex.toString();
    } finally {
      await _showNotification(result);
    }
  }

  Future<void> _downloadFile(url, filename) async {
    final dir = await _getDownloadDirectory();
    final status = await Permission.storage.request();

    if (status.isGranted) {
      final savePath = path.join(dir.path, filename);
      await _startDownload(savePath, url);
    } else {
      print('Permission Denied');
    }
  }

  Future<Directory> _getDownloadDirectory() async {
    if (Platform.isAndroid) {
      return await DownloadsPathProvider.downloadsDirectory;
    }

    // in this example we are using only Android and iOS so I can assume
    // that you are not trying it for other platforms and the if statement
    // for iOS is unnecessary

    // iOS directory visible to user
    return await getApplicationDocumentsDirectory();
  }

  // void _onReceiveProgress(int received, int total) {
  //   if (total != -1) {
  //     setState(() {
  //       _progress = (received / total * 100).toStringAsFixed(0) + "%";
  //     });
  //   }
  // }

  Future<void> _onSelectNotification(String json) async {
    final obj = jsonDecode(json);

    if (obj['isSuccess']) {
      OpenFile.open(obj['filePath']);
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text('${obj['error']}'),
        ),
      );
    }
  }

  Future<void> _showNotification(Map<String, dynamic> downloadStatus) async {
    final android = AndroidNotificationDetails(
        'channel id', 'channel name', 'channel description',
        playSound: false);
    final iOS = IOSNotificationDetails();
    final platform = NotificationDetails(android: android, iOS: iOS);
    final json = jsonEncode(downloadStatus);
    final isSuccess = downloadStatus['isSuccess'];

    await flutterLocalNotificationsPlugin.show(
        0, // notification id
        isSuccess ? 'Success' : 'Failure',
        isSuccess
            ? 'File has been downloaded successfully!'
            : 'There was an error while downloading the file.',
        platform,
        payload: json);
  }

  //   Future<bool> _requestPermissions() async {
  //   var permission = await Permission.storage.request();

  //   if (permission != PermissionStatus.granted) {
  //     await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  //     permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
  //   }

  //   return permission == PermissionStatus.granted;
  // }

  @override
  Widget build(BuildContext context) {
    var hargaLelang = widget.project['project']['harga_desain'] +
        widget.project['project']['harga_rab'];
    var hargaDesain = widget.project['choose_project'] != null
        ? widget.project['choose_project']['desain'] == "1"
            ? widget.project['project']['harga_desain']
            : 0
        : 0;
    var hargaRAB = widget.project['choose_project'] != null
        ? widget.project['choose_project']['RAB'] == "1"
            ? widget.project['project']['harga_rab']
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProjectsOwner()),
              );
            },
          ),
          backgroundColor: Colors.white,
        ),
        body: ListView(shrinkWrap: true, children: [
          Column(children: [
            // Container(
            //   height: 250,
            //   width: double.infinity,
            //   child: Carousel(
            //     boxFit: BoxFit.cover,
            //     autoplay: false,
            //     dotSize: 3.0,
            //     dotBgColor: Colors.transparent,
            //     showIndicator: true,
            //     images: project.picturepath.map((e) => NetworkImage(e)).toList(),
            //   ),
            // ),
            // SizedBox(height: 5),
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
                                widget.project['project']['title'],
                                style: blackFontStyle3.copyWith(fontSize: 18),
                              ),
                              SizedBox(height: 5),
                              Text(
                                widget.project['project']['konsultan']['user']
                                    ['name'],
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
                                widget.project['project']['konsultan']['user']
                                    ['username']);
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
                                widget.project['choose_project'] == null
                                    ? hargaLelang
                                    : hargaProject),
                            style: blackFontStyle3,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
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
                        widget.project['kontrak']['payment'] == null
                            ? Expanded(
                                flex: 1,
                                child: Text(
                                  "Belum Bayar",
                                  style: blackFontStyle3,
                                ),
                              )
                            : widget.project['kontrak']['payment']['status'] ==
                                    0
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
                    SizedBox(height: 20),
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
                                            "${'${Generals.baseUrl}/kontrak/'}${widget.project['kontrak']['kontrakKerja']}")));
                          },
                          icon: Icon(Icons.file_copy),
                          label: Text("Lihat Surat"),
                          style: ElevatedButton.styleFrom(primary: Colors.cyan),
                        ),
                      ],
                    ),
                    if (widget.project['kontrak']['payment'] == null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text("Upload bukti pembayaran",
                              style: blackFontStyle1),
                          Row(
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  _filePicker();
                                },
                                icon: Icon(Icons.file_copy),
                                label: Text("Upload"),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red),
                              ),
                              SizedBox(width: 20),
                              if (_file != null)
                                Expanded(
                                    child: Text(_file.path.split('/').last))
                            ],
                          ),
                          if (isUpload == true)
                            Text("Harap upload bukti pembayaran",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12)),
                          SizedBox(height: 5),
                          Text(
                              "*silahkan melakukan transfer ke rekening BRI 088222155847 a.n Eko Permana",
                              style: blackFontStyle1),
                              // 0834577298
                        ],
                      ),
                    widget.project['choose_project'] == null
                        ? widget.project['project']['harga_rab'] != 0
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  Text("Hasil Rencana Anggaran Biaya",
                                      style: blackFontStyle1),
                                  widget.project['hasil_rab'] != null
                                      ? Row(
                                          children: [
                                            ElevatedButton.icon(
                                              onPressed: () async {
                                                _downloadFile(
                                                    "${Generals.baseUrl}/img/file hasil/rab/${widget.project['hasil_rab']}",
                                                    "${widget.project['hasil_rab']}");
                                                // // _downloadRAB(widget.project.hasilRab);
                                                // final status = await Permission
                                                //     .storage
                                                //     .request();

                                                // if (status.isGranted) {
                                                //   final externalDir =
                                                //       await getExternalStorageDirectory();

                                                //   final id =
                                                //       await FlutterDownloader
                                                //           .enqueue(
                                                //     url:
                                                //         "${Generals.baseUrl}/img/file hasil/rab/${widget.project['hasil_rab']}",
                                                //     savedDir: externalDir.path,
                                                //     fileName: widget
                                                //         .project['hasil_rab'],
                                                //     showNotification: true,
                                                //     openFileFromNotification:
                                                //         true,
                                                //   );
                                                // } else {
                                                //   print("Permission deined");
                                                // }
                                              },
                                              icon: Icon(Icons.file_copy),
                                              label: Text("Download RAB"),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.green),
                                            ),
                                          ],
                                        )
                                      : Text(
                                          "-",
                                          style: blackFontStyle3,
                                        ),
                                ],
                              )
                            : SizedBox()
                        : widget.project['choose_project']['RAB'] != "0"
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  Text("Hasil Rencana Anggaran Biaya",
                                      style: blackFontStyle1),
                                  widget.project['hasil_rab'] != null
                                      ? Row(
                                          children: [
                                            ElevatedButton.icon(
                                              onPressed: () async {
                                                _downloadFile(
                                                    "${Generals.baseUrl}/img/file hasil/rab/${widget.project['hasil_rab']}",
                                                    "${widget.project['hasil_rab']}");
                                              },
                                              icon: Icon(Icons.file_copy),
                                              label: Text("Download RAB"),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.green),
                                            ),
                                          ],
                                        )
                                      : Text(
                                          "-",
                                          style: blackFontStyle3,
                                        ),
                                ],
                              )
                            : SizedBox(),
                    widget.project['choose_project'] == null
                        ? widget.project['project']['harga_desain'] != 0
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  Text("Hasil Desain", style: blackFontStyle1),
                                  widget.project['hasil'].length > 0
                                      ? Column(
                                          children: [
                                            GridView.count(
                                              shrinkWrap: true,
                                              crossAxisCount: 4,
                                              crossAxisSpacing: 5,
                                              children: List.generate(
                                                  widget.project['hasil']
                                                      .length, (index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ImageViewScreen(
                                                                  imageUrl:
                                                                      "${'${Generals.baseUrl}/img/file hasil/image/'}${widget.project['hasil'][index]['softfile']}")),
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 200,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                "${'${Generals.baseUrl}/img/file hasil/image/'}${widget.project['hasil'][index]['softfile']}"),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                );
                                              }),
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                ElevatedButton.icon(
                                                  onPressed: () async {
                                                    for (int i = 0;
                                                        i <
                                                            widget
                                                                .project[
                                                                    'hasil']
                                                                .length;
                                                        i++) {
                                                      // _download(
                                                      //     "${Generals.baseUrl}/img/file hasil/image/${widget.project['hasil'][i]['softfile']}");
                                                      _downloadFile(
                                                          "${Generals.baseUrl}/img/file hasil/image/${widget.project['hasil'][i]['softfile']}",
                                                          "${widget.project['hasil'][i]['softfile']}");
                                                    }
                                                    // _downloadRAB(widget.project.hasilRab);
                                                    // final status =
                                                    //     await Permission.storage
                                                    //         .request();

                                                    // if (status.isGranted) {
                                                    //   final externalDir =
                                                    //       await getExternalStorageDirectory();
                                                    //   for (int i = 0;
                                                    //       i <
                                                    //           widget
                                                    //               .project[
                                                    //                   'hasil']
                                                    //               .length;
                                                    //       i++) {
                                                    //     final id =
                                                    //         await FlutterDownloader
                                                    //             .enqueue(
                                                    //       url:
                                                    //           "${Generals.baseUrl}/img/file hasil/image/${widget.project['hasil'][i]['softfile']}",
                                                    //       savedDir:
                                                    //           externalDir.path,
                                                    //       fileName: widget
                                                    //                   .project[
                                                    //               'hasil'][i]
                                                    //           ['softfile'],
                                                    //       showNotification:
                                                    //           true,
                                                    //       openFileFromNotification:
                                                    //           true,
                                                    //     );
                                                    //   }
                                                    // } else {
                                                    //   print(
                                                    //       "Permission deined");
                                                    // }
                                                  },
                                                  icon: Icon(Icons.photo_album),
                                                  label:
                                                      Text("Download Desain"),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              Colors.green),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      : Text(
                                          "-",
                                          style: blackFontStyle3,
                                        )
                                ],
                              )
                            : SizedBox()
                        : widget.project['choose_project']['desain'] != "0"
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  Text("Hasil Desain", style: blackFontStyle1),
                                  widget.project['hasil'].length > 0
                                      ? Column(
                                          children: [
                                            GridView.count(
                                              shrinkWrap: true,
                                              crossAxisCount: 4,
                                              crossAxisSpacing: 5,
                                              children: List.generate(
                                                  widget.project['hasil']
                                                      .length, (index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ImageViewScreen(
                                                                  imageUrl:
                                                                      "${'${Generals.baseUrl}/img/file hasil/image/'}${widget.project['hasil'][index]['softfile']}")),
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 200,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                "${'${Generals.baseUrl}/img/file hasil/image/'}${widget.project['hasil'][index]['softfile']}"),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                );
                                              }),
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                ElevatedButton.icon(
                                                  onPressed: () async {
                                                    for (int i = 0;
                                                        i <
                                                            widget
                                                                .project[
                                                                    'hasil']
                                                                .length;
                                                        i++) {
                                                      // _download(
                                                      //     "${Generals.baseUrl}/img/file hasil/image/${widget.project['hasil'][i]['softfile']}");
                                                      _downloadFile(
                                                          "${Generals.baseUrl}/img/file hasil/image/${widget.project['hasil'][i]['softfile']}",
                                                          "${widget.project['hasil'][i]['softfile']}");
                                                    }
                                                    // final status =
                                                    //     await Permission.storage
                                                    //         .request();

                                                    // if (status.isGranted) {
                                                    //   final externalDir =
                                                    //       await getExternalStorageDirectory();
                                                    //   for (int i = 0;
                                                    //       i <
                                                    //           widget
                                                    //               .project[
                                                    //                   'hasil']
                                                    //               .length;
                                                    //       i++) {
                                                    //     final id =
                                                    //         await FlutterDownloader
                                                    //             .enqueue(
                                                    //       url:
                                                    //           "${Generals.baseUrl}/img/file hasil/image/${widget.project['hasil'][i]['softfile']}",
                                                    //       savedDir:
                                                    //           externalDir.path,
                                                    //       fileName: widget
                                                    //                   .project[
                                                    //               'hasil'][i]
                                                    //           ['softfile'],
                                                    //       showNotification:
                                                    //           true,
                                                    //       openFileFromNotification:
                                                    //           true,
                                                    //     );
                                                    //   }
                                                    // } else {
                                                    //   print(
                                                    //       "Permission deined");
                                                    // }
                                                  },
                                                  icon: Icon(Icons.photo_album),
                                                  label:
                                                      Text("Download Desain"),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              Colors.green),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      : Text(
                                          "-",
                                          style: blackFontStyle3,
                                        )
                                ],
                              )
                            : SizedBox()
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     SizedBox(height: 20),
                    //     Text("Bukti pembayaran", style: blackFontStyle1),
                    //     Row(
                    //       children: [
                    //         ElevatedButton.icon(
                    //           onPressed: () {
                    //             var ext = widget.project['kontrak']
                    //                     ['payment']['buktiBayar']
                    //                 .split(".")[1];
                    //             if (Generals.listFormatImage
                    //                 .contains(ext)) {
                    //               Navigator.push(
                    //                 context,
                    //                 MaterialPageRoute(
                    //                     builder: (context) =>
                    //                         ImageViewScreen(
                    //                             // imageUrl:
                    //                             //     "${'http://1803010.web.ti.polindra.ac.id/index.php/img/bukti/'}${widget.project['kontrak']['payment']['buktiBayar']}")),
                    //                             imageUrl:
                    //                                 "${'${Generals.baseUrl}/img/bukti/'}${widget.project['kontrak']['payment']['buktiBayar']}")),
                    //               );
                    //             } else if (Generals.listFormatPdf
                    //                 .contains(ext)) {
                    //               Navigator.push(
                    //                 context,
                    //                 MaterialPageRoute(
                    //                     builder: (context) =>
                    //                         DocViewScreen(
                    //                             // remotePDF:
                    //                             //     "${'http://1803010.web.ti.polindra.ac.id/index.php/img/bukti/'}${widget.project['kontrak']['payment']['buktiBayar']}")),
                    //                             remotePDF:
                    //                                 "${'${Generals.baseUrl}/img/bukti/'}${widget.project['kontrak']['payment']['buktiBayar']}")),
                    //               );
                    //             }
                    //           },
                    //           icon: Icon(Icons.file_copy),
                    //           label: Text("Lihat Bukti"),
                    //           style: ElevatedButton.styleFrom(
                    //               primary: Colors.blue),
                    //         ),
                    //       ],
                    //     )
                    //   ],
                    // )
                  ],
                ))
          ]),
        ]),
        bottomNavigationBar: widget.project['kontrak']['payment'] == null
            ? SafeArea(
                child: Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: isLoading
                      ? loadingIndicator
                      : ElevatedButton(
                          onPressed: () {
                            _onSend();
                          },
                          child: Text("Bayar"),
                          style:
                              ElevatedButton.styleFrom(primary: Colors.amber),
                        ),
                ),
              )
            : widget.project['status'] == "1"
                ? SizedBox()
                : widget.project['hasil'].length > 0 ||
                        widget.project['hasil_rab'] != null
                    ? SafeArea(
                        child: Container(
                          height: 60,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: isLoading
                              ? loadingIndicator
                              : ElevatedButton(
                                  onPressed: () {
                                    _showRatingDialog();
                                  },
                                  child: Text("Project Selesai"),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.amber),
                                ),
                        ),
                      )
                    : SizedBox());
  }

  _createRoomAndStartConversation(String username) {
    String chatRoomId = _getChatRoomId(_user.username, username);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatScreen(chatRoomId,
                widget.project['project']['konsultan']['user']['username'])));
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
          type: FileType.custom, allowedExtensions: Generals.listFormatFile);
      setState(() {
        _file = File(file.files.single.path);
      });
    } on PlatformException catch (e) {
      throw ("Unsupported operation" + e.toString());
    }
  }

  _onSend() async {
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
            .uploadPayment(
                _authPreference,
                UploadPaymentForm(
                    kontrakId: widget.project['kontrak']['id'], bukti: _file))
            .then((value) {
          if (value['success'] == true) {
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
                message: "Berhasil mengunggah pembayaran",
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
              message: "Gagal mengunggah pembayaran",
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
          message: "Gagal mengunggah pembayaran",
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

  void _showRatingDialog() {
    final _ratingDialog = RatingDialog(
      starColor: Colors.amber,
      title: Text('Rating project ini'),
      // message: 'Rating this app and tell others what you think.'
      //     ' Add more description here if you want.',
      // image: Image.asset(
      //   "assets/images/devs.jpg",
      //   height: 100,
      // ),
      initialRating: 3,
      enableComment: false,
      submitButtonText: 'Submit',
      onCancelled: () {
        _repository
            .rating(
                authPreference: _authPreference,
                rating: null,
                projectOwnerId: widget.project['id'])
            .then((value) {
          if (value['success'] == true) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProjectsOwner()));
          } else {
            Flushbar(
              flushbarStyle: FlushbarStyle.FLOATING,
              flushbarPosition: FlushbarPosition.TOP,
              backgroundColor: Colors.red,
              message: "Gagal memberikan rating",
              icon: Icon(
                FontAwesomeIcons.infoCircle,
                size: 28.0,
                color: Colors.white,
              ),
              duration: Duration(seconds: 3),
            ).show(context);
          }
        });
      },
      onSubmitted: (response) {
        try {
          _repository
              .rating(
                  authPreference: _authPreference,
                  rating: response.rating as int,
                  projectOwnerId: widget.project['id'])
              .then((value) {
            if (value['success'] == true) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProjectsOwner()));
            } else {
              Flushbar(
                flushbarStyle: FlushbarStyle.FLOATING,
                flushbarPosition: FlushbarPosition.TOP,
                backgroundColor: Colors.red,
                message: "Gagal memberikan rating",
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
          Flushbar(
            flushbarStyle: FlushbarStyle.FLOATING,
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: Colors.red,
            message: "Gagal memberikan rating",
            icon: Icon(
              FontAwesomeIcons.infoCircle,
              size: 28.0,
              color: Colors.white,
            ),
            duration: Duration(seconds: 3),
          ).show(context);
        }
      },
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _ratingDialog,
    );
  }
}
