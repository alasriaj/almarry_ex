import 'package:almarry_ex/app/modules/login_module/login_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class loginPage extends GetView<loginController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.context = context;
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'بورصة المري'.tr,
          ),
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 40,
            ),
            Image.asset(
              'assets/images/logo.png',
              height: 80,
            ),
            SizedBox(
              height: 10,
            ),
            Image.asset(
              'assets/images/almlname.png',
              height: 35,
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Form(
                key: controller.formKey.value,
                child: Column(
                  children: [
                    TextInputField(
                      hint: 'رقم الجوال'.tr,
                      focusNode: controller.nodes[0],
                      textEditingController: controller.phone.value,
                      inputAction: TextInputAction.next,
                      inputType: TextInputType.phone,
                      isValidator: true,
                      checkValidator: (String? fieldContent) {
                        if (fieldContent!.isEmpty) {
                          return 'الحقل مطلوب'.tr;
                        } else if (fieldContent.length < 9) {
                          return 'يجب ان يكون طول الحقل 9 ارقام'.tr;
                        } else if (!fieldContent.isNum) {
                          return 'يجب ان يحتوي على ارقام فقط'.tr;
                        } else if (!fieldContent.startsWith('7')) {
                          return 'يجب ان يبدأ بـ77 او 71 او 73 او 70'.tr;
                        } else if (fieldContent.startsWith('7')) {
                          String sn = fieldContent.substring(0, 2);
                          bool val = false;
                          if (sn == '77' ||
                              sn == '71' ||
                              sn == '73' ||
                              sn == '70') {
                            val = true;
                          } else
                            val = false;
                          return val
                              ? null
                              : 'يجب ان يبدأ بـ77 او 71 او 73 او 70'.tr;
                        }
                        return null;
                      },
                      max: 9,
                      tif: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                    ),
                    TextInputField(
                      hint: 'كلمة المرور'.tr,
                      focusNode: controller.nodes[1],
                      textEditingController: controller.pin.value,
                      inputAction: TextInputAction.done,
                      inputType: TextInputType.text,
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RoundedButton(
                      buttonName: 'تسجيل دخول'.tr,
                      color: primaryColor,
                      isrequest: controller.isLoading.value,
                      function: () => controller.login(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
