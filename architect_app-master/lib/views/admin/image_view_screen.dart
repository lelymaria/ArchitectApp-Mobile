import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageViewScreen extends StatefulWidget {
  final imageUrl;

  const ImageViewScreen({Key key, @required this.imageUrl}) : super(key: key);

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          title: Text("Preview", style: TextStyle(fontSize: 16)),
          backgroundColor: Colors.transparent),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          // child: Image.asset(
          //   widget.imageUrl,
          //   fit: BoxFit.fill,
          // ),
          child: CachedNetworkImage(
            imageUrl: widget.imageUrl,
            fit: BoxFit.fill,
            placeholder: (context, url) => CupertinoActivityIndicator(),
            // errorWidget: (context, url, error) => Container(
            //     height: MediaQuery.of(context).size.height / 3.3,
            //     color: Colors.grey[200],
            //     child: Image.asset('assets/images/sertifikat keahlian.png',
            //         fit: BoxFit.fitWidth)),
          ),
        ),
      ),
    );
  }
}
