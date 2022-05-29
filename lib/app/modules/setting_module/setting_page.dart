import 'package:almarry_ex/app/modules/setting_module/setting_controller.dart';
import 'package:almarry_ex/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class settingPage extends GetView<settingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('خصائص التطبيق')),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              InkWell(
                onTap: () => controller.updateUser(
                    User.fromJson(stg.read('user') as Map<String, dynamic>)),
                highlightColor: grayColor,
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              User.fromJson(
                                      stg.read('user') as Map<String, dynamic>)
                                  .name!,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          Text(
                            User.fromJson(
                                    stg.read('user') as Map<String, dynamic>)
                                .phone!,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(
                        Icons.person,
                        size: 45,
                      )
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {
                  Get.isDarkMode
                      ? Get.changeThemeMode(ThemeMode.light)
                      : Get.changeThemeMode(ThemeMode.dark);
                  controller.canUseDark(!stg.read('isDark'));
                  stg.write('isDark', !stg.read('isDark'));
                  controller.update();
                },
                highlightColor: accentColor,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: <Widget>[
                      Text("الوضع الداكن".tr,
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Spacer(),
                      Checkbox(
                        value: controller.canUseDark.value,
                        activeColor: primaryColor,
                        checkColor: Colors.white,
                        splashRadius: 5,
                        tristate: true,
                        visualDensity: VisualDensity.comfortable,
                        onChanged: (bool? value) {
                          Get.isDarkMode
                              ? Get.changeThemeMode(ThemeMode.light)
                              : Get.changeThemeMode(ThemeMode.dark);
                          controller.canUseDark(!stg.read('isDark'));
                          stg.write('isDark', !stg.read('isDark'));
                          controller.update();
                        },
                      ).paddingZero,
                    ],
                  ),
                ),
              ),
              User.fromJson(stg.read('user') as Map<String, dynamic>).isAdmin!
                  ? Column(
                      children: [
                        Divider(),
                        ListTile(
                          title: Text('المستخدمين'),
                          leading: Icon(Icons.people_alt),
                          onTap: () => Get.toNamed(Routes.USERS),
                        ),
                        Divider(),
                        ListTile(
                          title: Text('المدن والعملات'),
                          leading: Icon(Icons.workspaces_outline),
                          onTap: () => Get.toNamed(Routes.CITY_CURRANCY),
                        ),
                      ],
                    )
                  : SizedBox()
            ]),
      ),
    );
  }
}
