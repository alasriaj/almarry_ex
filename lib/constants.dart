import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

export 'app/data/models/models.dart';
export 'app/utils/tools.dart';
export 'app/views/views.dart';

var primaryColor = Color(0xFF037020);
var accentColor = Color(0xFF63B772);
var grayColor = Color(0xFFD5E7CD);
var darkColor = Color(0xFF8F8F8F);
var blueColor = Color(0xFF599EE3);
var ymColor = Color(0xFFBF054B);
var yColor = Color(0xFF6F3CA1);
var sabaColor = Color(0xFF00529C);
var mtnColor = Color(0xFFFFCA06);
var gradientApp = <Color>[accentColor, primaryColor];
Color shadowColorGlobal = Colors.black54;
int defaultElevation = 4;
double defaultRadius = 8.0;
double defaultBlurRadius = 1.0;
double defaultSpreadRadius = 0.0;
double defaultAppBarElevation = 4.0;

var stg = GetStorage();
var ctx;

progress({Color colo = Colors.white}) => SizedBox(
    height: 20,
    width: 20,
    child: CircularProgressIndicator(
      color: colo,
      strokeWidth: 1.5,
    ));

boxDecoration(BoxShape boxShape, List<Color> color) {
  return BoxDecoration(
      shape: boxShape,
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: color,
      ));
}

boxDecorationRadius() => BoxDecoration(
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20), topRight: Radius.circular(20)));

List<BoxShadow> defaultBoxShadow({
  Color? shadowColor,
  double? blurRadius,
  double? spreadRadius,
  Offset offset = const Offset(1, 1),
}) {
  return [
    BoxShadow(
      color: shadowColor ?? shadowColorGlobal,
      blurRadius: blurRadius ?? defaultBlurRadius,
      spreadRadius: spreadRadius ?? defaultSpreadRadius,
      offset: offset,
    )
  ];
}
