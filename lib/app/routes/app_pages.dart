import '../../app/modules/history_module/history_page.dart';
import '../../app/modules/history_module/history_bindings.dart';
import '../../app/modules/city_currancy_module/city_currancy_page.dart';
import '../../app/modules/city_currancy_module/city_currancy_bindings.dart';
import '../../app/modules/users_module/users_page.dart';
import '../../app/modules/users_module/users_bindings.dart';
import 'package:almarry_ex/app/modules/setting_module/setting_bindings.dart';
import 'package:almarry_ex/app/modules/setting_module/setting_page.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/modules/home_module/home_bindings.dart';
import '../../app/modules/home_module/home_page.dart';
import '../../app/modules/login_module/login_bindings.dart';
import '../../app/modules/login_module/login_page.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
        name: Routes.LOGIN,
        page: () => loginPage(),
        binding: loginBinding(),
        curve: Curves.fastOutSlowIn,
        showCupertinoParallax: true,
        transitionDuration: Duration(milliseconds: 1000),
        alignment: Alignment.centerLeft,
        transition: Transition.fade),
    GetPage(
        name: Routes.HOME,
        page: () => homePage(),
        binding: homeBinding(),
        curve: Curves.fastOutSlowIn,
        showCupertinoParallax: true,
        transitionDuration: Duration(milliseconds: 1000),
        alignment: Alignment.centerLeft,
        transition: Transition.zoom),
    GetPage(
        name: Routes.SETTING,
        page: () => settingPage(),
        binding: settingBinding(),
        curve: Curves.fastOutSlowIn,
        showCupertinoParallax: true,
        transitionDuration: Duration(milliseconds: 1000),
        alignment: Alignment.centerLeft,
        transition: Transition.zoom),
    GetPage(
      name: Routes.USERS,
      page: () => usersPage(),
      binding: usersBinding(),
    ),
    GetPage(
      name: Routes.CITY_CURRANCY,
      page: () => cityCurrancyPage(),
      binding: cityCurrancyBinding(),
    ),
    GetPage(
      name: Routes.HISTORY,
      page: () => historyPage(),
      binding: historyBinding(),
    ),
  ];
}
