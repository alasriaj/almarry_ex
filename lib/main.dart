import 'dart:async';

import 'package:almarry_ex/app/translations/app_translations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'app/routes/app_pages.dart';
import 'constants.dart';

void main() async {
  await GetStorage.init();

  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  OneSignal.shared.setLogLevel(OSLogLevel.none, OSLogLevel.none);
  OneSignal.shared.setAppId('5e341cd9-589e-48cb-9d25-604afd3b6027');
  await OneSignal.shared.getDeviceState().then((value) {
    stg.write('userId', value!.userId?.toString());
  });
  if (stg.read('userId') == null || stg.read('userId').toString().isEmpty) {
    await OneSignal.shared.getDeviceState().then((value) {
      stg.write('userId', value!.userId?.toString());
    });
  }
  await OneSignal.shared.consentGranted(true);
  await OneSignal.shared.promptUserForPushNotificationPermission();

  var loc = Locale('ar', 'YE');
  if (stg.read('lang') != null) {
    if (stg.read('lang') == '2') {
      loc = Locale('en', 'US');
    }
  } else {
    stg.write('lang', '1');
  }
  //stg.remove('sales');

  runApp(MyApp(loc));
}

class MyApp extends StatelessWidget {
  final Locale locale;

  MyApp(this.locale);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'بورصة المري'.tr,
      debugShowCheckedModeBanner: false,
      getPages: AppPages.pages,
      enableLog: false,
      translations: LocaleString(),
      darkTheme: ThemeData.dark().copyWith(
        highlightColor: accentColor,
        primaryColor: primaryColor,
        textTheme: Theme.of(context)
            .textTheme
            .apply(fontFamily: 'NotoSans', bodyColor: Colors.white),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryIconTheme: IconThemeData(color: Colors.black),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: primaryColor,
          selectionColor: primaryColor,
          selectionHandleColor: primaryColor,
        ),
        appBarTheme: AppBarTheme(
            color: primaryColor,
            elevation: 1,
            centerTitle: true,
            titleTextStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'NotoSans',
                fontSize: 20,
                fontWeight: FontWeight.bold),
            iconTheme: IconThemeData(color: Colors.white, size: 15)),
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: primaryColor),
        applyElevationOverlayColor: true,
      ),
      color: primaryColor,
      themeMode: stg.read('isDark') == null
          ? ThemeMode.light
          : stg.read('isDark') == true
              ? ThemeMode.dark
              : ThemeMode.light,
      locale: locale,
      home: MyCustomSplashScreen(),
      theme: ThemeData(
        highlightColor: accentColor,
        fontFamily: 'NotoSans',
        primaryColor: primaryColor,
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: primaryColor,
          selectionColor: primaryColor,
          selectionHandleColor: primaryColor,
        ),
        appBarTheme: AppBarTheme(
            color: primaryColor,
            centerTitle: true,
            elevation: 1,
            titleTextStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'NotoSans',
                fontSize: 20,
                fontWeight: FontWeight.bold),
            iconTheme: IconThemeData(color: Colors.white, size: 15)),
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: primaryColor),
        applyElevationOverlayColor: true,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('ar', 'YE'),
        const Locale('en', 'US'),
      ],
    );
  }
}

Future<void> load() async {
  Get.offAndToNamed(Routes.LOGIN);
}

class MyCustomSplashScreen extends StatefulWidget {
  @override
  _MyCustomSplashScreenState createState() => _MyCustomSplashScreenState();
}

class _MyCustomSplashScreenState extends State<MyCustomSplashScreen>
    with TickerProviderStateMixin {
  double _containerSize = 50;
  double _containerOpacity = 0.0;

  late AnimationController _controller;
  late Animation<double> animation1;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    _controller.forward();

    Timer(Duration(seconds: 1), () {
      setState(() {
        _containerSize = 2;
        _containerOpacity = 1;
      });
    });
    Timer(Duration(seconds: 2), () {
      load();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 2000),
          curve: Curves.fastLinearToSlowEaseIn,
          opacity: _containerOpacity,
          child: AnimatedContainer(
              duration: Duration(milliseconds: 2000),
              curve: Curves.fastLinearToSlowEaseIn,
              height: _width / _containerSize,
              width: _width / _containerSize,
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/logow.png',
                height: 100,
              )),
        ),
      ),
    );
  }
}

class PageTransition extends PageRouteBuilder {
  final Widget page;

  PageTransition(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: Duration(milliseconds: 2000),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.fastLinearToSlowEaseIn,
              parent: animation,
            );
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
}
