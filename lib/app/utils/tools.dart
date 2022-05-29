import 'dart:convert';
import 'dart:io';

import 'package:almarry_ex/app/routes/app_pages.dart';
import 'package:almarry_ex/constants.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:connectivity/connectivity.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../main.dart';

export 'CurrencyInfo.dart';
export 'NotificationService.dart';
export 'ToWord.dart';

void logOut(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: new Text("تسجيل خروج".tr,
                style: TextStyle(
                  fontFamily: 'NotoSans',
                )),
            content: new Text("هل تود فعلاً تسجيل خروج؟".tr,
                style: TextStyle(
                  fontFamily: 'NotoSans',
                )),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () => Get.back(),
                child: Text('إلغاء'.tr,
                    style: TextStyle(
                      fontFamily: 'NotoSans',
                    )),
              ),
              CupertinoDialogAction(
                child: Text('تسجيل خروج'.tr,
                    style:
                        TextStyle(fontFamily: 'NotoSans', color: Colors.red)),
                onPressed: () => Get.offAllNamed(Routes.LOGIN),
              )
            ],
          ));
}

void logout(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: new Text("تسجيل دخول".tr,
                style: TextStyle(
                  fontFamily: 'NotoSans',
                )),
            content:
                new Text("إنتهت الجلسة الخاصة بك يرجى تسجيل دخول مرة اخرى؟".tr,
                    style: TextStyle(
                      fontFamily: 'NotoSans',
                    )),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () => Get.back(),
                child: Text('إلغاء'.tr,
                    style:
                        TextStyle(fontFamily: 'NotoSans', color: Colors.red)),
              ),
              CupertinoDialogAction(
                child: Text('تسجيل دخول'.tr,
                    style: TextStyle(
                      fontFamily: 'NotoSans',
                    )),
                onPressed: () => Get.offAll(MyCustomSplashScreen()),
              )
            ],
          ));
}

Route toRoute(Widget widget) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var tween = Tween(begin: begin, end: end);
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

String toMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}

saveFile(String name, File img) async {
  final directory = await getApplicationDocumentsDirectory();
  final imagePath = await File('${directory.path}/$name.jpg').create();
  img.readAsBytes().then((value) async {
    await imagePath.writeAsBytes(value);
    stg.write(name, imagePath.path);
  });
}

Future<bool> connect() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

noconnect() {
  Get.snackbar('فشل الاتصال بالانترنت'.tr,
      'تأكد من إتصالك بشبكة الواي فاي او الجوال !'.tr,
      backgroundColor: Colors.redAccent,
      icon: Icon(
        Icons.wifi_off_rounded,
        color: Colors.white,
        size: 35,
      ),
      duration: Duration(seconds: 5),
      colorText: Colors.white);
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

message(String msg) {
  Get.snackbar('رسالة'.tr, msg,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: Duration(seconds: 5));
}

setDone() {
  AudioCache audioCache = AudioCache();
  audioCache.play('images/whatsApp.mp3', isNotification: true, volume: 4);
  audioCache.clearAll();
}

enum Currencies { Syria, UAE, SaudiArabia, Tunisia, Gold, Yemen, Dollar, Null }

class CurrencyC {
  static int YER = 1;
  static int SAR = 2;
  static int USD = 3;
  static int AED = 4;
  static int Null = 0;
  static int Syria = 5;
  static int Tunisia = 6;
  static int Gold = 7;
}
