import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class settingController extends GetxController {
  var canUseDark = false.obs;
  var formKey = GlobalKey<FormState>().obs;
  var name = TextEditingController().obs;
  var phone = TextEditingController().obs;
  var pin = TextEditingController().obs;
  var nodes = <FocusNode>[].obs;
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  CollectionReference cites = FirebaseFirestore.instance.collection("cites");

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    nodes.add(new FocusNode());
    nodes.add(new FocusNode());
    nodes.add(new FocusNode());
    cites.get().then((value) {
      for (var cv in value.docs) {
        //print(cv.data());
        var b = Cites.fromJson(cv.data() as Map<String, dynamic>);
        print(b.toJson());
      }
    });
    if (stg.read('isDark') != null) {
      canUseDark(stg.read('isDark'));
    } else
      stg.write('isDark', false);
  }

  updateUser(User user) {
    var iddc = '';
    users
        .where("phone", isEqualTo: user.phone)
        .where("password", isEqualTo: user.password)
        .get()
        .then((value) {
      iddc = value.docs.first.id;
    });
    name.value.text = user.name!;
    phone.value.text = user.phone!;
    pin.value.text = user.password!;
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
            color: Get.isDarkMode ? ThemeData.dark().cardColor : Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'تحديث بياناتي'.tr,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(),
                  SizedBox(),
                  SizedBox(),
                  InkWell(
                      onTap: () => Get.back(),
                      highlightColor: grayColor,
                      child: Ink(
                        child: Text('إغلاق'.tr,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ))
                ],
              ),
              Form(
                key: formKey.value,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      TextInputField(
                        hint: 'الاسم'.tr,
                        focusNode: nodes[0],
                        textEditingController: name.value,
                        inputAction: TextInputAction.next,
                        inputType: TextInputType.text,
                      ),
                      TextInputField(
                        hint: 'رقم الجوال'.tr,
                        focusNode: nodes[1],
                        textEditingController: phone.value,
                        inputAction: TextInputAction.done,
                        inputType: TextInputType.phone,
                        isValidator: false,
                        checkValidator: (String? fieldContent) {
                          String sn = fieldContent!.substring(0, 2);
                          if (fieldContent.isEmpty) {
                            return 'الحقل مطلوب'.tr;
                          } else if (phone.value.text.length > 9) {
                            return 'يجب ان يكون طول الحقل اقل او يساوي 9 ارقام'
                                .tr;
                          } else if (!fieldContent.isNum) {
                            return 'يجب ان يحتوي على ارقام فقط'.tr;
                          } else if (!(fieldContent.startsWith('7') ||
                              fieldContent.startsWith('0'))) {
                            return 'يجب ان يبدأ بـ77 او 71 او 73 او 70 او 0'.tr;
                          } else if (fieldContent.startsWith('7')) {
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
                                : 'يجب ان يبدأ بـ77 او 71 او 73  او 70'.tr;
                          }
                          return null;
                        },
                        tif: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        ],
                      ),
                      TextInputField(
                        hint: 'كملة المرور'.tr,
                        focusNode: nodes[2],
                        textEditingController: pin.value,
                        inputAction: TextInputAction.done,
                        inputType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RoundedButton(
                        color: primaryColor,
                        buttonName: 'حفظ'.tr,
                        function: () async {
                          if (formKey.value.currentState!.validate()) {
                            formKey.value.currentState!.save();
                            connect().then((value) async {
                              if (value) {
                                users.get().then((value) {
                                  user.name = name.value.text.trim();
                                  user.password = pin.value.text.trim();
                                  user.phone = phone.value.text.trim();
                                  Get.back();
                                  users
                                      .doc(iddc)
                                      .set(user.toJson())
                                      .whenComplete(() {
                                    Get.snackbar('رسالة'.tr,
                                        'تم تحديث البيانات بنجاح'.tr,
                                        backgroundColor: Colors.green,
                                        duration: Duration(seconds: 5),
                                        colorText: Colors.white);
                                  });
                                });
                              } else {
                                noconnect();
                              }
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      elevation: 2,
      isScrollControlled: true,
    );
  }
}
