import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class DocViewScreen extends StatefulWidget {
  final remotePDF;

  const DocViewScreen({Key key, @required this.remotePDF}) : super(key: key);

  @override
  _DocViewState createState() => _DocViewState();
}

class _DocViewState extends State<DocViewScreen> {
  String _localPath;
  String nameFile = "${DateFormat('ddMMyyyyhhmmss').format(DateTime.now())}";
  String remotePDFpath = "";

  @override
  void initState() {
    _prepare();

    createFileOfPdfUrl().then((f) {
      setState(() {
        remotePDFpath = f.path;
      });
    });

    super.initState();
  }

  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    try {
      final url = widget.remotePDF;
      final filename = nameFile.replaceAll(RegExp(r"\|.*"), '').trim() + '.pdf';
      // final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      String dir = (await getApplicationDocumentsDirectory()).path;
      debugPrint(dir);
      debugPrint(url);
      File file = File("$dir/$filename");

      await file.writeAsBytes(bytes, flush: true);
      // return file;
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return remotePDFpath.isNotEmpty
        ? PDFViewerScaffold(
            appBar: AppBar(
                title: Text("Preview", style: TextStyle(fontSize: 16)),
                backgroundColor: Colors.transparent),
            path: remotePDFpath,
          )
        : Scaffold(
            appBar: AppBar(
                title: Text("Preview", style: TextStyle(fontSize: 16)),
                backgroundColor: Colors.transparent),
            body: Center(child: CircularProgressIndicator()),
          );
  }

  Future<Null> _prepare() async {
    _localPath = (await _findLocalPath()) + Platform.pathSeparator + 'Download';

    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String> _findLocalPath() async {
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // void _onStatusRequested(PermissionStatus statuses) {
  //   if (statuses.isGranted) {
  //     createFileOfPdfUrl();
  //   }
  // }
}
