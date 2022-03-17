import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:supercharged/supercharged.dart';

Color greyColor = "8D92A3".toColor();
Color mainColor = "FFC700".toColor();

Widget loadingIndicator = SpinKitFadingCircle(size: 45, color: mainColor);

TextStyle greyFontStyle = TextStyle(color: greyColor, fontWeight: FontWeight.w300);
TextStyle blackFontStyle1 = TextStyle(color: Colors.black, fontWeight: FontWeight.w300);
TextStyle blackFontStyle2 = TextStyle(color: Colors.black, fontWeight: FontWeight.w400);
TextStyle blackFontStyle3 = TextStyle(color: Colors.black, fontWeight: FontWeight.w500);

const double defaultMargin = 24;
const double defaultPadding = 24;